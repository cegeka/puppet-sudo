require 'spec_helper_acceptance'

describe 'sudo::config::cmnd_alias' do

  describe 'running puppet code' do
    it 'should work with no errors' do
      pp = <<-EOS
        include ::sudo
        sudo::config::cmnd_alias { 'foo-cmnd' :
          configuration => 'FOOALIAS = /usr/bin/foo'
        }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe file '/etc/sudoers.d/cmnd_aliases/foo-cmnd' do
      it { is_expected.to be_file }
      its(:content) { should contain /FOOALIAS/ }
    end

  end
end

