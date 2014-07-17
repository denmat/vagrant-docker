# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.ssh.private_key_path = "~/.ssh/vagrant.key"
  config.ssh.port = 22
  config.ssh.pty = true 

  config.vm.define "puppet" do |v|
    v.vm.provider "docker" do |d|
      d.build_dir = "."
      d.has_ssh = true
      d.volumes = ["/data_volume/puppet:/etc/puppet/environments/production"]
      d.cmd = ["/usr/sbin/sshd", "-D"]
      d.name = "puppet"
    end
    v.vm.provision 'shell', 
      inline: "facter hostname && echo '' && facter domain"
    v.vm.provision "puppet" do |puppet|
      puppet.facter = { 'hostname' => 'puppet', 'domain' => 'docker' }
      puppet.manifests_path = "data/manifests"
      puppet.manifest_file = "site.pp"
      puppet.module_path = [ "data/local_modules", "data/common_modules" ]
      puppet.hiera_config_path = "data/hiera.yaml"
      puppet.options = [ "--verbose" ]
    end
  end

end
