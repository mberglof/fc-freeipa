#
# Cookbook Name:: freeipa-cookbook
# Recipe:: client
#
#
dir_manager_password = node["freeipa"]["dir_manager_password"] 
domain = node["freeipa"]["domain"]
server = node["freeipa"]["server"]

yum_package "ipa-client"