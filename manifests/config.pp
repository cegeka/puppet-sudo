class sudo::config (
  $config_file_includes = $sudo::params::config_file_includes,
  $purge_unmanaged_sudo_rules = $sudo::params::purge_unmanaged_sudo_rules,
) {

  include sudo::params

  file { $sudo::params::config_file :
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0440',
    content => template("${module_name}/sudoers_conf.erb")
  }

  file { $sudo::params::config_dir :
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0550',
    recurse => true,
    purge   => $purge_unmanaged_sudo_rules
  }

  file { 'sudoers/host_aliases' :
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0550',
    path    => "${sudo::params::config_dir}/host_aliases",
    require => File[$sudo::params::config_dir]
  }

  file { 'sudoers/user_aliases' :
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0550',
    path    => "${sudo::params::config_dir}/user_aliases",
    require => File[$sudo::params::config_dir]
  }

  file { 'sudoers/cmnd_aliases' :
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0550',
    path    => "${sudo::params::config_dir}/cmnd_aliases",
    require => File[$sudo::params::config_dir]
  }

  file { 'sudoers/runas_aliases' :
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0550',
    path    => "${sudo::params::config_dir}/runas_aliases",
    require => File[$sudo::params::config_dir]
  }

  file { 'sudoers/defaults' :
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0550',
    path    => "${sudo::params::config_dir}/defaults",
    require => File[$sudo::params::config_dir]
  }

  file { 'sudoers/defaults/cmnd' :
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0550',
    path    => "${sudo::params::config_dir}/defaults/cmnd",
    require => File['sudoers/defaults']
  }

  file { 'sudoers/defaults/env' :
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0550',
    path    => "${sudo::params::config_dir}/defaults/env",
    require => File['sudoers/defaults']
  }

  file { 'sudoers/defaults/global' :
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0550',
    path    => "${sudo::params::config_dir}/defaults/global",
    require => File['sudoers/defaults']
  }

  file { 'sudoers/defaults/host' :
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0550',
    path    => "${sudo::params::config_dir}/defaults/host",
    require => File['sudoers/defaults']
  }

  file { 'sudoers/defaults/runas' :
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0550',
    path    => "${sudo::params::config_dir}/defaults/runas",
    require => File['sudoers/defaults']
  }

  file { 'sudoers/defaults/user' :
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0550',
    path    => "${sudo::params::config_dir}/defaults/user",
    require => File['sudoers/defaults']
  }

  file { 'sudoers/users' :
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0550',
    path    => "${sudo::params::config_dir}/users",
    require => File[$sudo::params::config_dir]
  }

}
