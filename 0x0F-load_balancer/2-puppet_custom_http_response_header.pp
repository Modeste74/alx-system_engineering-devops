# configure nginx by creating a custom HTTP header response
class { 'nginx':
  ensure => 'installed',
}
file { '/etc/nginx/sites-available/default':
  ensure => present,
  notify => Exec['add_custom_header'],
}
exec { 'add_custom_header':
  command     => "sed -i '54i\\tadd_header X-Served-By \$hostname;' /etc/nginx/sites-available/default",
  path        => '/bin:/usr/bin',
  refreshonly => true,
  subscribe   => File['/etc/nginx/sites-available/default'],
}
exec { 'restart_nginx':
  command     => 'service nginx restart',
  provider    => 'shell',
  refreshonly => true,
  subscribe   => Exec['add_custom_header'],
}
