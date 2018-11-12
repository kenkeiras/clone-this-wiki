# How to add a new service to Systemd

Say we have a new service `gotify-reader` that we want to run on systemd. The steps to do so are the following:

**1.** Create a `/etc/systemd/system/gotify-reader.service` file with contents like the following:


    [Unit]
    Description=Start gotify-reader
    
    [Service]
    ExecStart=/usr/bin/start-gotify-reader
    
    [Install]
    # WantedBy=
    # ^ service/runlevel which needs this

This gives the minimal information that systemd needs to create the service:
 name (Description), how to operate it (ExecStart) and if it's needed
 for another one to work (WantedBy).

The exec script can be as simple as calling another script with certain
parameters, there's no special control needed for basic services.

**2.** Reload Systemd files `systemctl daemon-reload`.
This makes Systemd aware of the new configuration.

**Done!** Service can be now operated with `systemctl`.

    systemctl start gotify-reader   # Starts service
    systemctl restart gotify-reader # Restarts service
    systemctl stop gotify-reader    # Stops service
    
    # Enable automatically launching the service if another depends on it
    systemclt enable gotify-reader
