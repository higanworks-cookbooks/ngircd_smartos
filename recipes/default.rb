#
# Cookbook Name:: ngircd_smartos
# Recipe:: default
#
# Copyright 2013, HiganWorks LLC
#

include_recipe 'ngircd_smartos::binary'

smf 'ngircd' do
  start_command '/opt/local/sbin/ngircd'
  start_timeout 120
  stop_command  '/usr/bin/pkill ngircd'
  stop_timeout  120
end

service 'ngircd' do
  action :enable
end
