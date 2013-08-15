class network::redhat($gateway = '') {

  file { '/etc/sysconfig/network':
    owner => root,
    group => root,
    mode => 600,
    content => template('network/sysconfig/network.erb'),
    ensure => present,
    alias => 'network'
  }
  
}