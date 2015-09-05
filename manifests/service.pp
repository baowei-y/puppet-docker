class docker::service {

  if ( $::docker::service_ensure in [ 'running', 'stopped' ] )  {
    service { 'docker':
      ensure     => $::docker::service_ensure,
      enable     => $::docker::service_enable,
      hasstatus  => true,
      hasrestart => true,
    }
  } else {
    fail('service_ensure parameter must be running or stopped')
  }

}
