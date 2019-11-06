cp $1 surface_nixos.config
sed -i "s/=/ /" surface_nixos.config
sed -i 's/^.*"/#&/' surface_nixos.config
sed -i "s/CONFIG_//" surface_nixos.config
