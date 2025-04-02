#!/bin/bash
set -e

# Make sure the sites-enabled directory exists
mkdir -p /etc/apache2/sites-enabled

# Enable the sites by creating symbolic links from sites-available to sites-enabled
a2ensite testlocal.com.conf
a2ensite testdomainlocal.com.conf

# Enable required Apache modules
a2enmod rewrite
a2enmod headers
a2enmod vhost_alias

# Set ServerName directive globally to suppress the warning
echo "ServerName testlocal.com" >> /etc/apache2/apache2.conf

# Check Apache configuration
apache2ctl configtest

# Execute the CMD from the Dockerfile
exec "$@"