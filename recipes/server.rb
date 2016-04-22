#
# Cookbook Name:: fc-freeipa
# Recipe:: server
#
require "base64"
include_recipe "entropy"

hostsfile_entry "127.0.0.1" do
  hostname  "localhost"
  aliases   %w( localhost.localdomain localhost4 localhost4.localdomain4 )
end

hostsfile_entry node["freeipa"]["server"]["ipaddress"] do
  hostname  node["freeipa"]["server"]["hostname"]
  aliases   [node["hostname"]]
end

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
    --hostname=#{node['freeipa']['server']['hostname']} \
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

# prepare replica

hostsfile_entry node["freeipa"]["replica"]["ipaddress"] do
  hostname  node["freeipa"]["replica"]["hostname"]
end

script "prepare #{node['freeipa']['replica']['hostname']} replica" do
  interpreter "bash"
  cwd "/tmp"
  code <<-EOH
    ipa-replica-prepare \
      --password=#{node['freeipa']['dir_manager_password']}\
      --no-wait-for-dns \
      #{node['freeipa']['replica']['hostname']}
  EOH
  creates "/var/lib/ipa/replica-info-#{node['freeipa']['replica']['hostname']}.gpg"
end

gpg = Base64.encode64(File.read("/var/lib/ipa/replica-info-#{node['freeipa']['replica']['hostname']}.gpg"))

data = {
  "id" => "replica",
  "data" => gpg,
}

databag_item = Chef::DataBagItem.new
databag_item.data_bag("freeipa")
databag_item.raw_data = data
databag_item.save
