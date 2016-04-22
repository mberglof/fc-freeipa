default["ntp"]["servers"] = Array.new(3) { |i| "#{i}.uk.pool.ntp.org" }

default["freeipa"]["version"] = "4.2.0-15.0.1.el7.centos.6.1"
default["freeipa"]["ipa_admin_password"] = "Password123"
default["freeipa"]["domain"] = "example.com"
default["freeipa"]["dir_manager_password"] = "Password123"
default["freeipa"]["realm_name"] = node["freeipa"]["domain"].upcase

default["freeipa"]["server"]["hostname"] = "server1." + node["freeipa"]["domain"]
default["freeipa"]["server"]["ipaddress"] = node["vagrant_ip"] ? node["vagrant_ip"] : node["ipaddress"]

default["freeipa"]["replica"]["hostname"] = "replica.example.com"
default["freeipa"]["replica"]["ipaddress"] = "192.168.222.3"
