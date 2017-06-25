**mount.sh**

    # Launch this on the chrooted root
    set -euo pipefail
    USER=user

    sudo mount -o bind /dev/ dev/
    sudo mount -o bind /dev/pts dev/pts
    sudo mount -o bind /dev/shm dev/shm
    sudo mount -o bind /proc/ proc/
    sudo mount -o bind /sys/ sys/
    sudo mount -o bind /var/run/dbus/ var/run/dbus
    sudo mount -o bind /run/ run
    sudo chown 1000 -R run/user/1000/
    
    cp $HOME/.Xauthority home/$USER
    rm -Rf home/$USER/.config/pulse/
    cp -Rv $HOME/.config/pulse/ home/$USER/.config/pulse/
    sudo chown 1000 -R home/$USER/.config/
