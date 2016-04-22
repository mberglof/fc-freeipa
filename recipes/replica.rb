#
# Cookbook Name:: fc-freeipa
# Recipe:: server
#

hostsfile_entry "127.0.0.1" do
  hostname  "localhost"
  aliases   %w( localhost.localdomain localhost4 localhost4.localdomain4 )
end

hostsfile_entry node["freeipa"]["ipaddress"] do
  hostname  node["fqdn"]
  aliases   [node["hostname"]]
end

include_recipe "entropy"

package "ipa-server" do
  version node["freeipa"]["version"]
end

script "install freeipa server" do
  interpreter "bash"
  cwd "/tmp"
  code <<-EOH
    ipa-server-install \
    --no-host-dns \
    --admin-password=#{node['freeipa']['ipa_admin_password']} \
    --hostname=#{node['fqdn']} \
    --domain=#{node['freeipa']['domain']} \
    --ds-password=#{node['freeipa']['dir_manager_password']} \
    --realm=#{node['freeipa']['realm_name']} \
    --unattended
  EOH
  not_if "ipa-server-install 2>&1 | grep 'IPA server is already configured on this system.'"
end

service "ipa" do
  action [:enable, :start]
end

include_recipe "fc-freeipa::common"

# ipa-replica-prepare --debug server2.example.com --password=Password123 --no-wait-for-dns
