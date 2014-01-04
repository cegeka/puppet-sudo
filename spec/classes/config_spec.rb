#!/usr/bin/env rspec

require 'spec_helper'

describe 'sudo::config' do
  let (:facts) { {
    :osfamily => 'RedHat'
  } }

  it { should include_class('sudo::params') }

  it { should contain_file('/etc/sudoers').with_ensure('file') }
  it { should contain_file('/etc/sudoers').with_owner('root') }
  it { should contain_file('/etc/sudoers').with_group('root') }
  it { should contain_file('/etc/sudoers').with_mode('0440') }
  it { should contain_file('/etc/sudoers').with_source('puppet:///modules/sudo/etc/sudoers') }

  it { should contain_file('/etc/sudoers.d').with_ensure('directory') }
  it { should contain_file('/etc/sudoers.d').with_owner('root') }
  it { should contain_file('/etc/sudoers.d').with_group('root') }
  it { should contain_file('/etc/sudoers.d').with_mode('0550') }
  it { should contain_file('/etc/sudoers.d').with_recurse('true') }
  it { should contain_file('/etc/sudoers.d').with_purge('true') }

  it { should contain_file('sudoers/host_aliases').with_ensure('directory') }
  it { should contain_file('sudoers/host_aliases').with_owner('root') }
  it { should contain_file('sudoers/host_aliases').with_group('root') }
  it { should contain_file('sudoers/host_aliases').with_mode('0550') }
  it { should contain_file('sudoers/host_aliases').with_path('/etc/sudoers.d/host_aliases') }

  it { should contain_file('sudoers/user_aliases').with_ensure('directory') }
  it { should contain_file('sudoers/user_aliases').with_owner('root') }
  it { should contain_file('sudoers/user_aliases').with_group('root') }
  it { should contain_file('sudoers/user_aliases').with_mode('0550') }
  it { should contain_file('sudoers/user_aliases').with_path('/etc/sudoers.d/user_aliases') }

  it { should contain_file('sudoers/cmnd_aliases').with_ensure('directory') }
  it { should contain_file('sudoers/cmnd_aliases').with_owner('root') }
  it { should contain_file('sudoers/cmnd_aliases').with_group('root') }
  it { should contain_file('sudoers/cmnd_aliases').with_mode('0550') }
  it { should contain_file('sudoers/cmnd_aliases').with_path('/etc/sudoers.d/cmnd_aliases') }

  it { should contain_file('sudoers/runas_aliases').with_ensure('directory') }
  it { should contain_file('sudoers/runas_aliases').with_owner('root') }
  it { should contain_file('sudoers/runas_aliases').with_group('root') }
  it { should contain_file('sudoers/runas_aliases').with_mode('0550') }
  it { should contain_file('sudoers/runas_aliases').with_path('/etc/sudoers.d/runas_aliases') }

  it { should contain_file('sudoers/defaults').with_ensure('directory') }
  it { should contain_file('sudoers/defaults').with_owner('root') }
  it { should contain_file('sudoers/defaults').with_group('root') }
  it { should contain_file('sudoers/defaults').with_mode('0550') }
  it { should contain_file('sudoers/defaults').with_path('/etc/sudoers.d/defaults') }

  it { should contain_file('sudoers/defaults/cmnd').with_ensure('directory') }
  it { should contain_file('sudoers/defaults/cmnd').with_owner('root') }
  it { should contain_file('sudoers/defaults/cmnd').with_group('root') }
  it { should contain_file('sudoers/defaults/cmnd').with_mode('0550') }
  it { should contain_file('sudoers/defaults/cmnd').with_path('/etc/sudoers.d/defaults/cmnd') }

  it { should contain_file('sudoers/defaults/env').with_ensure('directory') }
  it { should contain_file('sudoers/defaults/env').with_owner('root') }
  it { should contain_file('sudoers/defaults/env').with_group('root') }
  it { should contain_file('sudoers/defaults/env').with_mode('0550') }
  it { should contain_file('sudoers/defaults/env').with_path('/etc/sudoers.d/defaults/env') }

  it { should contain_file('sudoers/defaults/global').with_ensure('directory') }
  it { should contain_file('sudoers/defaults/global').with_owner('root') }
  it { should contain_file('sudoers/defaults/global').with_group('root') }
  it { should contain_file('sudoers/defaults/global').with_mode('0550') }
  it { should contain_file('sudoers/defaults/global').with_path('/etc/sudoers.d/defaults/global') }

  it { should contain_file('sudoers/defaults/host').with_ensure('directory') }
  it { should contain_file('sudoers/defaults/host').with_owner('root') }
  it { should contain_file('sudoers/defaults/host').with_group('root') }
  it { should contain_file('sudoers/defaults/host').with_mode('0550') }
  it { should contain_file('sudoers/defaults/host').with_path('/etc/sudoers.d/defaults/host') }

  it { should contain_file('sudoers/defaults/runas').with_ensure('directory') }
  it { should contain_file('sudoers/defaults/runas').with_owner('root') }
  it { should contain_file('sudoers/defaults/runas').with_group('root') }
  it { should contain_file('sudoers/defaults/runas').with_mode('0550') }
  it { should contain_file('sudoers/defaults/runas').with_path('/etc/sudoers.d/defaults/runas') }

  it { should contain_file('sudoers/defaults/user').with_ensure('directory') }
  it { should contain_file('sudoers/defaults/user').with_owner('root') }
  it { should contain_file('sudoers/defaults/user').with_group('root') }
  it { should contain_file('sudoers/defaults/user').with_mode('0550') }
  it { should contain_file('sudoers/defaults/user').with_path('/etc/sudoers.d/defaults/user') }

  it { should contain_file('sudoers/users').with_ensure('directory') }
  it { should contain_file('sudoers/users').with_owner('root') }
  it { should contain_file('sudoers/users').with_group('root') }
  it { should contain_file('sudoers/users').with_mode('0550') }
  it { should contain_file('sudoers/users').with_path('/etc/sudoers.d/users') }

end
