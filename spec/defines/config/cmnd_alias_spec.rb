#!/usr/bin/env rspec

require 'spec_helper'

describe 'sudo::config::cmnd_alias' do
  context 'with title foo' do
    let (:title) { 'foo' }

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

      context 'with configuration => test' do
        let (:params) { { :configuration => 'test' } }

        it { should contain_class('sudo::params') }
        it { should contain_class('sudo') }

        it { should contain_file('sudo/config/cmnd_alias/foo').with_owner('root') }
        it { should contain_file('sudo/config/cmnd_alias/foo').with_group('root') }
        it { should contain_file('sudo/config/cmnd_alias/foo').with_mode('0440') }
        it { should contain_file('sudo/config/cmnd_alias/foo').with_path('/etc/sudoers.d/cmnd_aliases/foo') }
        it { should contain_file('sudo/config/cmnd_alias/foo').with_content(/Cmnd_Alias    test/) }
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
