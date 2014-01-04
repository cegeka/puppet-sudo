# Define: sudo::config::host_alias
#
# This manages sudo Host_Alias configurations
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
# Installs sudo Host_Alias configuration
#
# Requires:
# Class sudo
# stdlib
#
# Sample Usage:
# sudo::config::host_alias { 'SERVERS' :
#   configuration => 'SERVERS = master, mail, www, ns'
# }
#
# [Remember: No empty lines between comments and class definition]
define sudo::config::host_alias(
  $ensure='present',
  $configuration=undef
) {

  validate_re($title, '^[A-Za-z0-9_\-.]+$', "Sudo::Config::Host_alias['${title}']: title value does not match ^[A-Za-z0-9_.]+$")

  #Class['sudo'] -> Sudo::Config::Host_alias[$title]

  case $ensure {
    'absent': {
      include sudo::params

      file { "sudo/config/host_alias/${title}":
        ensure => $ensure,
        path   => "${sudo::params::config_dir}/host_aliases/${title}"
      }
    }
    'present': {
      if $configuration {
        include sudo::params

        file { "sudo/config/host_alias/${title}":
          ensure  => $ensure,
          owner   => 'root',
          group   => 'root',
          mode    => '0440',
          path    => "${sudo::params::config_dir}/host_aliases/${title}",
          content => template('sudo/config/host_alias.erb')
        }
      } else {
        fail("Sudo::Config::Host_alias['${title}']: required parameter configuration not specified")
      }
    }
    default: {
      fail("Sudo::Config::Host_alias['${title}']: parameter ensure must be present or absent")
    }
  }


}
