#
# Cookbook Name:: awesome_customers
# Recipe:: webserver
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Install Apache and start the service.
httpd_service 'customers' do
  mpm 'prefork'
  action [:create, :start]
end

# Add the site configuration.
httpd_config 'customers' do
  instance 'customers'
  source 'customers.conf.erb'
  notifies :restart, 'httpd_service[customers]'
end

# Create the document root directory.
directory node['awesome_customers']['document_root'] do
  recursive true
end

#
# Write a default home page.
# I changed this from index.php, since I have not yet enabled php 
# 
file "#{node['awesome_customers']['document_root']}/index.html" do
  content '<html>This is a placeholder</html>'
  mode '0644'
  owner node['awesome_customers']['user']
  group node['awesome_customers']['group']
end
