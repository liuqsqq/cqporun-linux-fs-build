#!/bin/bash -e


USERNAME="cqutprint"


# Directory contains the target rootfs
TARGET_ROOTFS_DIR="cqporun-yinka-image-v1.1"

if [ ! -e ubuntu*.tar.gz ]; then
        echo "\033[36m Run build-fs-base.sh first \033[0m"
        exit -1
fi

# create target dir and clean
if [  -e $TARGET_ROOTFS_DIR ]; then
        rm -rf  $TARGET_ROOTFS_DIR
fi

echo -e "\033[36m -------- Make rootfs target dir -------- \033[0m"
mkdir $TARGET_ROOTFS_DIR

finish() {
        sudo umount $TARGET_ROOTFS_DIR/dev
        exit -1
}
trap finish ERR

echo -e "\033[36m Extract image \033[0m"

sudo tar -xpf ubuntu*.tar.gz  --strip-components 1  -C $TARGET_ROOTFS_DIR 

sudo cp -av ./preset/ $TARGET_ROOTFS_DIR/


echo -e "\033[36m Change root.....................\033[0m"
sudo cp /usr/bin/qemu-arm-static $TARGET_ROOTFS_DIR/usr/bin/
sudo mount -o bind /dev $TARGET_ROOTFS_DIR/dev

cat << EOF | sudo chroot $TARGET_ROOTFS_DIR

usermod -a -G netdev $USERNAME
# install wicd\dhcp server\screen split tool\print\usb-4g
apt update && apt upgrade -y
apt -f -y install 
apt install -y isc-dhcp-server devilspie wicd cups hplip usb-modeswitch 



# overlay the presets
echo -e "\033[5m\033[34m -------- Extract presets -------- \033[0m"
cp -av ./preset/overlay/* /
cp -av ./preset/user/. /home/$USERNAME/

# remove package cache
echo -e "\033[5m\033[34m -------- Remove none needed packages -------- \033[0m"
rm -rvf /preset

EOF

sudo umount $TARGET_ROOTFS_DIR/dev
