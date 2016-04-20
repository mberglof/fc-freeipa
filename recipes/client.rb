#
# Cookbook Name:: freeipa-cookbook
# Recipe:: client
#

dir_manager_password = node['freeipa']['dir_manager_password']
domain = node['freeipa']['domain']
server = node['freeipa']['server']
realm_name = node['freeipa']['realm_name']

hostsfile_entry node['freeipa']['ipaddress'] do
  hostname  node['freeipa']['server']
  comment   'added by freeipa server recipe'
  action    :append
end

package 'ipa-client'

script 'install freeipa' do
  interpreter 'bash'
  cwd '/tmp'
  code <<-EOH
  ipa-client-install \
  	--server=#{server} \
  	--domain #{domain}  \
  	--realm #{realm_name} \
  	--password #{dir_manager_password} \
  	--fixed-primary \
  	--hostname #{node['fqdn']} \
  	--principal admin \
  	--mkhomedir \
  	--no-ntp \
  	--unattended
  EOH
  not_if "ipa-client-install 2>&1 | grep 'IPA client is already configured on this system.'"
end
