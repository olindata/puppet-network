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
      err "network aliases on ${::operatingsystem} function the same way like normal interfaces, please use network::interface instead."
    }
    default: {
      err "${::operatingsystem} is not yet supported for the network module."
    }
  }
}
