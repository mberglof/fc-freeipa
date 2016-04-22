require "spec_helper"

describe "fc-freeipa::common" do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it "enables mkhomedir" do
    expect(chef_run).to run_script("enable mkhomedir").with(code: "authconfig --enablemkhomedir --update")
  end

  %w( sssd oddjobd ).each do |service|
    it "enables #{service} service" do
      expect(chef_run).to enable_service(service).with(action: [:enable, :start])
    end
  end
end
