# Class: sudo
#
# This module manages sudo
#
# Parameters:
#   [*version*]
#     Ensure if present or latest.
#     Default: present
#   [*config_file_includes*]
#     Array of strings with extra includes in the sudo config.
#     Default: present
#
# Actions:
#
# Requires:
#   stdlib
#
# Sample Usage:
#   class { 'sudo': }
#
# [Remember: No empty lines between comments and class definition]
class sudo(
  String $version = 'present',
  Array[String] $config_file_includes = $sudo::params::config_file_includes
) {

  case $version {
    'present', 'latest': {
      $version_real = $version
    }
    default: {
      fail('Class[sudo]: parameter version must be present or latest')
    }
  }

  case $::osfamily {
    'RedHat': {
      include stdlib
      include sudo::params

      class { 'sudo::package':
        version => $version_real
      }

      class { 'sudo::config':
        config_file_includes => $config_file_includes
      }

      Class['sudo::package'] -> Class['sudo::config']
    }
    default: {
      fail("Class[sudo]: osfamily ${::osfamily} is not supported")
    }
  }

}
