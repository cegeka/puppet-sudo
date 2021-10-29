class sudo::params () {

  case $::osfamily {
    'RedHat': {
      $package = 'sudo'
      $config_dir = '/etc/sudoers.d'
      $config_file = '/etc/sudoers'
      $config_file_includes = [
        '#includedir /etc/sudoers.d/host_aliases',
        '#includedir /etc/sudoers.d/user_aliases',
        '#includedir /etc/sudoers.d/cmnd_aliases',
        '#includedir /etc/sudoers.d/runas_aliases',
        '#includedir /etc/sudoers.d/defaults/global',
        '#includedir /etc/sudoers.d/defaults/env',
        '#includedir /etc/sudoers.d/defaults/cmnd',
        '#includedir /etc/sudoers.d/defaults/host',
        '#includedir /etc/sudoers.d/defaults/runas',
        '#includedir /etc/sudoers.d/defaults/user',
        '#includedir /etc/sudoers.d/users',
      ]
      $purge_unmanaged_sudo_rules = true
    }
    default: {
      fail("Class[sudo::params]: osfamily ${::osfamily} is not supported")
    }
  }

}
