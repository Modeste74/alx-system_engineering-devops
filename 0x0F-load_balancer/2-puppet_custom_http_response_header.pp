# configure nginx
exec { 'command':
  command  => 'apt-get -y update;
  apt-get -y install nginx',
  provider => shell,
}
file { '/etc/nginx/sites-available/default':
  content => template('path/to/nginx_config.erb'),
  notify  => Service['nginx'],
}

service { 'nginx':
  ensure => 'running',
  enable => true,
}

exec { 'add_custom_header':
  command => "sed -i '/listen 80 default_server;/a add_header X-Served-By ${hostname};' /etc/nginx/sites-available/default",
  require => File['/etc/nginx/sites-available/default'],
}
exec { 'Nginx restart':
  provider => shell,
  command  => 'sudo service nginx restart',
}
