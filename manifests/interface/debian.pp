define network::interface::debian(
    $ensure,
    $ipaddress,
    $netmask,
    $type,
    $hostname     = '',
    $network      = '',
    $gateway      = '',
    $broadcast    = '',
    $macaddress   = '',
    $routes_file  = '',
    $order        = 10) {
      
  validate_re($type, '^(static|loopback)$')

  $interface = $name

  concat::fragment { "network_interface_${name}":
    target  => '/etc/network/interfaces',
    ensure  => $ensure,
    order   => $order,
    content => template('network/interfaces.erb')    
  }
  
}
