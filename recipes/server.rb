#
# Cookbook Name:: fc-freeipa
# Recipe:: server
#

ipa_admin_password = node['freeipa']['ipa_admin_password']
hostname = node['freeipa']['hostname']
domain = node['freeipa']['domain']
dir_manager_password = node['freeipa']['dir_manager_password']
realm_name = node['freeipa']['realm_name']

script 'enable mkhomedir' do
  interpreter 'bash'
  cwd '/tmp'
  code <<-EOH
    authconfig --enablemkhomedir --update
  EOH
end

hostsfile_entry node['freeipa']['ipaddress'] do
  hostname  node['fqdn']
  comment   'added by freeipa server recipe'
  action    :append
end

package 'ipa-server' do
  action [:install]
end

script 'install freeipa server' do
  interpreter 'bash'
  cwd '/tmp'
  code <<-EOH
  ipa-server-install -U --no-host-dns -a #{ipa_admin_password} --hostname=#{hostname} -n #{domain} -p #{dir_manager_password} -r #{realm_name}
  EOH
  not_if "ipa-server-install 2>&1 | grep 'IPA server is already configured on this system.'"
end

service 'sssd' do
  action :start
end

service 'oddjobd' do
  action [:enable, :start]
end
