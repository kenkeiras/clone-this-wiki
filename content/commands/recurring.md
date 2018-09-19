# Recurring commands

## Bridge two TCP ports

Connect local port `9999` to `22` on `192.168.1.2`. [More documentation](http://www.dest-unreach.org/socat/) 

    socat tcp-listen:9999,reuseaddr,fork tcp-connect:192.168.1.2:22
