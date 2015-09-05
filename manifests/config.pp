class docker::config {

  file { 'docker_conf':
    owner   => 0,
    group   => 0,
    mode    => 0644,
    backup  => ".$::backup_date",
    path    => $::docker::docker_conf,
    content => template($::docker::docker_conf_temp),
  }  

}
