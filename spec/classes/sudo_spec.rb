#!/usr/bin/env rspec

require 'spec_helper'

describe 'sudo' do

  let(:facts) { { :operatingsystem => 'redhat'} }

  it { should contain_class 'sudo' }
end
