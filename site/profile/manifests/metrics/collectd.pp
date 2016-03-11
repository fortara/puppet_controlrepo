class profile::metrics::collectd {
  $collectd_dir = '/etc/collectd'
  $collectd_version = '5.1.0'

  package { ['perl', 'perl-devel']:
    ensure => present,
  }

  class { '::collectd':
    purge_config   => true,
    package_ensure => absent,
    require        => Exec['install_collectd'],
  }

  include ::collectd::plugin::cpu
  include ::collectd::plugin::disk
  #include ::collectd::plugin::java
  include ::collectd::plugin::memory
  include ::collectd::plugin::interface

  collectd::plugin::write_graphite::carbon {'my_graphite':
    graphitehost   => 'metrics.methodology.com',
    graphiteport   => 2003,
    graphiteprefix => '',
    protocol       => 'tcp'
  }

  # Have to compile from source because the packages are ooold
  require ::gcc

  file { $collectd_dir:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  staging::file { "collectd-${collectd_version}-1.rft.src.rpm":
    target  => $collectd_dir,
    source  => "http://pkgs.repoforge.org/collectd/collectd-${collectd_version}-1.rft.src.rpm",
    require => File[$collectd_dir],
  }

  package { 'collectd':
    ensure   => present,
    source   => "${collectd_dir}/collectd-${collectd_version}-1.rft.src.rpm",
    provider => 'rpm',
  }
}
