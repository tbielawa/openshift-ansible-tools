#!/usr/bin/ruby

require 'fileutils'
require 'resolv'

if File.exist?('hosts')
  puts "Hosts file exists, moving it to hosts.bak"
  FileUtils.mv('hosts', 'hosts.bak')
end

resolver = Resolv::DNS.new()
File.open("hosts", "w") do |new_file|
  File.open("hosts.bak", "r") do |orig_file|
    in_hosts = false
    orig_file.each_line do |l|
      if l.strip == "[masters]" or l.strip == "[nodes]"
        in_hosts = true
        new_file.puts l
        next
      elsif l[0] == "["
        in_hosts = false
        new_file.puts l
        next
      end

      if in_hosts and l.strip != '' and l[0] != '#'
        tokens = l.split(" ")
        hostname = tokens[0]
        ip = resolver.getaddress(hostname)
        new_tokens = []
        tokens.each do |t|
          if t.start_with?('openshift_ip=')
            new_tokens << "openshift_ip=#{ip.to_s}"
          elsif t.start_with?('openshift_public_ip=')
            new_tokens << "openshift_public_ip=#{ip.to_s}"
          else
            new_tokens << t
          end
        end
        new_file.puts new_tokens.join(" ")
      else
        new_file.puts l
      end
    end
  end
end

