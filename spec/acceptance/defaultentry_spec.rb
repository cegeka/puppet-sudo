require 'spec_helper_acceptance'

describe 'sudo::config::default_entry' do

  describe 'running puppet code' do
    it 'should work with no errors' do
      pp = <<-EOS
        include ::sudo
        sudo::config::default_entry { 'visiblepw' :
          configuration => '!visiblepw'
        }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe file '/etc/sudoers.d/defaults/global/visiblepw' do
      #it { is_expected.to be_file }
      it { is_expected.to be_file.with_mode('0440').with_owner('root').with_group('root') }
      its(:content) { should contain /!visiblepw/ }
    end

  end
end

