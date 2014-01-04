# Define: sudo::config::user_alias
#
# This manages sudo User_Alias configurations
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
# Installs sudo User_Alias configuration
#
# Requires:
# Class sudo
# stdlib
#
# Sample Usage:
# sudo::config::user_alias { 'FULLTIMERS' :
#   configuration => 'FULLTIMERS = millert, mikef, dowdy'
# }
#
# [Remember: No empty lines between comments and class definition]
define sudo::config::user_alias(
  $ensure='present',
  $configuration=undef
) {

  validate_re($title, '^[A-Za-z0-9_\-.]+$', "Sudo::Config::User_alias['${title}']: title value does not match ^[A-Za-z0-9_.]+$")

  #Class['sudo'] -> Sudo::Config::User_alias[$title]

  case $ensure {
    'absent': {
      include sudo::params

      file { "sudo/config/user_alias/${title}":
        ensure => $ensure,
        path   => "${sudo::params::config_dir}/user_aliases/${title}"
      }
    }
    'present': {
      if $configuration {
        include sudo::params

        file { "sudo/config/user_alias/${title}":
          ensure  => $ensure,
          owner   => 'root',
          group   => 'root',
          mode    => '0440',
          path    => "${sudo::params::config_dir}/user_aliases/${title}",
          content => template('sudo/config/user_alias.erb')
        }
      } else {
        fail("Sudo::Config::User_alias['${title}']: required parameter configuration not specified")
      }
    }
    default: {
      fail("Sudo::Config::User_alias['${title}']: parameter ensure must be present or absent")
    }
  }

}
