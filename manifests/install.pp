# == Class: jenkins
#
# === jenkins::install documentation
#
class jenkins::install inherits jenkins {

  Exec {
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
  }

  if($jenkins::manage_package)
  {
    # package here, for example:
    #package { $jenkins::params::package_name:
    #  ensure => $jenkins::package_ensure,
    #}

    #wget http://pkg.jenkins-ci.org/debian-stable/$(curl http://pkg.jenkins-ci.org/debian-stable/ 2>/dev/null | grep -Eo "<a href='binary[^']*'" | cut -f2 -d= | cut -f2 -d"'" | head -n1)
    exec { "get jenkins package ${srcdir}":
      command => "bash -c 'wget http://pkg.jenkins-ci.org/debian-stable/$(curl http://pkg.jenkins-ci.org/debian-stable/ 2>/dev/null | grep -Eo \"<a href='\"'\"'binary[^'\"'\"']*'\"'\"'\" | cut -f2 -d= | cut -f2 -d\"'\"'\"'\" | head -n1) -O ${srcdir}/jenkins.${jenkins::params::package_provider}'",
      creates => "${srcdir}/jenkins.${jenkins::params::package_provider}",
    }

    package { 'jenkins':
      ensure => 'installed',
      provider => $jenkins::params::package_provider,
      source => "${srcdir}/jenkins.${jenkins::params::package_provider}",
      require => Exec["get jenkins package ${srcdir}"],
    }

  }

}
