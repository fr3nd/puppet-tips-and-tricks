# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end

  config.vm.provision "shell", inline: <<-SHELL
    sudo rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
    sudo yum -y install puppetserver tree git
    echo PATH=$PATH:/opt/puppetlabs/bin/:/opt/puppetlabs/puppet/bin/ | sudo tee /etc/profile.d/puppet.sh
    echo "JAVA_ARGS=\'-Xms1g -Xmx1g -XX:MaxPermSize=256m\'" | sudo tee -a /etc/sysconfig/puppetserver
    sudo systemctl start puppetserver &
    sudo systemctl enable puppetserver
    sudo /opt/puppetlabs/bin/puppet resource host puppet ip=127.0.0.1
    sudo rsync -av --delete /vagrant/control-repo/ /etc/puppetlabs/code/
    sudo /opt/puppetlabs/puppet/bin/gem install r10k -v 2.5.2
    sudo /opt/puppetlabs/puppet/bin/r10k puppetfile install  --verbose --puppetfile /etc/puppetlabs/code/Puppetfile --moduledir /etc/puppetlabs/code/modules/
  SHELL
end
