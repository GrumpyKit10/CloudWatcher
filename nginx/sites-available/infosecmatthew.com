server {
    server_name infosecmatthew.com www.infosecmatthew.com;

    root /var/www/infosecmatthew.com;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }

    location /.well-known/acme-challenge/ {
        root /var/www/infosecmatthew.com;  # or your web root directory
        allow all;
    }

    listen 443 ssl; # managed by Certbot
    ssl_certificate path/to/fullchain.pem; # managed by Certbot
    ssl_certificate_key path/to/privkey.pem; # managed by Certbot
    include path/to/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam path/to/ssl-dhparams.pem; # managed by Certbot


}
server {
    if ($host = www.infosecmatthew.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    if ($host = infosecmatthew.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80;
    server_name infosecmatthew.com www.infosecmatthew.com;
    return 404; # managed by Certbot
}
