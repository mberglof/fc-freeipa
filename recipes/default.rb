#
# Cookbook Name:: fc-freeipa
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.
#

node.set["freeipa"]["ipa_admin_password"] = "ipa_admin_password"
node.set["freeipa"]["hostname"] = "ipa.fcuat.co.uk"
node.set["freeipa"]["domain"] = "fcuat.co.uk"
node.set["freeipa"]["dir_manager_password"] = "dir_manager_password"
node.set["freeipa"]["realm_name"] = "FCUAT.CO.UK"

package "selinux-policy" do
  retries 3
  timeout 1800
  retry_delay 10
  action [:upgrade]
end

script "enable mkhomedir" do
  interpreter "bash"
  user "root"
  group "root"
  cwd "/tmp"
  code <<-EOH
    authconfig --enablemkhomedir --update
  EOH
end

include_recipe "freeipa"

service "sssd" do
  action :start
end

service "oddjobd" do
  action [ :enable, :start]
end
