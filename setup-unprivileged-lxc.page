# How to setup an LXC installation for unprivileged users

This shows how to allow a user `gitit` to create and run `lxc` containers without root privileges.

*This should work for any modern ubuntu/debian out of the box, other distros may need some patch.*
*Mostly taken from [Stéphane Graber's website](https://stgraber.org/2014/01/17/lxc-1-0-unprivileged-containers/)*

## As root

* Install LXC tools (for normal LXC) and uidmap (for unprivileged operation)

`apt install lxc-dev uidmap bridge-utils`

* Create an user to be allowed unprivileged containers

`adduser gitit`

* Assign the user a set of uids and gids:

```
usermod --add-subuids 100000-165536 gitit
usermod --add-subgids 100000-165536 gitit
```

* Create a bridge interface

`brctl addbr lxcbr0`

`ifconfig  lxcbr0 10.0.3.1`

* Forward packages

`echo 1 > /proc/sys/net/ipv4/ip_forward`

* Configure LXC networking for the user 

```
echo 'gitit veth lxcbr0 10' >> /etc/lxc/lxc-usernet
```

Write in `/etc/lxc/default.conf`:

```
lxc.network.type = veth
lxc.network.link = lxcbr0
lxc.network.flags = up
lxc.network.hwaddr = 00:16:3e:xx:xx:xx
```

Write in `/etc/default/lxc-net`:

```
USE_LXC_BRIDGE="true"
LXC_BRIDGE="lxcbr0"
LXC_ADDR="10.0.3.1"
LXC_NETMASK="255.255.255.0"
LXC_NETWORK="10.0.3.0/24"
LXC_DHCP_RANGE="10.0.3.2,10.0.3.254"
LXC_DHCP_MAX="253"
LXC_DHCP_CONFILE=""
LXC_DOMAIN=""
```

## As the user creating the unprivileged 
(After `su gitit`)

* Configure the lxc template: in `~/.config/lxc/default.conf` write:

```
lxc.network.type = veth
lxc.network.link = lxcbr0
lxc.network.flags = up
lxc.network.hwaddr = 00:16:3e:xx:xx:xx
lxc.id_map = u 0 100000 65536
lxc.id_map = g 0 100000 65536
```

Now the user should be able to create a container without root privileges:

`lxc-create -t download -n gitit-container -- -d debian -r sid -a amd64`

## Potential errors

* `lxc-create: utils.c: mkdir_p: 253 Permission denied - failed to create directory '/run/user/0/lxc/'`

To solve this unset the variables starting with XDG, as the user:

```
gitit@codigoparallevar:~$ env|grep XDG
XDG_SESSION_ID=3943
XDG_RUNTIME_DIR=/run/user/0
gitit@codigoparallevar:~$ unset XDG_SESSION_ID 
gitit@codigoparallevar:~$ unset XDG_RUNTIME_DIR
gitit@codigoparallevar:~$ env|grep XDG
gitit@codigoparallevar:~$ 
```

* ```
unshare: Operation not permitted
read pipe: Permission denied
lxc-create: lxccontainer.c: do_create_container_dir: 985 Failed to chown container dir
```

As root 
```
echo 1 > /sys/fs/cgroup/cpuset/cgroup.clone_children
echo 1 > /proc/sys/kernel/unprivileged_userns_clone
```
