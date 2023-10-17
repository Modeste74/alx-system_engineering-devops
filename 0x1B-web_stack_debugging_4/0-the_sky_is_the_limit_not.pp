# Set ulimit for nginx worker processes
file { '/etc/default/nginx':
  ensure  => file,
  content => 'ULIMIT="-n 4096"',  # Adjust this value as needed
  notify  => Service['nginx'],
}

service { 'nginx':
  ensure => running,
}
