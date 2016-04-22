require "spec_helper"

describe "fc-freeipa::server" do
  let(:check_server_cmd) { "ipa-server-install 2>&1 | grep 'IPA server is already configured on this system.'" }
  let(:chef_run) do
    runner = ChefSpec::SoloRunner.new
    runner.node.set["freeipa"]["version"] = "1.2.3"
    runner.node.set["freeipa"]["ipaddress"] = "10.0.0.1"
    runner.converge(described_recipe)
  end

  before(:each) do
    stub_command(check_server_cmd).and_return(false)
  end

  it 'overrides \'127.0.0.1\' entry in hosts file to remove itself' do
    expect(chef_run).to create_hostsfile_entry("127.0.0.1")
  end

  it "adds itself to hosts file under real IP" do
    expect(chef_run).to create_hostsfile_entry("10.0.0.1")
  end

  it "installs the specific ipa-server package" do
    expect(chef_run).to install_package("ipa-server").with_version("1.2.3")
  end

  context "when server not installed" do
    it "it installs server" do
      expect(chef_run).to run_script("install freeipa server").with(code: /ipa-server-install/)
    end
  end

  context "when server already installed" do
    it 'doesn\'t try to install' do
      stub_command(check_server_cmd).and_return(true)
      expect(chef_run).to_not run_script("install freeipa server")
    end
  end

  it "enables ipa service" do
    expect(chef_run).to enable_service("ipa").with(action: [:enable, :start])
  end
end
