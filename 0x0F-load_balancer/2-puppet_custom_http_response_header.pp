# configure nginx by creating a custom HTTP header response
class { 'nginx':
  ensure => 'installed',
}
file { '/etc/nginx/sites-available/default':
  ensure  => 'present',
  content => '
    server {
      listen 80;
      server_name_;

      location /{
        add_header X-Served-By $hostname;
      }
    }
  '
  notify  => Service['nginx'],
}
exec { 'command':
  command  => 'service nginx restart',
  provider => shell,
}
