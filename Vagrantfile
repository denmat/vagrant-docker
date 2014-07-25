# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.ssh.private_key_path = "~/.ssh/vagrant.key"
  config.ssh.port = 22
  config.ssh.pty = true 

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

# To run a Vagrant Docker container you need to execute the 
# following command:
# vagrant up --provider=docker 
# (--no-parallel is optional and needed if you want to get the
# puppetmaster up before the other hosts checkin).
# Below is the definition for the local puppet master.
# You can see that it requires dns entries to get to our
# local nameservers (these may need to change depending on 
# which network you are on).
# By default docker will mount the /data_volume/puppet directory 
# into /etc/puppet/environments/production. 
# You can change that to be any absolute path you wish to your puppet
# git checkout. Or you can create the /data_volumes/puppet directory and 
# bind mount your puppet git repo inside it. Then you can use branches to 
# test different version of your puppet code.

  config.vm.define "puppet" do |v|
    v.vm.provider "docker" do |d|
      d.build_dir = "."
      d.has_ssh = true
      d.create_args = ["--hostname=puppet"]
      d.volumes = ["/data_volume/puppet:/etc/puppet/environments/production"]
      d.cmd = ["/usr/sbin/sshd", "-D"]
      d.name = "puppet"
    end
    v.vm.provision 'shell', 
      inline: "puppet cert generate puppet"
    v.vm.provision "puppet" do |puppet|
      puppet.facter = { 'hostname' => 'puppet', 'domain' => '', 'fqdn' => 'puppet' }
      puppet.manifests_path = "data/manifests"
      puppet.manifest_file = "site.pp"
      puppet.module_path = [ "data/local_modules", "data/common_modules" ]
      puppet.hiera_config_path = "data/hiera.yaml"
      puppet.options = [ "--verbose" ]
    end
  end

# Below is an example of a virtual host called 'web1'. This might be some kind of web server or any
# role you wish to assign it.
# You will need to create a web1.docker.yaml file in your hiera node directory and 
# assign classes and the configuration items you wish to give to this host. 
# You can then run vagrant up --provider=docker --no-parallel to get this host to automatically
# check in with the local puppet master when it starts up. 
# There might be somethings that Vagrant/Docker cannot do, like changing Kernel properties and so on
# so they might fail. In that case you run this code entirely inside a Vagrant box (no Docker).
#  config.vm.define "web1" do |v|
#    v.vm.provider "docker" do |d|
#      d.build_dir = "."
#      d.has_ssh = true
#      d.create_args = ["--link=puppet:puppet"]
#      d.volumes = ["/data_volume/puppet:/etc/puppet/environments/production"]
#      d.cmd = ["/usr/sbin/sshd", "-D" ]
#      d.name = "web1"
#    end
#    v.vm.provision "puppet_server" do |puppet|
#      puppet.facter = { 'hostname' => 'web1', 'domain' => 'docker'  }
#      puppet.puppet_server = 'puppet'
#      puppet.puppet_node = 'web1'
#      puppet.options = [ "--verbose", "--debug", "--waitforcert 5" ]
#    end
#  end

end
