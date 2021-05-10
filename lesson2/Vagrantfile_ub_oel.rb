# _*_ mode: ruby _*_
# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # General Vagrant VM configurations
  #config.vm.box = "generic/oracle7"
  config.ssh.insert_key = false
  config.vm.synced_folder ".","/vagrant", disabled: true
  config.vm.provider :virtualbox do |v|
      v.memory = 2048
      #v.linked_clone = true
  end

  # Control server.
  config.vm.define "control" do |ctl|
    ctl.vm.hostname = "control.example.com"
	ctl.vm.box = "ubuntu/trusty64"
    ctl.vm.network :private_network, ip:"192.168.60.10"
  end

  # Application server 1.
  config.vm.define "app" do |app|
	app.vm.box = "generic/oracle7"
    app.vm.hostname = "app.example.com"
    app.vm.network :private_network, ip:"192.168.60.11"
  end


 #   DB server 2.
  config.vm.define "db" do |db|
	db.vm.box = "generic/oracle7"
    db.vm.hostname = "db.example.com"
    db.vm.network :private_network, ip:"192.168.60.12"
  end



end
