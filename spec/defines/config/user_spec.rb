#!/usr/bin/env rspec

require 'spec_helper'

describe 'sudo::config::user' do
  context 'with title foo' do
    let (:title) { 'foo' }
    #let (:pre_condition) { "class sudo {}" }

    context 'on osfamily RedHat' do
      let (:facts) { {
        :osfamily => 'RedHat'
      } }

      context 'with default parameters' do
        let (:params) { { } }

        it { expect { subject }.to raise_error(
            Puppet::Error, /required parameter configuration not specified/
        )}
      end

      context 'with configuration => ALL=(ALL) ALL' do
        let (:params) { { :configuration => 'ALL=(ALL) ALL' } }

        it { should include_class('sudo::params') }
        it { should include_class('sudo') }

        it { should contain_file('sudo/config/user/10_foo').with_owner('root') }
        it { should contain_file('sudo/config/user/10_foo').with_group('root') }
        it { should contain_file('sudo/config/user/10_foo').with_mode('0440') }
        it { should contain_file('sudo/config/user/10_foo').with_path('/etc/sudoers.d/users/10_foo') }
        it { should contain_file('sudo/config/user/10_foo').with_content(/foo    ALL=\(ALL\) ALL/) }
      end

      context 'with user => root and configuration => ALL=(ALL) ALL' do
        let (:params) { { :user => 'root', :configuration => 'ALL=(ALL) ALL' } }

        it { should include_class('sudo::params') }
        it { should include_class('sudo') }

        it { should contain_file('sudo/config/user/10_foo').with_owner('root') }
        it { should contain_file('sudo/config/user/10_foo').with_group('root') }
        it { should contain_file('sudo/config/user/10_foo').with_mode('0440') }
        it { should contain_file('sudo/config/user/10_foo').with_path('/etc/sudoers.d/users/10_foo') }
        it { should contain_file('sudo/config/user/10_foo').with_content(/root    ALL=\(ALL\) ALL/) }
      end
    end
  end

  context 'with title foo bar' do
    let (:title) { 'foo bar' }

    context 'on osfamily RedHat' do
      let (:facts) { {
        :osfamily => 'RedHat'
      } }


      context 'with configuration => test' do
        let (:params) { { :configuration => 'test' } }

        it { expect { subject }.to raise_error(
            Puppet::Error, /title value does not match/
        )}
      end
    end
  end
end
