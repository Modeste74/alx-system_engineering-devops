# configure nginx
package { 'nginx':
  ensure => 'installed',
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
