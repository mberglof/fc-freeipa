# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

domain = 'EXAMPLE.COM'

ipa_nodes = [
  {:hostname => 'server1',  :ip => '172.16.32.10', :box => 'bento/centos-7.1', :fwdhost => 8443, :fwdguest => 443, :ram => 1024},
  {:hostname => 'client1', :ip => '172.16.32.11', :box => 'bento/centos-7.1'},
  {:hostname => 'server2',  :ip => '172.16.32.12', :box => 'bento/centos-7.1', :fwdhost => 8443, :fwdguest => 443, :ram => 1024},
  {:hostname => 'client2', :ip => '172.16.32.13', :box => 'bento/centos-7.1'},
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  ipa_nodes.each do |node|
    config.vm.define node[:hostname] do |node_config|
      node_config.vm.box = node[:box]
      node_config.vm.hostname = node[:hostname] + '.' + domain
      node_config.vm.network :private_network, ip: node[:ip]

      if node[:fwdhost]
        node_config.vm.network :forwarded_port, guest: node[:fwdguest], host: node[:fwdhost]
      end

      memory = node[:ram] ? node[:ram] : 256;
      node_config.vm.provider :virtualbox do |vb|
        vb.customize [
          'modifyvm', :id,
          '--name', node[:hostname],
          '--memory', memory.to_s
        ]
      end
    end
  end
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  if Vagrant.has_plugin?("vagrant-omnibus")
    config.omnibus.chef_version = '12.4.1'
  end
end
