#
# Cookbook Name:: fc-freeipa
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.
#

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

include_recipe 'fc-freeipa::freeipa' unless ::File.exist?("/etc/httpd/conf.d")

service "sssd" do
  action :start
end

service "oddjobd" do
  action [ :enable, :start]
end
