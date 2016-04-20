require 'spec_helper'

describe 'fc-freeipa::client' do
  before(:each) do
    stub_command("ipa-client-install 2>&1 | grep 'IPA client is already configured on this system.'").and_return(true)
  end
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }
  let(:server) { 'server.example.com' }
  let(:fqdn) { server }
  let(:domain) { 'example.com' }
  let(:realm_name) { 'EXAMPLE.COM' }
  let(:dir_manager_password) { 'password' }

  it 'installs the ipa-client package' do
    expect(chef_run).to install_package('ipa-client')
  end
  it 'enrols the freeipa client' do
    expect(chef_run).to run_script('install freeipa').with(cwd: '/tmp')
  end
end
