if $varnish_values == undef { $varnish_values = hiera_hash('varnish', false) }

class varnish (
  $start                        = $varnish_values['service_start'],
  $nfiles                       = $varnish_values['nfiles'],
  $memlock                      = $varnish_values['memlock'],
  $storage_type                 = $varnish_values['storage_type'],
  $varnish_vcl_conf             = '/etc/varnish/default.vcl',
  $varnish_listen_address       = $varnish_values['varnish_listen_address'],
  $varnish_listen_port          = $varnish_values['varnish_listen_port'],
  $varnish_admin_listen_address = '127.0.0.1',
  $varnish_admin_listen_port    = '6082',
  $varnish_min_threads          = '5',
  $varnish_max_threads          = '500',
  $varnish_thread_timeout       = '300',
  $varnish_storage_size         = '1G',
  $varnish_secret_file          = '/etc/varnish/secret',
  $varnish_storage_file         = '/var/lib/varnish-storage/varnish_storage.bin',
  $varnish_ttl                  = '120',
  $shmlog_dir                   = '/var/lib/varnish',
  $shmlog_tempfs                = true,
  $version                      = present,
) {

# read parameters
  include varnish::params

# install Varnish
  class {'varnish::install':
    version => $version,
  }

# enable Varnish service
  class {'varnish::service':
    start => $start,
  }

# mount shared memory log dir as tempfs
  if $shmlog_tempfs {
    class { 'varnish::shmlog':
      shmlog_dir => $shmlog_dir,
      require => Package['varnish'],
    }
  }

# varnish config file
  file { 'varnish-conf':
    ensure  => present,
    path    => $varnish::params::conf_file_path,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('varnish/varnish-conf.erb'),
    require => Package['varnish'],
    notify  => Service['varnish'],
  }

# storage dir
  $varnish_storage_dir = regsubst($varnish_storage_file, '(^/.*)(/.*$)', '\1')
  file { 'storage-dir':
    ensure  => directory,
    path    => $varnish_storage_dir,
    require => Package['varnish'],
  }
}

class { 'varnish::vcl':
  backends => [
    {
      name => $varnish_values['backend_name'],
      host => $varnish_values['backend_host'],
      port => $varnish_values['backend_port']
    },
  ]
}


exec { "chkconfig varnish on":
  command => "chkconfig varnish on && service varnish start"
}

