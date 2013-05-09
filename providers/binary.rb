action :create do
  directory node['ngircd']['working_dir'] do
    action :create
  end

  unless new_resource.version == @current_resource.version and new_resource.options - @current_resource.options == []
    ::Chef::Log.info "Install ngircd"
    node.set['ngircd']['arch_file'] = "ngircd-#{new_resource.version}.tar.gz"

    remote_file ::File.join(node['ngircd']['working_dir'], node['ngircd']['arch_file'])   do
      action :create
      source node['ngircd']['site_url'] + node['ngircd']['arch_file']
    end

    bash 'make and install ngircd' do
      action :run
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

    ## clean up workdir
    directory ::File.join(node['ngircd']['working_dir'], ::File.basename(node['ngircd']['arch_file'], '.tar.gz')) do
      action :delete
      recursive true
    end

    new_resource.updated_by_last_action(true)
  end
end

def load_current_resource
  @current_resource = Chef::Resource::NgircdSmartosBinary.new(new_resource.name)
  if ::File.exist?(::File.join(node['ngircd']['prefix_dir'], 'sbin/ngircd'))
    @current_resource.version `ngircd -V`.split[1].split('-')[0]
    @current_resource.options `ngircd -V`.split[1].split("-")[1].split("+")
  else
    @current_resource.version '0.0'
    @current_resource.options []
  end
end
