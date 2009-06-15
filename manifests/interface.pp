define network::interface(
		$hostname,
		$ipaddress,
		$netmask,
		$network,
		$gateway = "",
		$broadcast,
		$macaddress,
		$routes_file = "",
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
		content =>
			template("network/sysconfig/network-scripts/ifcfg.interface.erb"),
		ensure => present,
		alias => "ifcfg-$interface"
	} 

	if $gateway {
		file { "/etc/sysconfig/network":
			owner => root,
			group => root,
			mode => 600,
			content => template("network/sysconfig/network.erb"),
			ensure => present,
			alias => "network"
		}
	}

	case $ensure {
		up: {
			if $routes_file {
				$subscribes = [
					File["ifcfg-$interface"],
					File["network"],
					File["route-$interface"]
				]

				file { "/etc/sysconfig/network-scripts/route-$interface":
					owner => root,
					group => root,
					mode => 600,
					source => "puppet://$servername/network/sysconfig/network-scripts/route-$interface",
					ensure => present,
					alias => "route-$interface"
				}
			} else {
				$subscribes = [
					File["ifcfg-$interface"],
					File["network"]
				]
			}

			exec { "/sbin/ifdown $interface; /sbin/ifup $interface":
				subscribe => $subscribes,
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
