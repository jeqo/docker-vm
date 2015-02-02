# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"

  disk_path = "./disk1.vdi"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", 4096]
    vb.customize ["modifyvm", :id, "--name"  , "docker-vm"]
    vb.customize ["modifyvm", :id, "--cpus"  , 2]
    vb.customize ["modifyvm", :id, "--chipset", "ich9"]

    #Script to add a new disk and expand space on OS (root and swap)
    if ARGV[0] == "up" && ! File.exist?(disk_path)
      vb.customize [
        'createhd',
        '--filename', disk_path,
        '--format', 'VDI',
        '--size', 180 * 1024
      ]

      vb.customize [
        'storageattach', :id,
        '--storagectl', 'SATAController',
        '--port', 1, '--device', 0,
        '--type', 'hdd', '--medium',
        disk_path
      ]
    end
  end

  if ARGV[0] == "up" && ! File.exist?(disk_path)
    config.vm.provision "shell" do |s|
      s.path = "bootstrap.sh"
    end

    config.vm.provision "shell" do |s|
      s.path = "increase_swap.sh"
      s.args = 2048
    end
  end

  config.omnibus.chef_version = :latest

  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = "chef-repo/cookbooks"
    chef.roles_path = "chef-repo/roles"
    chef.add_recipe "docker::install-docker"
    chef.add_recipe "docker::install-fig"
  end
end
