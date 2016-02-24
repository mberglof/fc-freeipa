default["freeipa"]["ipa_admin_password"] = "ipa_admin_password"
default["freeipa"]["hostname"] = node['fqdn']
default["freeipa"]["domain"] = "example.com"
default["freeipa"]["dir_manager_password"] = "vagrant"
default["freeipa"]["realm_name"] = "example.com"
default["freeipa"]["server"] = "server." + "#{node['freeipa']['domain']}"