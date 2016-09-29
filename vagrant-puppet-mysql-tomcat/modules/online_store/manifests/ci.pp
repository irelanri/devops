class online_store::ci {
	include online_store

	package { ['git', 'maven2', 'openjdk-6-jdk']:
		ensure => "installed",
	}

	class { 'jenkins':
		config_hash => {
			'JAVA_ARGS' => { 'value' => '-Xmx256m' }
		},
	}

	$plugins = [
		'ssh-credentials',
		'credentials',
		'scm-api',
		'git-client',
		'git',
		'maven-plugin',
		'javadoc',
		'mailer',
		'greenballs',

		'matrix-project', #added, required by ws-cleanup

		'ws-cleanup',

		'structs', #all added below
		'junit',
		'display-url-api',
		'script-security',
		#'project',
		'workflow-scm-step',
		'workflow-step-api'
	]

	jenkins::plugin { $plugins: }

	file { '/var/lib/jenkins/hudson.tasks.Maven.xml':
		mode => 0644,
		owner => 'jenkins',
		group => 'jenkins',
		source => 'puppet:///modules/online_store/hudson.tasks.Maven.xml',
		require => Class['jenkins::package'],
		notify => Service['jenkins'],
	}

	$job_structure = [
		'/var/lib/jenkins/jobs/',
		'/var/lib/jenkins/jobs/loja-virtual-devops'
	]

	#### This section added to overcome Maven repo changes ####
	$maven_repository_alias_structure = '/var/lib/jenkins/.m2'
	file { $maven_repository_alias_structure:
		ensure => 'directory',
		owner => 'jenkins',
		group => 'jenkins',
		require => Class['jenkins::package'],
	}
	file { "${maven_repository_alias_structure}/settings.xml":
		mode => 0644,
		owner => 'jenkins',
		group => 'jenkins',
		source => 'puppet:///modules/online_store/settings.xml',
		require => File[$maven_repository_alias_structure],
	}
	#### End of section ####

	$git_repository = 'https://github.com/irelanri/loja-virtual-devops.git'
	$git_poll_interval = '* * * * *'
	$maven_goal = 'install'
	$archive_artifacts = 'combined/target/*.war'

	file { $job_structure:
		ensure => 'directory',
		owner => 'jenkins',
		group => 'jenkins',
		require => Class['jenkins::package'],
	}

	file { "${job_structure[1]}/config.xml":
		mode => 0644,
		owner => 'jenkins',
		group => 'jenkins',
		content => template('online_store/config.xml'),
		require => File[$job_structure],
		notify => Service['jenkins'],
	}

}
