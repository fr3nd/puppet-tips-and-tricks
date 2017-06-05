# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"
  config.vm.hostname = "puppet-talk.localdomain"
  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end

  config.vm.provision "shell", inline: <<-SHELL
    sudo rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
    sudo yum -y install puppetserver tree git wget
    sudo wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-9.noarch.rpm
    sudo rpm -iv epel-release-7-9.noarch.rpm
    sudo yum install -y fortune-mod graphviz ImageMagick xorg-x11-xauth
    echo PATH=$PATH:/opt/puppetlabs/bin/:/opt/puppetlabs/puppet/bin/ | sudo tee /etc/profile.d/puppet.sh
    echo "JAVA_ARGS=\'-Xms1g -Xmx1g -XX:MaxPermSize=256m\'" | sudo tee -a /etc/sysconfig/puppetserver
    sudo systemctl start puppetserver &
    sudo systemctl enable puppetserver
    sudo /opt/puppetlabs/bin/puppet resource host puppet ip=127.0.0.1
    sudo rsync -av --delete /vagrant/control-repo/ /etc/puppetlabs/code/
    sudo /opt/puppetlabs/puppet/bin/gem install r10k -v 2.5.2
    sudo /opt/puppetlabs/puppet/bin/r10k puppetfile install  --verbose --puppetfile /etc/puppetlabs/code/Puppetfile --moduledir /etc/puppetlabs/code/modules/
    sudo curl -L https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 > /usr/bin/jq
    sudo chmod +x /usr/bin/jq
    sudo mkdir -p /etc/facter/facts.d
    sudo rsync -av --delete /vagrant/facts.d/ /etc/facter/facts.d
    sudo xauth add $(xauth -f ~vagrant/.Xauthority list|tail -1)
  SHELL
end
