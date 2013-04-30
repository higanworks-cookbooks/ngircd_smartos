#
# Cookbook Name:: ngircd_smartos
# Recipe:: default
#
# Copyright 2013, HiganWorks LLC
#

directory node['ngircd']['working_dir'] do
  action :create
end

bash 'make and install ngircd' do
  action :nothing
  flags '-ex'
  cwd node['ngircd']['working_dir']
  code <<-EOH
  tar xzf #{node['ngircd']['arch_file']}
  cd #{::File.basename(node['ngircd']['arch_file'], '.tar.gz')}
  ./configure #{node['ngircd']['configure_flags']}
  make -j2
  make install
  EOH
end

remote_file ::File.join(node['ngircd']['working_dir'], node['ngircd']['arch_file'])   do
  action :create_if_missing
  source node['ngircd']['site_url'] + node['ngircd']['arch_file']
  notifies :run, 'bash[make and install ngircd]'
end

smf 'ngircd' do
  start_command '/opt/local/sbin/ngircd'
  start_timeout 120
  stop_command  '/usr/bin/pkill ngircd'
  stop_timeout  120
end

service 'ngircd' do
  action :enable
end
