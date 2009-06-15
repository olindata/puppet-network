define network::alias(
		$ipaddress,
		$netmask,
		$network,
		$broadcast,
		$ensure) {
	$interface = $name

	$onboot = $ensure ? {
		up => "yes",
		down => "no"
	}

	file { "/etc/sysconfig/network-scripts/ifcfg-$interface":
		owner => root,
		group => root,
		mode => 600,
		content => template("network/sysconfig/network-scripts/ifcfg.interface.alias.erb"),
		alias => "ifcfg-$interface"
	}

	case $ensure {
		up: {
			exec { "/sbin/ifdown $interface; /sbin/ifup $interface":
				subscribe => File["ifcfg-$interface"],
				refreshonly => true
			}
		}

		down: {
			exec { "/sbin/ifdown $interface":
				subscribe => File["ifcfg-$interface"],
				refreshonly => true
			}
		}
	}
}
