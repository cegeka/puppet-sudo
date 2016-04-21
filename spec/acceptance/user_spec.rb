require 'spec_helper_acceptance'

describe 'sudo::config::user' do

  describe 'running puppet code' do
    it 'should work with no errors' do
      pp = <<-EOS
        sudo::config::user { 'foo-user' :
          user => 'foo',
          priority => '10'
          configuration => 'ALL=(ALL) NOPASSWD: /usr/bin/foo'
        }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe file '/etc/sudoers.d/users/10_foo-user' do
      it { is_expected.to be_file }
      its(:content) { should contain /foo/ }
    end

  end
end

