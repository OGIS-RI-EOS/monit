if platform_family?("rhel")
  include_recipe "yum-repoforge"
end

package "monit"

if platform?("ubuntu")
  cookbook_file "/etc/default/monit" do
    source "monit.default"
    owner "root"
    group "root"
    mode 0644
  end
end

service "monit" do
  action [:enable, :start]
  enabled true
  supports [:start, :restart, :stop]
end

directory node[:monit][:conf_dir] do
  owner  'root'
  group 'root'
  mode 0755
  action :create
  recursive true
end

template node[:monit][:monitrc] do
  owner "root"
  group "root"
  mode 0700
  source 'monitrc.erb'
  notifies :restart, resources(:service => "monit"), :delayed
end
