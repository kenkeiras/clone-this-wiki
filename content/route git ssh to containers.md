# Route ssh git user to a specific container

Maybe you have a server which is hosting a git service, and you want to be able
to use port 22 for accessing the server ssh while also being able to use
ssh keys to push to git (without further configuration). Let's see how can we
do this.

## Software used

 * [tg123's sshpiper](https://github.com/tg123/sshpiper)

## Configuring the host ssh in a different port

`sshpiper` will take the connection on port 22, so let's move
the server's `openssh` service to another port.

Edit `/etc/ssh/sshd_config`, look for a like line `Port 22`
(or create it) and chage it to `Port 1022`, then run `systemctl reload sshd`.

Even after this operation the connection should still be open, but
from here on, and until the `sshpiper` is configured we'll have to
connect to our server pointing to that port, with `ssh -p 1022 user@server`.

## Installing and configuring sshpiper

First things first, you'll make a program handle the authentication of one
(or several) of your servers, right? So you really should take a look at
[how sshpiper works](https://github.com/tg123/sshpiper/blob/master/README.md)
to *at least* have a general understanding. There's no hurry, I'll be here
when you finish.

### Installation

Install `golang`, on debian-derived distros: `sudo apt install golang` (and configure golang)

Download and install [tg123's sshpiper](https://github.com/tg123/sshpiper)

    go get github.com/tg123/sshpiper/sshpiperd
    go install github.com/tg123/sshpiper/sshpiperd

### Base configuration

We'll create a workdir directory, in there we'll define the following rules:

    | Incoming | Outgoing user@server:port |
    |----------|---------------------------|
    | root     | root@localhost:1022       |
    | gitea    | gitea@git.server:22       |

For this, create a directory `piper-workdir` (can be any name) and create
a directory inside for each accepted user:

    $ tree piper-workdir/
    piper-workdir/
    ├── gitea
    └── root

    2 directories, 0 files

Ok, now we'll have to fill this directories with some files, to understand
why this files are needed we have to keep in mind how `sshpiper` works.
After this is setup, the connections will flow like this

    Client       SSH piper
       1.
    -->-------->-| Receives connection, decodes it (needed to know the user)
                 | And reencodes it, sending it again
                 |       2.
                 |--------->---------->-------->---------> Final server


Keep in mind that in this schema, the `sshpiper` server can read when goes through it! (And can record it if launched with `--record_typescript`).

### Workdir files

So, having the previous in mind (and with the goal of a public-key based authentication), each user directory on the workdir needs 4 files:

* `sshpiper_upstream`: Information about where to make the connection to.
* `authorized_keys`: To allow authentication with that user based on a SSH public key.
* `id_rsa` & `id_rsa.pub`: A SSH public/private key pair for the second part of the communication.

#### sshpiper_upstream

This file only requires a single non-empty line with the following
syntax, pointing to the server where the communication will be forwarded:

    [user@]upstream-server[:22]

The default user will be the one that made the original
connection, and the default port `22` (the default SSH one).

Comment lines can be added starting them with `#`.

For example, the `sshpiper_upstream` file for root might be

    # Pipe the root user to the local server (now on port 1022)
    root@localhost:1022

#### Authorized keys

A list of the public keys that are allowed to use that user, you
can obtain one for the key in your local machine doing

    cat ~/.ssh/id_rsa.pub

(If that command fails, run `ssh-keygen` before).

New keys can be appended at the end of the file, just adding
a line jump between different keys.

#### id_rsa

A public/private SSH key pair, can be generated like this

    ssh-keygen -f workdir/USER/id_rsa

Keep in mind that the `id_rsa.pub` on will have to be added
to the `~/.ssh/authorized_keys` of the target machine.
This is unless it has another way to add the keys,
like git web interfaces (github, gitlab, gitea, ...)

### Final result

The final result should be something like this


    $ tree piper-workdir/
    piper-workdir/
    ├── gitea
    │   ├── authorized_keys
    │   ├── id_rsa
    │   ├── id_rsa.pub
    │   └── sshpiper_upstream
    └── root
        ├── authorized_keys
        ├── id_rsa
        ├── id_rsa.pub
        └── sshpiper_upstream

    2 directories, 8 files

## Running the piper

After this step is completed, only remains to launch
`sshpiper`, this can be done like


    $GOPATH/bin/sshpiperd -p 22 -w piper-workdir/
    SSHPiper ver: DEV by Boshi Lian<farmer1992@gmail.com>
    https://github.com/tg123/sshpiper

    go runtime  : go1.7.4
    git hash    : 0000000000

    Listening             : 0.0.0.0:22
    Server Key File       : /etc/ssh/ssh_host_rsa_key
    Working Dir           : piper-workdir/
    Additional Challenger :
    Logging file          : stdout

    2018/02/07 00:50:49 SSHPiperd started
    ...
