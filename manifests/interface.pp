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

  case $::operatingsystem {
    centos,fedora,rhel: {
      network::interface::redhat{ $name:
        hostname    => $hostname,
        ipaddress   => $ipaddress,
        netmask     => $netmask,
        network     => $network,
        gateway     => $gateway,
        broadcast   => $broadcast,
        macaddress  => $macaddress,
        routes_file => $routes_file,
        ensure      => $ensure
      }
    }
    debian,ubuntu: {
      network::interface::debian{ $name:
        hostname    => $hostname,
        ipaddress   => $ipaddress,
        netmask     => $netmask,
        network     => $network,
        gateway     => $gateway,
        broadcast   => $broadcast,
        macaddress  => $macaddress,
        routes_file => $routes_file,
        ensure      => $ensure
      }
    }
    default: {
      err "${::operatingsystem} is not yet supported for the network module."
    }
  }
}
