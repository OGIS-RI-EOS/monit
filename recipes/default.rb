if platform_family?("rhel")
  include_recipe "yum::repoforge"
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

if platform_family?("rhel")
  directory "/etc/monit.d/" do
    owner  'root'
    group 'root'
    mode 0755
    action :create
    recursive true
  end
  template "/etc/monit.conf" do
    owner "root"
    group "root"
    mode 0700
    source 'monitrc.erb'
    notifies :restart, resources(:service => "monit"), :delayed
  end       
else
  # if platform?("Ubuntu") 
  directory "/etc/monit/conf.d/" do
    owner  'root'
    group 'root'
    mode 0755
    action :create
    recursive true
  end
  template "/etc/monit/monitrc" do
    owner "root"
    group "root"
    mode 0700
    source 'monitrc.erb'
    notifies :restart, resources(:service => "monit"), :delayed
  end
end
