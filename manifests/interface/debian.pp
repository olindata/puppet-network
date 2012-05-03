define network::interface::debian(
    $hostname,
    $ipaddress,
    $netmask,
    $network,
    $gateway = '',
    $broadcast,
    $macaddress,
    $routes_file = '',
    $ensure,
    $order = 10) {

  $interface = $name

  $onboot = $ensure ? {
    up      => 'yes',
    down    => 'no',
    default => 'yes'
  }

  concat::fragment { "network_interface_${name}":
    target  => '/etc/network/interfaces',
    ensure  => $ensure,
    order   => $order,
    content => template('network/interfaces.erb')    
  }
  
}
