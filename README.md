# apache-gui-qos-docker

To add new host
```
<VirtualHost *:80>
    ServerName www.example2.com
    DocumentRoot /var/www/example2.com/public_html
    ServerAlias example2.com
    ErrorLog /var/www/example2.com/error.log
    CustomLog /var/www/example2.com/requests.log combined
</VirtualHost>
```

and https

```
<VirtualHost *:443>
    ServerName www.example2.com
    DocumentRoot /var/www/example2.com/public_html
    ServerAlias example2.com
    ErrorLog /var/www/example2.com/error.log
    CustomLog /var/www/example2.com/requests.log combined
    SSLEngine on
    SSLCertificateFile /etc/apache2/ssl/example2/apache.crt
    SSLCertificateKeyFile /etc/apache2/ssl/example2/apache.key
</VirtualHost>
```

and make http redirect to https

```
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    ServerName example.com
    ServerAlias www.example.com
    DocumentRoot /var/www/example.com/public
    <Directory /var/www/example.com>
    Options +FollowSymlinks
    AllowOverride All
    Require all granted
    </Directory>
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
RewriteEngine on
RewriteCond %{SERVER_NAME} =www.example.com [OR]
RewriteCond %{SERVER_NAME} =example.com
RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI} [END,NE,R=permanent]
</VirtualHost>
```