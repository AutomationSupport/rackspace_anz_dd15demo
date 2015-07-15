#
# Cookbook Name:: rackspace_anz_dd15demo
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

web_app 'my_app' do
  template 'web_app.conf.erb'
  server_name node['hostname']
  # server_name node['fqdn']
  # server_aliases [node['fqdn']]
  docroot '/var/www/html'
  # cookbook 'demo-haproxy'
  directory_index true
end

template '/var/www/html/index.html' do
  source 'index.html.erb'
  variables(
    fqdn: node['fqdn']
  )
end

tag('webserver')
