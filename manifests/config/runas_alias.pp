# Define: sudo::config::runas_alias
#
# This manages sudo Runas_Alias configurations
#
# Parameters:
# [*ensure*]
# Ensure if present or absent.
# Default: present
#
# [*configuration*]
# Content of configuration snippet.
# Default: undef
#
# Actions:
# Installs sudo Runas_Alias configuration
#
# Requires:
# Class sudo
# stdlib
#
# Sample Usage:
# sudo::config::runas_alias { 'db' :
#   configuration => 'DB = oracle, sybase'
# }
#
# [Remember: No empty lines between comments and class definition]
define sudo::config::runas_alias(
  $ensure='present',
  $configuration=undef
) {

  validate_re($title, '^[A-Za-z0-9_\-.]+$', "Sudo::Config::Runas_alias['${title}']: title value does not match ^[A-Za-z0-9_.]+$")

  #Class['sudo'] -> Sudo::Config::Runas_alias[$title]

  case $ensure {
    'absent': {
      include sudo::params

      file { "sudo/config/runas_alias/${title}":
        ensure => $ensure,
        path   => "${sudo::params::config_dir}/runas_aliases/${title}"
      }
    }
    'present': {
      if $configuration {
        include sudo::params

        file { "sudo/config/runas_alias/${title}":
          ensure  => $ensure,
          owner   => 'root',
          group   => 'root',
          mode    => '0440',
          path    => "${sudo::params::config_dir}/runas_aliases/${title}",
          content => template('sudo/config/runas_alias.erb')
        }
      } else {
        fail("Sudo::Config::Runas_alias['${title}']: required parameter configuration not specified")
      }
    }
    default: {
      fail("Sudo::Config::Runas_alias['${title}']: parameter ensure must be present or absent")
    }
  }


}
