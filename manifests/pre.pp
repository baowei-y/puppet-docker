class docker::pre {

  $setup_dir = $::docker::setup_dir

  file { $setup_dir:
    owner   => 0,
    group   => 0,
    recurse => true,
    mode    => 0755,
    ensure  => directory,
    source  => $::docker::kernel_source
  } 

  if $::docker::kernel_update { 
    case $::osfamily {
      'Debian': {
        exec { 'kernel update':
          timeout   => 300,
          logoutput => on_failure,
          path      => $::docker::path,
          require   => File[$setup_dir],
          command   => "dpkg -i ${setup_dir}/*.deb",
          onlyif    => 'test ! -f /usr/src/linux-headers-4.0.9-040009/sound/ppc/Makefile',
        }
      }
      default: {
        fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
      }
    } 

  }

}
