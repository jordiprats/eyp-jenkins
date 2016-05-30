# == Class: jenkins
#
# === jenkins documentation
#
class jenkins(
                            $manage_package        = true,
                            $package_ensure        = 'installed',
                            $manage_service        = true,
                            $manage_docker_service = true,
                            $service_ensure        = 'running',
                            $service_enable        = true,
                            $srcdir                = '/usr/local/src',
                          ) inherits jenkins::params{

  class { '::jenkins::install': } ->
  class { '::jenkins::config': } ~>
  class { '::jenkins::service': } ->
  Class['::jenkins']

}
