You may want to do this inside a [unpriviledged container](setup-unprivileged-lxc.md), just 'cause...

**Distro**: alpine linux

Update repositories

    / # /sbin/apk update
    fetch http://dl-cdn.alpinelinux.org/alpine/v3.5/main/x86_64/APKINDEX.tar.gz
    [...]
    OK: 7961 distinct packages available
    
    
Install prosody

    / # /sbin/apk add prosody
    (1/10) Installing lua5.1-socket (3.0_rc1_git20160306-r2)
    [...]
    OK: 9 MiB in 26 packages

Configuration ([mostly this](http://prosody.im/doc/configure)), editing `/etc/prosody/prosody.cfg.lua`

* Add a virtualhost, look for virtualhost and set it

        


