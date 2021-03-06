$script_ADD_IT_locale = <<-SCRIPT
    echo "ADD it_IT locale"
    sed -i -e 's/# it_IT.UTF-8 UTF-8/it_IT.UTF-8 UTF-8/' /etc/locale.gen
    locale-gen
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "debian/jessie64"

  # SET LOCALE
  ENV['LC_ALL']="it_IT.UTF-8"

  # Specific VM settings
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.name = "iGruppi-Dev_Vagrant_01"
    vb.memory = 1024
    vb.cpus = 1
    vb.customize ["modifyvm", :id, "--audio", "none"]
  end  

  # Forward port 80
  config.vm.network "forwarded_port", guest: 80, host: 8888

  # DISABLE the default Vagrant share
  config.vm.synced_folder ".", "/vagrant", disabled: true

  # ADD IT LOCALE
  config.vm.provision "shell", inline: $script_ADD_IT_locale

  # PROVISION LAMP
  config.vm.provision "shell" do |s|
    s.path = "provision/init_lamp.sh"
    s.name = "init_lamp"
    s.env = {"DEBIAN_FRONTEND" => "noninteractive"}
    s.args = ["LAMP Env"]
  end

  # PROVISION iGruppi
  config.vm.provision "shell" do |ss|
    ss.path = "provision/init_igruppi_env.sh"
    ss.name = "init_igruppi_env"
    ss.args = "iGruppi Env"
  end

  # SHARE admin folder
  config.vm.synced_folder "../igruppi", "/var/www/igruppi"

end
