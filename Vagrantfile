# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

domain = 'example.com'

ipa_nodes = [
  {:hostname => 'server',  :ip => '172.16.32.10', :box => 'opscode-centos-7.1', :fwdhost => 8443, :fwdguest => 443, :ram => 1024},
  {:hostname => 'client', :ip => '172.16.32.11', :box => 'opscode-centos-7.1'},
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  ipa_nodes.each do |node|
    config.vm.define node[:hostname] do |node_config|
      node_config.vm.box = node[:box]
      #node_config.vm.box_url = 'http://files.vagrantup.com/' + node_config.vm.box + '.box'
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

  #config.vm.hostname = "ipa.example.com"
  # Every Vagrant virtual environment requires a box to build off of.
  #config.vm.box = "opscode-centos-7.1"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  #config.vm.network "forwarded_port", guest: 25, host: 2525

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  #config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  # config.vm.provision "chef_solo" do |chef|
  #   chef.cookbooks_path = "../my-recipes/cookbooks"
  #   chef.roles_path = "../my-recipes/roles"
  #   chef.data_bags_path = "../my-recipes/data_bags"
  #   chef.add_recipe "mysql"
  #   chef.add_role "web"
  #
  #   # You may also specify custom JSON attributes:
  #   chef.json = { mysql_password: "foo" }
  # end

  # When Vagrant spins up a machine, it will also load your cookbook
  # dependencies via Berkshelf
  config.berkshelf.enabled = true

  # Set the version of Chef you want to use.  The omnibus plug in will
  # ensure you get the version you want installed as Vagrant spins up
  # the machine
  if Vagrant.has_plugin?("vagrant-omnibus")
    config.omnibus.chef_version = '12.4.1'
  end

  # Chef Zero path to chef server objects.  These are things like data bags,
  # roles and environments.
  config.chef_zero.chef_repo_path = "~/chef-repo/"

  config.vm.provision "chef_solo" do |chef|
  #  chef.chef_server_url = "https://api.opscode.com/organizations/ORGNAME"
  #  chef.validation_key_path = "ORGNAME-validator.pem"
    chef.node_name = config.vm.hostname
    #chef.cookbooks_path = "../my-recipes/cookbooks"
    chef.roles_path = "./roles"
    chef.data_bags_path = "./data_bags"
    chef.nodes_path = "./nodes"

    chef.run_list = [
      "recipe[fc-freeipa::default]"
    ]
  end
  #
  # If you're using the Opscode platform, your validator client is
  # ORGNAME-validator, replacing ORGNAME with your organization name.
  #
  # If you have your own Chef Server, the default validation client name is
  # chef-validator, unless you changed the configuration.
  #
  #   chef.validation_client_name = "ORGNAME-validator"
end
