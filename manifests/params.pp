class docker::params {

  $fs_dir              = 'puppet:///modules'
  $setup_dir           = '/opt/puppet_docker'
  $path                = '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin'

  $docker_pkg          = ['docker-engine']

  case $::osfamily {
    'Debian' : {
      if $::lsbdistcodename == 'trusty' {
        $kernel_source    = "${fs_dir}/${module_name}/kernel/${::lsbdistcodename}" 
        $docker_repo      = '/etc/apt/sources.list.d/docker.list'
        $docker_repo_temp = "${module_name}/trusty.list.erb"
        $docker_key       = "${setup_dir}/daocloud.key" 
        $docker_key_temp  = "${module_name}/trusty.daocloud.key"
        $docker_conf      = '/etc/default/docker'
        $docker_conf_temp = "${module_name}/docker_conf.erb"
      }
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }  

}
