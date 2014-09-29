au! BufRead,BufNewFile www.conf,php.d/*.ini,php.ini,php-fpm.conf        setfiletype dosini
au BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/conf/* if &ft == '' | setfiletype nginx | endif