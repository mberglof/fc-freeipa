#
# Cookbook Name:: freeipa-cookbook
# Recipe:: client
#
#
dir_manager_password = node["freeipa"]["dir_manager_password"] 
domain = node["freeipa"]["domain"]
server = node["freeipa"]["server"]

script "install freeipa" do
  interpreter "bash"
  user "root"
  group "root"
  cwd "/tmp"
  code <<-EOH
  ipa-client-install --domain=#{domain} --server=#{server} --force-ntpd --mkhomedir -p #{dir_manager_password}
  EOH
end
