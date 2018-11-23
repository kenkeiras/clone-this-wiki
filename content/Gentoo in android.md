At first I tried (and got it working) based on what's explained on [alicef's](https://blogs.gentoo.org/alicef/2017/01/03/zenfone-gentoo-prefix-part2/) blog.
https://forums.gentoo.org/viewtopic-t-956304-view-previous.html

Later, for non-related reasons I had to reinstall it again, so I'm documenting the steps here. The idea is to install a gentoo system inside a chroot in an android, preferrably in the sdcard. For this we'll need root in a terminal inside the host, getting root is your job and using `adb shell` for terminal works fine, but if you want to do it without exterior devices, check out [termux](https://termux.com/), you can even use it to install gnu screen inside android and use it from the `adb shell`... anyway, back to the point:

* Create a [F2FS](https://en.wikipedia.org/wiki/F2FS) filesystem we can use (sdcard probably is fat32, so it limits us a lot, this way we can use symlinks and the like, but not more than 2G disks):

        ~ # truncate -s 2G /sdcard/filesystem-eggs/gentoo.fs
        ~ # mkfs.f2fs /sdcard/filesystem-eggs/gentoo.fs
        
* Mount the filesystem

        ~ # mkdir /sdcard/filesystems/gentoo
        ~ # mount -o loop /sdcard/filesystem-eggs/gentoo.fs /sdcard/filesystems/gentoo

* Get an image to seed the filesystem

        ~ # wget http://distfiles.gentoo.org/releases/arm/autobuilds/current-stage3-armv7a/stage3-armv7a-20161129.tar.bz2
        ~ # tar -vjxf stage3-armv7a-20161129.tar.bz2 -C /sdcard/filesystems/gentoo/
        
        

