class online_store::web { 

	include online_store
	include mysql::client
	include online_store::params

	file { $online_store::params::keystore_file:
		mode	=> 0644,
		source	=> "puppet:///modules/online_store/.keystore",
	}
	
	class { "tomcat::server":
		connectors => [$online_store::params::ssl_connector],
		data_sources => {
			"jdbc/web"	=> $online_store::params::db,
			"jdbc/secure"	=> $online_store::params::db,
			"jdbc/storage"	=> $online_store::params::db,
		},
		require	=> File[$online_store::params::keystore_file],
	}
	
	file { "/var/lib/tomcat7/webapps/devopsnapratica.war":
		owner => tomcat7,
		group => tomcat7,
		mode => 0644,
		source => "puppet:///modules/online_store/devopsnapratica.war",
		require => Package["tomcat7"],
		notify => Service["tomcat7"],
	}
}
