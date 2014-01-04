# Define: sudo::config::user
#
# This manages sudo User configurations
#
# Parameters:
# [*ensure*]
# Ensure if present or absent.
# Default: present
#
# [*user*]
# The User part of the specification.
# Default: $title
#
# [*configuration*]
# Content of configuration snippet.
# Default: undef
#
# Actions:
# Installs sudo User configuration
#
# Requires:
# Class sudo
# stdlib
#
# Sample Usage:
# sudo::config::user { 'admins' :
#  user          => '%admins',
#  configuration => 'ALL=(ALL)       NOPASSWD: ALL'
# }
#
# [Remember: No empty lines between comments and class definition]
define sudo::config::user(
  $ensure='present',
  $user=$title,
  $configuration=undef
) {

  validate_re($title, '^[A-Za-z0-9_\-.]+$', "Sudo::Config::User['${title}']: title value does not match ^[A-Za-z0-9_.]+$")

  #Class['sudo'] -> Sudo::Config::User[$title]

  case $ensure {
    'absent': {
      include sudo::params

      file { "sudo/config/user/${title}":
        ensure => $ensure,
        path   => "${sudo::params::config_dir}/users/${title}"
      }
    }
    'present': {
      if $configuration {
        include sudo::params

        file { "sudo/config/user/${title}":
          ensure  => $ensure,
          owner   => 'root',
          group   => 'root',
          mode    => '0440',
          path    => "${sudo::params::config_dir}/users/${title}",
          content => template('sudo/config/user.erb')
        }
      } else {
        fail("Sudo::Config::User['${title}']: required parameter configuration not specified")
      }
    }
    default: {
      fail("Sudo::Config::User['${title}']: parameter ensure must be present or absent")
    }
  }


}
