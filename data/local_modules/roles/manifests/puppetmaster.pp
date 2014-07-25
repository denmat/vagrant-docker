class roles::puppetmaster (
  $database_type = 'embedded',
  $puppetdb_server = $puppetmaster::puppetdb_server,
  $listen_address = $puppetmaster::puppetdb_listen_address,
  $ssl_listen_address = $puppetmaster::ssl_listen_address,
  $disable_ssl = $puppetmaster::disable_ssl
  ) {

  Class['::puppetmaster::client::linux'] -> Class['::puppetmaster::master'] -> Class['puppetdb'] -> Class['puppetdb::master::config']

  class { '::puppetmaster::client::linux': }
  class { '::puppetmaster::master': }

  class { 'puppetdb': 
    listen_address     => $listen_address,
    ssl_listen_address => $ssl_listen_address,
    database           => $database_type,
    disable_ssl        => $disable_ssl
  }

  class { 'puppetdb::master::config': 
    puppetdb_server => $puppetdb_server,
  }

}
