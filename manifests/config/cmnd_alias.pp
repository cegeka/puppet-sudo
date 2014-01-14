# Define: sudo::config::cmnd_alias
#
# This manages sudo Cmnd_Alias configurations
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
# Installs sudo Cmnd_Alias configuration
#
# Requires:
# Class sudo
# stdlib
#
# Sample Usage:
# sudo::config::cmnd_alias { 'admins-elev' :
#   configuration => 'ADMINELEV = ALL'
# }
#
# [Remember: No empty lines between comments and class definition]
define sudo::config::cmnd_alias(
  $ensure='present',
  $configuration=undef
) {

  validate_re($title, '^[A-Za-z0-9_\-.]+$', "Sudo::Config::Cmnd_alias['${title}']: title value does not match ^[A-Za-z0-9_.]+$")

  include sudo
  Class['sudo'] -> Sudo::Config::Cmnd_alias[$title]

  case $ensure {
    'absent': {
      include sudo::params

      file { "sudo/config/cmnd_alias/${title}":
        ensure => $ensure,
        path   => "${sudo::params::config_dir}/cmnd_aliases/${title}"
      }
    }
    'present': {
      if $configuration {
        include sudo::params

        file { "sudo/config/cmnd_alias/${title}":
          ensure  => $ensure,
          owner   => 'root',
          group   => 'root',
          mode    => '0440',
          path    => "${sudo::params::config_dir}/cmnd_aliases/${title}",
          content => template('sudo/config/cmnd_alias.erb')
        }
      } else {
        fail("Sudo::Config::Cmnd_alias['${title}']: required parameter configuration not specified")
      }
    }
    default: {
      fail("Sudo::Config::Cmnd_alias['${title}']: parameter ensure must be present or absent")
    }
  }

}
