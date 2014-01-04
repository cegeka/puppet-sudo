# Define: sudo::config::default_entry
#
# This manages sudo Defaults configurations
#
# Parameters:
# [*ensure*]
# Ensure if present or absent.
# Default: present
#
# [*type*]
# Type of default configuration snippet. Can be one of the following: global, cmnd, env, host, user, runas
# Default: global
#
# [*configuration*]
# Content of configuration snippet.
# Default: undef
#
# [*env_settings*]
# Content of env settings configuration snippet. Can only be used with type env.
# Default: []
#
# Actions:
# Installs sudo Defaults configuration
#
# Requires:
# Class sudo
# stdlib
#
# Sample Usage:
# sudo::config::default_entry { 'visiblepw' :
#   configuration => '!visiblepw'
# }
#
# [Remember: No empty lines between comments and class definition]
define sudo::config::default_entry(
  $ensure='present',
  $type='global',
  $configuration=undef,
  $env_settings=[]
) {

  validate_re($title, '^[A-Za-z0-9_\-.]+$', "Sudo::Config::Default_entry['${title}']: title value does not match ^[A-Za-z0-9_.]+$")

  #Class['sudo'] -> Sudo::Config::Default_entry[$title]

  case $ensure {
    'absent': {
      include sudo::params

      file { "sudo/config/defaults/${type}/${title}":
        ensure => $ensure,
        path   => "${sudo::params::config_dir}/defaults/${type}/${title}"
      }
    }
    'present': {
      if $configuration == undef and $type in ['cmnd', 'global', 'host', 'runas', 'user'] {
        fail("Sudo::Config::Default_entry['${title}']: required parameter configuration not specified for type in ['cmnd', 'global', 'host', 'runas', 'user']")
      }

      if !($type in ['cmnd', 'env', 'global', 'host', 'runas', 'user']) {
        fail("Sudo::Config::Default_entry['${title}']: parameter type must be one of 'global', 'cmnd', 'env', 'host', 'user', 'runas'")
      }

      include sudo::params

      file { "sudo/config/defaults/${type}/${title}":
        ensure  => $ensure,
        owner   => 'root',
        group   => 'root',
        mode    => '0440',
        path    => "${sudo::params::config_dir}/defaults/${type}/${title}",
        content => template("sudo/config/defaults/${type}.erb")
      }
    }
    default: {
      fail("Sudo::Config::Default_entry['${title}']: parameter ensure must be present or absent")
    }
  }


}
