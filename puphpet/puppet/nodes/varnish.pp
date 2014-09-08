if $varnish_values == undef { $varnish_values = hiera_hash('varnish', false) }

class { 'varnish':

  varnish_listen_port => $varnish_values['varnish_listen_port'],
  varnish_storage_size => $varnish_values['varnish_storage_size'],

}

