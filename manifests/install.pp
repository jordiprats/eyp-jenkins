# == Class: jenkins
#
# === jenkins::install documentation
#
class jenkins::install inherits jenkins {

  if($jenkins::manage_package)
  {
    # package here, for example: 
    #package { $jenkins::params::package_name:
    #  ensure => $jenkins::package_ensure,
    #}
  }

}
