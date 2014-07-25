class roles::common {

  $common_packages = hiera_hash('common_packages')
  $common_users = hiera_hash('common_users')
  $dns_addresses = hiera_hash('dns_address', 'no_hash')

  $get_puppetmaster_ip = generate("/usr/bin/facter", "ipaddress")

  if is_hash($common_packages) {
    create_resources(package, $common_packages)
  }
  if is_hash($common_users) {
    create_resources(user, $common_users)
  }

  # need to create the /etc/sysconfig/network file or
  # dnsmasq wont start
  file {'/etc/sysconfig/network':
    ensure  => present,
    content => "NETWORKING=yes"
  }

  class { 'dnsmasq':
    listen_address => [ "$get_puppetmaster_ip", "127.0.0.1" ],
    domain         => 'docker',
    port           => '53',
    no_hosts       => true,
    require        => File['/etc/sysconfig/network'],
    run_as_user    => 'root'
  }

  dnsmasq::address { 'puppet':
    ip  => $get_puppetmaster_ip,
  }

  if is_hash($dns_addresses) {
    create_resources(dnsmasq::address, $dns_addresses)
  }
}
