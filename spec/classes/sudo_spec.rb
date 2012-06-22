#!/usr/bin/env rspec

require 'spec_helper'

describe 'sudo' do
  it { should contain_class 'sudo' }
end
