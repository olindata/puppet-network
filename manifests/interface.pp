define network::interface(
    $ensure,
    $ipaddress,
		$netmask,
    $hostname    = '',
		$network     = '',
		$gateway     = '',
		$broadcast   = '',
		$macaddress  = '',
		$routes_file = '',
		$type        = 'static',
    $custom_template = '') {

  case $::operatingsystem {
    centos,fedora,rhel: {
      network::interface::redhat{ $name:
        hostname    => $hostname,
        ipaddress   => $ipaddress,
        netmask     => $netmask,
        network     => $network,
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
        ensure      => $ensure,
        type        => $type,
        custom_template => $custom_template,
      }
    }
    default: {
      err "${::operatingsystem} is not yet supported for the network module."
    }
  }
}
