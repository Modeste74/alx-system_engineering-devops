# creates a manifest that kills a process
exec {'killmenow':
command => 'pkill killmenow',
path    => ['/bin/', '/usr/bin/'],
}
