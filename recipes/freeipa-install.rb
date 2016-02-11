
#
# Cookbook Name:: fc-freeipa
# Recipe:: freeipa-install.rb
#
# Copyright 2014, Webhosting.coop
#
#
ipa_admin_password = node["freeipa"]["ipa_admin_password"]
hostname = node["freeipa"]["hostname"] 
domain = node["freeipa"]["domain"] 
dir_manager_password = node["freeipa"]["dir_manager_password"] 
realm_name = node["freeipa"]["realm_name"]

hostsfile_entry node['ipaddress'] do
    hostname  node["freeipa"]["hostname"]
    comment   'added by freeipa recipe'
    retries 3
    retry_delay 15
    action    :append
end
package "freeipa-server" do
  retries 3
  timeout 1800
  retry_delay 10
  action [:install]
  not_if { File.exist?("/etc/httpd/conf.d/ipa.conf") }
end

script "install freeipa" do
  interpreter "bash"
  user "root"
  group "root"
  cwd "/tmp"
  code <<-EOH
    if [ ! -f /etc/httpd/conf.d/ipa.conf ]; then
      ipa-server-install -U --no-host-dns -a #{ipa_admin_password} --hostname=#{hostname} -n #{domain} -p #{dir_manager_password} -r #{realm_name}
    fi
  
  EOH
end