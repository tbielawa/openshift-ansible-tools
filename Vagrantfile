# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'fileutils'
require 'resolv'

Vagrant.configure('2') do |config|

  config.vm.provider :libvirt do |libvirt|
    libvirt.management_network_name = "default"
    libvirt.management_network_address = "192.168.122.0/24"
  end

  config.vm.synced_folder ".", "/var/vagrant", type: "rsync"

  config.vm.provision "shell" do |s|
    #ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip
    ssh_pub_key = File.readlines("/home/dgoodwin/.ssh/id_rsa.pub").first.strip
    s.inline = <<-SHELL
    mkdir /root/.ssh
    chmod 700 /root/.ssh
    echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
    echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
    SHELL
  end

  config.vm.define :m1 do |master|
    # From RHEL CDK:
    master.vm.box = 'rhel-server-7.2'
    master.vm.hostname = "m1.aos.example.com"

    master.vm.provider :libvirt do |domain|
      domain.memory = 4096
      domain.cpus = 1
      domain.storage :file, :size => '10G'
    end

    master.vm.provision :shell do |s|
#      echo "192.168.133.10 m1.aos.example.com m1" >> /etc/hosts
      s.inline = <<-SHELL
      echo "127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4" > /etc/hosts
      echo "::1         localhost localhost.localdomain localhost6 localhost6.localdomain6" >> /etc/hosts
      echo "DHCP_HOSTNAME=m1.aos.example.com" >> /etc/sysconfig/network-scripts/ifcfg-eth0
      systemctl restart NetworkManager
      SHELL
    end

  end

  config.vm.define :n1 do |n1|

    # From RHEL CDK:
    n1.vm.box = 'rhel-server-7.2'
    n1.vm.hostname = "n1.aos.example.com"

    n1.vm.provider :libvirt do |domain|
      domain.memory = 4096
      domain.cpus = 1
      domain.storage :file, :size => '10G'
    end

    n1.vm.provision :shell do |s|
      s.inline = <<-SHELL
      echo "127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4" > /etc/hosts
      echo "::1         localhost localhost.localdomain localhost6 localhost6.localdomain6" >> /etc/hosts
      echo "DHCP_HOSTNAME=n1.aos.example.com" >> /etc/sysconfig/network-scripts/ifcfg-eth0
      systemctl restart NetworkManager
      SHELL
    end

  end

  config.vm.define :n2 do |n2|

    # From RHEL CDK:
    n2.vm.box = 'rhel-server-7.2'
    n2.vm.hostname = "n2.aos.example.com"

    n2.vm.provider :libvirt do |domain|
      domain.memory = 4096
      domain.cpus = 1
      domain.storage :file, :size => '10G'
    end

    n2.vm.provision :shell do |s|
      s.inline = <<-SHELL
      echo "127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4" > /etc/hosts
      echo "::1         localhost localhost.localdomain localhost6 localhost6.localdomain6" >> /etc/hosts
      echo "DHCP_HOSTNAME=n2.aos.example.com" >> /etc/sysconfig/network-scripts/ifcfg-eth0
      systemctl restart NetworkManager
      SHELL
    end

  end

  config.vm.define :n3 do |n3|

    # From RHEL CDK:
    n3.vm.box = 'rhel-server-7.2'
    n3.vm.hostname = "n3.aos.example.com"

    n3.vm.provider :libvirt do |domain|
      domain.memory = 4096
      domain.cpus = 1
      domain.storage :file, :size => '10G'
    end

    n3.vm.provision :shell do |s|
      s.inline = <<-SHELL
      echo "127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4" > /etc/hosts
      echo "::1         localhost localhost.localdomain localhost6 localhost6.localdomain6" >> /etc/hosts
      echo "DHCP_HOSTNAME=n3.aos.example.com" >> /etc/sysconfig/network-scripts/ifcfg-eth0
      systemctl restart NetworkManager
      SHELL
    end

  end

  config.vm.provision "shell", path: "addstorage.sh"

  #config.trigger.before :up do
    #if File.exist?('hosts')
      #puts "Hosts file exists, moving it to hosts.bak"
      #FileUtils.mv('hosts', 'hosts.bak')
    #end
  #end

  #config.trigger.after :up do
    #resolver = Resolv::DNS.new()
    #if File.exist?('hosts.bak') and !File.exist?('hosts') # only do this once
      #puts "hosts.bak exists, writing new hosts inventory with updated IPs"
      #File.open("hosts", "w") do |new_file|
        #File.open("hosts.bak", "r") do |orig_file|
          #in_hosts = false
          #orig_file.each_line do |l|
            #if l.strip! == "[masters]" or l.strip! == "[nodes]"
              #in_hosts = true
              #new_file.puts l
              #next
            #elsif l[0] == "["
              #in_hosts = false
              #new_file.puts l
              #next
            #end

            #if in_hosts and l.strip! != ""
              #tokens = l.split(" ")
              #hostname = tokens[0]
              #puts "Looking up DNS for: #{hostname}"
              #ip = resolver.getaddress(hostname)
              #puts ip
              #new_tokens = []
              #tokens.each do |t|
                #if t.start_with?('openshift_ip=')
                  #new_tokens << "openshift_ip=#{ip.to_s}"
                #elsif t.start_with?('openshift_public_ip=')
                  #new_tokens << "openshift_public_ip=#{ip.to_s}"
                #else
                  #new_tokens << t
                #end
              #end
              #new_file.puts new_tokens.join(" ")
            #else
              #new_file.puts l
            #end
          #end
        #end
      #end
    #end
  #end

end

