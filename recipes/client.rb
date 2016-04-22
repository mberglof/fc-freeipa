#
# Cookbook Name:: freeipa-cookbook
# Recipe:: client
#

hostsfile_entry node["freeipa"]["ipaddress"] do
  hostname node["freeipa"]["server"]
end

package "ipa-client" do
  version node["freeipa"]["version"]
end

script "install freeipa client" do
  interpreter "bash"
  cwd "/tmp"
  code <<-EOH
    ipa-client-install \
      --server=#{node['freeipa']['server']} \
      --domain=#{node['freeipa']['domain']}  \
      --realm=#{node['freeipa']['realm_name']} \
      --password=#{node['freeipa']['ipa_admin_password']} \
      --fixed-primary \
      --hostname=#{node['fqdn']} \
      --principal=admin \
      --mkhomedir \
      --no-ntp \
      --unattended
  EOH
  not_if "ipa-client-install 2>&1 | grep 'IPA client is already configured on this system.'"
end

include_recipe "fc-freeipa::common"
