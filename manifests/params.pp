class sudo::params {

  case $::osfamily {
    'RedHat': {
      $package = 'sudo'
      $config_dir = '/etc/sudoers.d'
      $config_file = '/etc/sudoers'
    }
    default: {
      fail("Class[sudo::params]: osfamily ${::osfamily} is not supported")
    }
  }

}
