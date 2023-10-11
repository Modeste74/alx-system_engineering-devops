# Fixes internal error that was not allowing us to access contents of the server
exec { 'fix-wordpress':
  command => '/bin/sed -i "s/phpp/php/g" /var/www/html/wp-settings.php',
}
