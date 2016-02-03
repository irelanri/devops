group node['awesome_customers']['group'] 

user node['awesome_customers']['user'] do
	group node['awesome_customers']['group'] 
	system true
	shell '/bin/bash'
end
