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

#
# Load the secrets file and the encrypted data bag item that holds the root password.
# Added during PHP section of lesson
#
password_secret = Chef::EncryptedDataBagItem.load_secret(node['awesome_customers']['passwords']['secret_path'])
password_data_bag_item = Chef::EncryptedDataBagItem.load('passwords', 'sql_server_root_password', password_secret)

#
# Replace file with template so we can drop in DB connection string etc
#
#file "#{node['awesome_customers']['document_root']}/index.html" do
#  content '<html>This is a placeholder</html>'
#
template "#{node['awesome_customers']['document_root']}/index.php" do
  source 'index.php.erb'
  mode '0644'
  owner node['awesome_customers']['user']
  group node['awesome_customers']['group']
  variables(
      :database_password => password_data_bag_item['password']
  )
end

# Install the mod_php5 Apache module.
httpd_module 'php5' do
  instance 'customers'
end

# Install php5-mysql.
package 'php5-mysql' do
  action :install
  notifies :restart, 'httpd_service[customers]'
end
