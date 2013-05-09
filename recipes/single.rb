## setup single Server

template node['ngircd']['conf_dir'] + '/ngircd.conf' do
  source 'ngircd.conf.erb'
  notifies :restart, 'service[ngircd]'
  variables node['ngircd']['config']
end

template node['ngircd']['conf_dir'] + '/ngircd.motd' do
  source 'ngircd.motd.erb'
  notifies :restart, 'service[ngircd]'
end
