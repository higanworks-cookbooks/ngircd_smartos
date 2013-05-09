## base settings
default['ngircd']['prefix_dir'] = '/opt/local'
default['ngircd']['conf_dir'] = ::File.join(node['ngircd']['prefix_dir'], 'etc')
default['ngircd']['version'] = '20.2'
default['ngircd']['config_options'] = ["SSL"]


## repository
default['ngircd']['site_url'] = 'http://ngircd.barton.de/pub/ngircd/'
default['ngircd']['arch_file'] = "ngircd-#{node['ngircd']['version']}.tar.gz"

## for tempolary working
default['ngircd']['working_dir'] = ::File.join(Chef::Config[:file_cache_path], 'ngircd')
default['ngircd']['configure_flags'] = " --prefix=#{node['ngircd']['prefix_dir']} --with-openssl"

## ngircd configurations
default['ngircd']['config'] = {
  ## Global
  'g_name'     => node['fqdn'],
  'g_desc'     => 'Description',
  'g_location' => 'Location',
  'g_email'    => 'user@example.com',
  'g_listen'   => '0.0.0.0',
  'g_password' => nil,
  'g_ports'    => [],
  'l_maxcons'    => 0,
  'l_maxcons_ip'    => 10,
  'l_maxjoin'    => 0,
  'l_maxnick'    => 30
}


## motd
default['ngircd']['motd'] =<<EOL
  _   _       _             _
 | \ | |     (_)           | |
 |  \| | __ _ _ _ __ ___ __| |
 | . ` |/ _` | | '__/ __/ _` |
 | |\  | (_| | | | | (_| (_| |
 |_| \_|\__, |_|_|  \___\__,_|
         __/ |  conifigured by the chef for #{node['fqdn']}
        |___/
EOL
