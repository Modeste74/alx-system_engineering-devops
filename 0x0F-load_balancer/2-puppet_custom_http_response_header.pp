package { 'nginx':
  ensure => installed,
}

file { '/etc/nginx/sites-available/default':
  ensure  => present,
  content => template('nginx/custom_header.erb'),
  require => Package['nginx'],
}

service { 'nginx':
  ensure  => running,
  enable  => true,
  require => File['/etc/nginx/sites-available/default'],
}

# Create a custom header template
file { '/etc/nginx/custom_header.erb':
  ensure  => present,
  content => "add_header X-Served-By ${hostname};",
}
