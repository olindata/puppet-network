Usage
-----

    node "server.domain.com" inherits basenode {
        # physical interface
        network::interface { "eth0":
            hostname => "server.domain.com",
            ipaddress => "1.2.3.4",
            gateway => "1.2.3.1",
            netmask => "255.255.255.0",
            network => "1.2.3.0",
            broadcast => "1.2.3.255",
            macaddress => "ff:ff:ff:ff:ff:ff",
            ensure => up
        }
    
        # aliased interface
        network::alias { "eth0:1":
            ipaddress => "1.2.3.5",
            netmask => "255.255.255.0",
            network => "1.2.3.0",
            broadcast => "1.2.3.255",
            ensure => up
        }

        # vlan interface (e.g. VLAN30)
        network::vlan { "eth0.30":
            ipaddress => "1.2.30.5",
            netmask => "255.255.255.0",
            network => "1.2.30.0",
            broadcast => "1.2.30.255",
            ensure => up
        }
    }

Miscellaneous Notes
-------------------

Probably only works with RH-ish systems.
