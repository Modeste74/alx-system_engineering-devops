# creates a file in a directory and adds content in it
file {'/tmp/school':
ensure  => file,
content => 'I love Puppet',
mode    => '0744',
owner   => 'www-data',
group   => 'www-data',
}

