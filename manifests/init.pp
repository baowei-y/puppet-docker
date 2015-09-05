class docker (

  $kernel_update  = true,
  $docker_opts    = '-s overlay --log-driver=none',
  $service_enable = true,
  $service_ensure = running,

) inherits ::docker::params {

  if ( $::virtual != 'lxc' ) {
    if $::kernelversion >= '4.0.9' {
      anchor { 'docker::begin': } ->
      class { '::docker::pre': } ->
      class { '::docker::install': } ->
      class { '::docker::config': } ~>
      class { '::docker::service': } ->
      anchor { 'docker::end': }
    } else {
      include ::docker::pre
      notify { 'warn':
        message => "kernel version is ${::kernelversion}, must be equal or greater than '4.0.9'"
      }
    }
  } 
  
}
