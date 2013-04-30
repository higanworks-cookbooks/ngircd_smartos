## base settings
default['ngircd']['conf_dir'] = '/opt/local/etc'
default['ngircd']['conf_motd'] = '/opt/local/etc'


## repository
default['ngircd']['site_url'] = 'http://ngircd.barton.de/pub/ngircd/'
default['ngircd']['arch_file'] = 'ngircd-20.2.tar.gz'

## for tempolary working
default['ngircd']['working_dir'] = ::File.join(Chef::Config[:file_cache_path], 'ngircd')
default['ngircd']['configure_flags'] = ' --prefix=/opt/local --with-openssl'
