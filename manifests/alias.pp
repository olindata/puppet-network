define network::alias(
		$ipaddress,
		$netmask,
		$network,
		$broadcast,
		$ensure) {

  case $::operatingsystem {
    centos,fedora,rhel: {
      network::alias::redhat{ $name:
        ipaddress   => $ipaddress,
        netmask     => $netmask,
        network     => $network,
        broadcast   => $broadcast,
        ensure      => $ensure
      }
    }
    debian,ubuntu: {
      network::alias::debian{ $name:
        ipaddress   => $ipaddress,
        netmask     => $netmask,
        network     => $network,
        broadcast   => $broadcast,
        ensure      => $ensure
      }
    }
    default: {
      err "${::operatingsystem} is not yet supported for the network module."
    }
  }
}
