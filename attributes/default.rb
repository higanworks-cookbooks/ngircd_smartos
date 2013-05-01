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
