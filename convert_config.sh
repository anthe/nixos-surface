#cat kernel-configs/4.19/generated/ubuntu-surface-4.19-x86_64.config | sed -e 's/.*".*//' -e "s/=/ /" -e "s/CONFIG_//" -e "/^#.*/d" -e "/^$/d" -e "s/[[:space:]]*$//" -e "s/^[[:space:]]*//" > kernel-config
cat $1 | sed -e 's/.*".*//' -e "s/=/ /" -e "s/CONFIG_//" -e "/^#.*/d" -e "/^$/d" -e "s/[[:space:]]*$//" -e "s/^[[:space:]]*//" > kernel-config
