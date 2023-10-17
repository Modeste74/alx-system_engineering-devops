# manifests/holberton_ulimit.pp
file { '/etc/security/limits.conf':
  ensure  => file,
  content => "holberton soft nofile 65536\nholberton hard nofile 65536\n",
}

file { '/etc/pam.d/common-session':
  ensure  => file,
  content => "session required pam_limits.so\n",
}
