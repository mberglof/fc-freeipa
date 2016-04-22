# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2".freeze

domain = "example.com"

ipa_nodes = [
  { hostname: "server1", ip: "172.16.32.10", box: "bento/centos-7.1", fwdhost: 8443, fwdguest: 443, ram: 1024 },
  { hostname: "client1", ip: "172.16.32.11", box: "bento/centos-7.1" },
  { hostname: "server2", ip: "172.16.32.12", box: "bento/centos-7.1", fwdhost: 8443, fwdguest: 443, ram: 1024 },
  { hostname: "client2", ip: "172.16.32.13", box: "bento/centos-7.1" },
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.hostmanager.manage_guest = false
  config.hostmanager.manage_host = true
  config.omnibus.chef_version = "12.9.38"

  ipa_nodes.each do |node|
    config.vm.define node[:hostname] do |node_config|
      fqdn = node[:hostname] + "." + domain
      node_config.vm.box = node[:box]
      node_config.vm.hostname = fqdn
      node_config.vm.network :private_network, ip: node[:ip]

      if node[:fwdhost]
        node_config.vm.network :forwarded_port, guest: node[:fwdguest], host: node[:fwdhost]
      end

      memory = node[:ram] ? node[:ram] : 256
      node_config.vm.provider :virtualbox do |vb|
        vb.customize [
          "modifyvm", :id,
          "--name", node[:hostname],
          "--memory", memory.to_s
        ]
      end

      config.vm.provision :chef_solo do |chef|
        if node[:hostname] =~ /server/
          chef.add_recipe "fc-freeipa::server"
        else
          chef.add_recipe "fc-freeipa::client"
        end
        chef.json = {
          "vagrant_ip" => "172.16.32.10",
          "fqdn" => fqdn,
        }
      end
    end
  end
end
