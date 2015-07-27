#
# Cookbook Name:: fc-freeipa
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.
#

#node.set["hostfile"]
#node.set["freeipa"]["ipa_admin_password"] = "ipa_admin_passwordadmin"
#node.set["freeipa"]["hostname"] = "localhost.localdomain"
#node.set["freeipa"]["domain"] = "localdomain"
#node.set["freeipa"]["dir_manager_password"] = "dir_manager_password"
#node.set["freeipa"]["realm_name"] = "LOCALDOMAIN"

package "selinux-policy" do
  retries 3
  timeout 1800
  retry_delay 10
  action [:upgrade]
end

include_recipe "freeipa"
