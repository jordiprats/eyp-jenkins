class jenkins::service inherits jenkins {

  #
  validate_bool($jenkins::manage_docker_service)
  validate_bool($jenkins::manage_service)
  validate_bool($jenkins::service_enable)

  validate_re($jenkins::service_ensure, [ '^running$', '^stopped$' ], "Not a valid daemon status: ${jenkins::service_ensure}")

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $jenkins::manage_docker_service)
  {
    if($jenkins::manage_service)
    {
      service { $jenkins::params::service_name:
        ensure     => $jenkins::service_ensure,
        enable     => $jenkins::service_enable,
        hasstatus  => true,
        hasrestart => true,
      }
    }
  }
}
