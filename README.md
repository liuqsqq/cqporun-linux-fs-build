# cqporun-linux-fs-build
#introduction
This is chongqing porun SDK's rootfs build script.
#usage
sudo ./bulid-fs-full.sh
then, you will get a dir named cqporun-yinka-image-vx.x which is the result.
Note:
you maybe have to wait for a little long time because the production of base file system 
if you dont't have a base file system named ubuntu_base.tar.gz in rootdir
#version
20170401
#ChangLog
20170104 - first commit
20170307 - 
1、fix some bugs of the shell,change usr/->user/
2、del some useless files
20170308 - 
1、add .gitmodules to prepare base filesystem for full filesystem 
2、add prebuild dir and yinka-utils_1.0-2ubuntu2_armhf.deb
3、modify build-fs-full.sh for .gitmodules
20170401
1、add hdmi hot-plug detection
#Next
The acquired system is not very well,you will also need to setup somethings in destop
I will change it
    
    
