require "spec_helper"

describe "fc-freeipa::client" do
  let(:check_client_cmd) { "ipa-client-install 2>&1 | grep 'IPA client is already configured on this system.'" }
  let(:chef_run) do
    runner = ChefSpec::SoloRunner.new
    runner.node.set["freeipa"]["version"] = "1.2.3"
    runner.node.set["freeipa"]["ipaddress"] = "10.0.0.1"
    runner.converge(described_recipe)
  end

  before(:each) do
    stub_command(check_client_cmd).and_return(false)
  end

  it "adds ipa server to hosts file" do
    expect(chef_run).to create_hostsfile_entry("10.0.0.1")
  end

  it "installs the specific ipa-client package" do
    expect(chef_run).to install_package("ipa-client").with_version("1.2.3")
  end

  context "when client not enrolled" do
    it "enrolls client" do
      expect(chef_run).to run_script("install freeipa client").with(code: /ipa-client-install/)
    end
  end

  context "when client already enrolled" do
    it 'doesn\'t try to enroll' do
      stub_command(check_client_cmd).and_return(true)
      expect(chef_run).to_not run_script("install freeipa client")
    end
  end
end
