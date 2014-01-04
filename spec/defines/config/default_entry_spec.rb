#!/usr/bin/env rspec

require 'spec_helper'

describe 'sudo::config::default_entry' do
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

      context 'with configuration => test and type => bla' do
        let (:params) { { :type => 'bla' , :configuration => 'test' } }

        it { expect { subject }.to raise_error(
            Puppet::Error, /parameter type must be one of 'global', 'cmnd', 'env', 'host', 'user', 'runas'/
        )}
      end

      context 'with configuration => test' do
        let (:params) { { :configuration => 'test' } }

        it { should include_class('sudo::params') }

        it { should contain_file('sudo/config/defaults/global/foo').with_owner('root') }
        it { should contain_file('sudo/config/defaults/global/foo').with_group('root') }
        it { should contain_file('sudo/config/defaults/global/foo').with_mode('0440') }
        it { should contain_file('sudo/config/defaults/global/foo').with_path('/etc/sudoers.d/defaults/global/foo') }
        it { should contain_file('sudo/config/defaults/global/foo').with_content(/Defaults    test/) }
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
