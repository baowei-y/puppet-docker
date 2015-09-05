class docker::install {
 
  File {
    owner       => 0,
    group       => 0,
    mode        => 0644,
    backup      => ".$::backup_date",
  }

  Exec {
    logoutput   => on_failure,
    path        => $::docker::path,
  }

  file { 'daocloud_key':
    path        => $::docker::docker_key,
    content     => template($::docker::docker_key_temp)
  }  

  exec { 'install_daocloud_key':
    timeout     => 60,
    refreshonly => true,
    require     => File['daocloud_key'],
    subscribe   => File['daocloud_key'],
    command     => "apt-key add ${::docker::docker_key}"
  }

  file { 'daocloud_repo':
    path        => $::docker::docker_repo,
    require     => Exec['install_daocloud_key'],
    content     => template($::docker::docker_repo_temp)
  }

  exec { 'docker_repo_update':
    timeout     => 300,
    refreshonly => true,
    require     => File['daocloud_repo'],
    subscribe   => File['daocloud_repo'],
    command     => "apt-get update"
  }
  
  package { $::docker::docker_pkg:
    require     => Exec[docker_repo_update],
    ensure      => present,
  }

}
