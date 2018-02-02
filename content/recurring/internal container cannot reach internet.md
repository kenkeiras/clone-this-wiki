# Internal container cannot reach Internet

Supposing you have connectivity to other addresses of the host,
probably you need to set up some kind of NAT.

There is plenty of ways to do it, (check links in the references).
One that requires little asumptions about the case is to `MASQUERADE`
the packets with `iptables`.

In this case the "NATed" network is `10.0.4.0/24`:

    iptables -t nat -A POSTROUTING -s 10.0.4.0/24 '!' -d 10.0.4.0/24 -j MASQUERADE

## References

[Linux 2.4 NAT HOWTO: Saying How To Mangle The Packets](https://www.netfilter.org/documentation/HOWTO/NAT-HOWTO.html#toc6.1)
