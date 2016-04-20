default["ntp"]["servers"] = 3.times.map { |i| "#{i}.uk.pool.ntp.org" }
default["freeipa"]["ipa_admin_password"] = "Password123"
default["freeipa"]["domain"] = "example.com"
default["freeipa"]["dir_manager_password"] = "Password123"
default["freeipa"]["realm_name"] = node["freeipa"]["domain"].upcase
default["freeipa"]["server"] = "server1." + "#{node['freeipa']['domain']}"

default["vagrant"] = true
default["freeipa"]["ipaddress"] = node["vagrant"] ? "172.16.32.10" : node["ipaddress"]