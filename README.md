= About

A Fedora based vagrant environment for testing multi-machine OpenShift clusters.

== Features

 * Ability to destroy and re-create the environment as necessary.
 * Fully functional DNS within the libvirt network *and* on the host. Systems always at a predictable hostname even after a destroy.
 * No subscriptions required. (uses internal repositories)
 * Uses KVM and libvirt, no need for VirtualBox performance hit.

== Configuring Fedora

 * `dnf install -y vagrant vagrant-libvirt`
 * Add user username to /etc/groups in the vagrant group and log back in.
 * `vagrant plugin install vagrant-triggers`
 * `virsh net-edit default`

   Ensure the domain looks like the following, localOnly is very important here:

   ```
<network>
  <name>default</name>
  <uuid>abbdba46-dd37-40c9-a9d6-1c6146c4197b</uuid>
  <forward mode='nat'/>
  <bridge name='virbr0' stp='on' delay='0'/>
  <mac address='52:54:00:85:da:72'/>
  <domain name='aos.example.com' localOnly='yes'/>
  <ip address='192.168.122.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.122.2' end='192.168.122.254'/>
    </dhcp>
  </ip>
</network>
   ```

 * `virsh net-destroy default`
 * `virsh net-start default`
 * Get the RHEL 7.2 CDK libvirt Vagrant image: https://access.redhat.com/downloads/content/293/ver=2/rhel---7/2.0.0/x86_64/product-software
 * Switch NetworkManager to use dnsmasq, forwarding requests for aos.example.com to the libvirt network:
   Edit /etc/NetworkManager/NetworkManager.conf and in [main] add dns=dnsmasq
 * Forward aos.example.com requests to the libvirt network:
   ```
$ cat /etc/NetworkManager/dnsmasq.d/libvirt_dnsmasq.conf
server=/aos.example.com/192.168.122.1
   ```
 * TODO: solve complications with using VPN which modifies /etc/resolv.conf on the fly. Can drop a similar script for redhat.com in but this then picked up when trying to CONNECT to the vpn.
 * systemctl restart NetworkManager

== Usage

You can now run `vagrant up` to bring up the entire cluster, or `vagrant up m1 n1` to just bring up a subset. Remember to run update-hosts.rb each time the vms are created fresh to update the included hosts file with the new IPs. Libvirt will give them consistent IPs as long as the MAC address does not change, so you only need to do this each time you explicitly destroy them. (halt + up will be fine)

`vagrant halt` will shutdown the vms, `vagrant destroy` will wipe them out entirely so you can rebuild. (be sure to re-run update-hosts.rb)

Modify the included hosts file for your desired installation and run ansible.

