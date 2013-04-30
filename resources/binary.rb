actions :create, :delete

default_action :create

attribute :version, :kind_of => String, :default => node['ngircd']['version']
attribute :options, :kind_of => Array, :default => node['ngircd']['config_options']

