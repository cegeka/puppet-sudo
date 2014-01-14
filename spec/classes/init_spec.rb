#!/usr/bin/env rspec

require 'spec_helper'

describe 'sudo' do
  context 'with faulty input' do
    context 'with version => running' do
      let (:params) { { :version => 'running' } }

      it { expect { subject }.to raise_error(
        Puppet::Error, /parameter version must be present or latest/
      )}
    end

  end

  context 'on osfamily RedHat' do
    let (:facts) { {
      :osfamily => 'RedHat'
    } }

    context 'with default parameters' do
      let (:params) { { } }

      it { should include_class('sudo::params') }

      it { should contain_class('sudo').with_version('present') }

      it { should contain_class('sudo::package').with_version('present') }

      it { should contain_class('sudo::package').with_before('Class[Sudo::Config]') }
    end
  end

  context 'on osfamily Debian' do
    let (:facts) { {
      :osfamily => 'Debian'
    } }

    it {expect { subject }.to raise_error( Puppet::Error, /not supported/) }
  end
end
