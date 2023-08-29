# Install Nginx package
package { 'nginx':
  ensure => installed,
}

# Start and enable Nginx service
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}

# Configure Nginx site
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => "
    server {
      listen 80;
      server_name _;
      
      location / {
        return 301 http://\$host/redirect_me;
      }
      
      location /redirect_me {
        return 301 http://\$host/;
      }
    }
  ",
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Ensure Nginx is listening on port 80
file { '/etc/nginx/sites-enabled/000-default':
  ensure  => link,
  target  => '/etc/nginx/sites-available/default',
  require => File['/etc/nginx/sites-available/default'],
}

# Define default index page
file { '/var/www/html/index.html':
  ensure  => file,
  content => "Hello World!\n",
  require => Package['nginx'],
}

# Reload Nginx after configuration changes
exec { 'nginx-reload':
  command     => '/usr/sbin/service nginx reload',
  refreshonly => true,
  require     => File['/etc/nginx/sites-enabled/000-default'],
}
