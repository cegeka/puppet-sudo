#!/usr/bin/env rspec

require 'spec_helper'

describe 'sudo::package' do
  let(:facts) { {
    :osfamily        => 'RedHat'
  } }

  context 'with faulty input' do
    context 'with version => running' do
      let (:params) { { :version => 'running' } }

      it { expect { subject }.to raise_error(
        Puppet::Error, /parameter version must be present or latest/
      ) }
    end
  end

  context 'with version => present' do
    let (:params) { { :version => 'present' } }

    it { should contain_class('sudo::params') }

    it { should contain_package('sudo').with_ensure('present') }
  end
end
