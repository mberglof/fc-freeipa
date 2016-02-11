default["freeipa"]["ipa_admin_password"] = "ipa_admin_password"
default["freeipa"]["hostname"] = node['fqdn']
default["freeipa"]["domain"] = "example.com"
default["freeipa"]["dir_manager_password"] = "dir_manager_password"
default["freeipa"]["realm_name"] = "example.com"
#default["ipaddress"] = "172.16.32.10"
default["freeipa"]["server"] = "server." + "#{node['freeipa']['domain']}"