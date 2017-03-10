#!/bin/bash -e

# Home user name
USER_NAME="cqutprint"

# Lib name
LIB_DIR="lib"

# Base system name
BASE_SYSTEM_NAME="ubuntu_base.tar.gz"

# Directory contains the full rootfs
TARGET_ROOTFS_DIR="cqporun-yinka-image-v1.1"

# Make base system
function make_base_system() {
    # Make sure we have basic system-build tools
    if test ! -f $LIB_DIR/build-fs-base.sh;
    then
        echo "+ Setting up build-fs-base submodule"
        git submodule init
    fi
    git submodule update --init --recursive    

    if test ! -f $LIB_DIR/build-fs-base.sh;
    then
        echo There is something wrong with your source tree.
        echo You are missing $LIB_DIR/build-fs-base.h
        exit 1
    fi

    # make basic file-system
    cd $LIB_DIR 
    echo "entering into $LIB_DIR"
    sudo USERNAME=$USER_NAME BOARDNAME=rk3288 ./build-fs-base.sh
    
    sudo tar -czf $BASE_SYSTEM_NAME  ubuntu
    cd ..
    echo "leaveing $LIB_DIR "
    mv $LIB_DIR/$BASE_SYSTEM_NAME ./

}

if [ ! -e $BASE_SYSTEM_NAME ]; then
    make_base_system;
fi

if [ ! -e $BASE_SYSTEM_NAME ]; then
    echo "\033[36m Run build-fs-base.sh first or provide a base system file\033[0m"
    exit 1
fi

# create target dir and clean
if [  -e $TARGET_ROOTFS_DIR ]; then
    rm -rf  $TARGET_ROOTFS_DIR
fi

echo -e "\033[36m Make rootfs target dir \033[0m"
mkdir $TARGET_ROOTFS_DIR

finish() {
    echo "catch err, exit"
    sudo umount $TARGET_ROOTFS_DIR/dev
#    rm -rf $BASE_SYSTEM_NAME
    exit -1
}
trap finish ERR

echo -e "\033[36m Extract image \033[0m"

sudo tar -xpf $BASE_SYSTEM_NAME  --strip-components 1  -C $TARGET_ROOTFS_DIR 

sudo cp -av ./preset/ $TARGET_ROOTFS_DIR/
sudo cp -av ./prebuild/ $TARGET_ROOTFS_DIR/


echo -e "\033[36m Change root.....................\033[0m"
sudo cp /usr/bin/qemu-arm-static $TARGET_ROOTFS_DIR/usr/bin/
sudo mount -o bind /dev $TARGET_ROOTFS_DIR/dev

cat << EOF | sudo chroot $TARGET_ROOTFS_DIR

usermod -a -G netdev $USER_NAME
# install wicd\dhcp server\screen split tool\print-cups\usb-4g
apt update && apt upgrade -y
apt install -y isc-dhcp-server devilspie wicd cups hplip usb-modeswitch libnss3 libxss1 libncurses5-dev 
apt install -y python-bluez bluez-obexd expect
apt install -y openssh-server vsftpd

# install yinka-utils deb packages,include a plentys of tools ,eg: updater yinkad and so on
dpkg -i ./prebuild/yinka-utils_1.0-2ubuntu2_armhf.deb
dpkg -i ./prebuild/yinka-player_1.0.0-1_armhf.deb
apt -f -y install 



ln -s /usr/local/soft/autoprint/autoprint /usr/bin/autoprint
systemctl enable yinkad
systemctl enable yinka-updater

# overlay the presets
echo -e "\033[5m\033[34m -------- Extract presets -------- \033[0m"
cp -av ./preset/overlay/* /
cp -av ./preset/user/. /home/$USER_NAME/

# remove package cache
echo -e "\033[5m\033[34m -------- Remove none needed packages -------- \033[0m"
rm -rvf /preset
rm -rvf /prebuild

EOF

#rm -rf $BASE_SYSTEM_NAME
sudo umount $TARGET_ROOTFS_DIR/dev
