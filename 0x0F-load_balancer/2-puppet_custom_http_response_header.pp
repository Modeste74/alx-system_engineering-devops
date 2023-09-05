# configure nginx by creating a custom HTTP header response
exec { 'update':
  command  => 'sudo apt-get update',
  provider => 'shell',
}
exec { 'upgrade':
  command  => 'sudo apt-get -y upgrade',
  provider => 'shell',
}
exec { 'install_nginx':
  provider => 'shell',
  command  => '/usr/bin/apt-get -y install nginx',
}
file { '/etc/nginx/sites-available/default':
  ensure => present,
  notify => Exec['add_custom_header'],
}
exec { 'add_custom_header':
  command     => "sed -i '54i\\tadd_header X-Served-By $HOSTNAME;' /etc/nginx/sites-available/default",
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
