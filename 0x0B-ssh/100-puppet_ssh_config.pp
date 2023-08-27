# makes changes to config file
file {'/etc/ssh/ssh_config':
ensure  => 'file',
content => '
Host *
IdentityFile ~/.ssh/school
PasswordAuthentication no',
}
