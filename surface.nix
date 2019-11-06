{config, lib, pkgs, ... }:
{ 
  nixpkgs.overlays = [(self: super: {
    libwacom = super.callPackage ./surface_libwacom.nix {};
    surface_firmware = super.callPackage ./surface_firmware.nix {};
    surface_kernel = super.linuxPackages_latest.extend( self: (ksuper: {
      kernel = ksuper.kernel.override {
        kernelPatches = [
          { patch = linux-surface/patches/5.3/0001-surface-acpi.patch; name = "surface-acpi"; }
          { patch = linux-surface/patches/5.3/0002-buttons.patch; name = "buttons"; }
          { patch = linux-surface/patches/5.3/0003-surfacebook2-dgpu.patch; name = "surfacebook2-dgpu"; }
          { patch = linux-surface/patches/5.3/0004-hid.patch; name = "hid"; }
          { patch = linux-surface/patches/5.3/0005-surface3-power.patch; name = "surface3-power"; }
          { patch = linux-surface/patches/5.3/0006-surface-lte.patch; name = "surface-lte"; }
          { patch = linux-surface/patches/5.3/0007-wifi.patch; name = "wifi"; }
          { patch = linux-surface/patches/5.3/0008-legacy-i915.patch; name = "legacy-i915"; }
          { patch = linux-surface/patches/5.3/0009-ipts.patch; name = "ipts"; }
          { patch = linux-surface/patches/5.3/0010-ioremap_uc.patch; name = "ioremap_uc"; }
        ];
        extraConfig = (builtins.readFile ./surface_nixos.config);
      };
    }));
  })];

  hardware.firmware = [ pkgs.surface_firmware ];

  boot = {
    blacklistedKernelModules = [ "surfacepro3_button" "nouveau" ];
    #blacklistedKernelModules = [ "surfacepro3_button" ];
    kernelPackages = pkgs.surface_kernel;
    #extraModulePackages = [ pkgs.surface_kernel.bbswitch ];
    extraModprobeConfig = (builtins.readFile ./linux-surface/root/etc/modprobe.d/snd-hda-intel.conf) + (builtins.readFile ./linux-surface/root/etc/modprobe.d/soc-button-array.conf);
    initrd = {
      kernelModules = [ "hid" "hid_sensor_hub" "i2c_hid" "hid_generic" "usbhid" "hid_multitouch" "intel_ipts" "surface_acpi" ];
      availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
    };
  };

  services.udev.packages = [ pkgs.surface_firmware pkgs.libwacom ];

  services.xserver.videoDrivers = [ "intel" ];
  #services.xserver.videoDrivers = [ "nouveau" ];
  # bbswitch doesn't load
  # switcheroo doesn't work
  # nvidia-smi doesn't detect any hardware, it might only detect it with X
  # lshw -C display does detect the graphics card
  # X loads nvidia, then unloads it due to GLX error, this is maybe the best place to start
  #hardware.bumblebee = {
    #enable = false;
    #driver = "nvidia";
    #pmMethod = "bbswitch";
  #};

  #hardware.nvidiaOptimus.disable = true;
  #hardware.opengl.extraPackages = [ pkgs.linuxPackages.nvidia_x11.out ];
  #hardware.opengl.extraPackages32 = [ pkgs.linuxPackages.nvidia_x11.lib32 ];
  #hardware.nvidia = {
  #  modesetting.enable = true;
  #  optimus_prime = {
  #    enable = true;
  #    intelBusId = "PCI:0:2:0";
  #    nvidiaBusId = "PCI:2:0:0";
  #  };
  #};
 
  networking.networkmanager = {
    enable = true;
    #packages = [ "ifupdown" "keyfile" "ofono" ];
    wifi = {
      scanRandMacAddress = false;
      powersave = true;
    };
  };

  environment.etc = { "systemd/sleep.conf".text = "SuspendState=freeze\n"; };

  powerManagement = {
    enable = true;
  };

  services.acpid = {
    enable = true;
    handlers = {
      lid = { action = ""; event = "button/lid.*"; };
    };
  };

  powerManagement.powerUpCommands = ''
    source /etc/profile
    echo 1 > /sys/bus/pci/rescan
    acpitool -W 2 >2 /dev/null
  '';

  powerManagement.powerDownCommands = ''
    source /etc/profile
    systemctl stop network-manager.service;
  '' +
    (builtins.readFile ./remove_modules); 

  powerManagement.resumeCommands = ''
    source /etc/profile
  '' +
  (builtins.readFile ./remove_modules) +
  (builtins.readFile ./insert_modules) + 
  ''
    echo 1 > /sys/bus/pci/rescan
    systemctl start network-manager.service;
    acpitool -W 2 >2 /dev/null
  '';
}
