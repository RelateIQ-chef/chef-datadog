include_recipe 'datadog::dd-agent'

# Monitor mongo
#
# node.set['datadog']['mongo']['instances'] = [
#   {
#     'host' => 'localhost',
#     'port' => '27017'
#   }
# ]

datadog_monitor 'mongo' do
  instances node['datadog']['mongo']['instances']
end

# shouldn't this be inferrable?
dd_checks_dir = '/opt/datadog-agent/agent/checks.d'
directory dd_checks_dir do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
    recursive true
end

cookbook_file "#{dd_checks_dir}/mongo.py" do
    source "mongo.py"
    owner "root"
    group "root"
    mode 00644
    action :create
    notifies :restart, 'service[datadog-agent]'
end
