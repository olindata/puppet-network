class network {

  case $::operatingsystem {
    centos,fedora,rhel: {
      include network::redhat
    }
    debian,ubuntu: {
      include network::debian
    }
    default: {
      err "${::operatingsystem} is not yet supported for the network module."
    }
  }
}
