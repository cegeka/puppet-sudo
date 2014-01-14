class sudo::package($version=undef) {

  include sudo::params

  case $version {
    'present', 'latest': {
      $version_real = $version
    }
    default: {
      fail('Class[sudo::package]: parameter version must be present or latest')
    }
  }

  package { $sudo::params::package :
    ensure => $version_real
  }

}
