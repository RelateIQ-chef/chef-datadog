include_recipe 'datadog::dd-agent'

datadog_monitor 'mongo' do
  instances node['datadog']['mongo']['instances']
  logs node['datadog']['mongo']['logs']
end
