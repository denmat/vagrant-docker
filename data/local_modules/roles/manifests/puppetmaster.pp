class roles::puppetmaster (
  $database_type = 'embedded',
  $puppetdb_server = '127.0.0.1',
  $listen_address = '127.0.0.1',  
  $ssl_listen_address = '127.0.0.1',
  $disable_ssl = true
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