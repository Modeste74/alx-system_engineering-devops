# Installs Nginx and custom HTTP response headers
exec { 'command':
  command  => 'apt-get -y update;
  apt-get -y install nginx;
  sudo sed -i "54iadd_header X-Served-By $HOSTNAME;" /etc/nginx/sites-available/default;
  service nginx restart',
  provider => shell,
}
class { 'nginx':
  ensure => 'installed',
}
