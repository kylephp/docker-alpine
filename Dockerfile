FROM nimmis/alpine-apache-php5
MAINTAINER Kyle Hoang - https://github.com/kylephp

### install shadow package for usermod ###
RUN apk add --update  shadow@community php5-zlib php5-dom php5-xml php5-mysqli --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted && \
    rm -rf /var/cache/apk/*

#RUN sed -ire 's/display_errors = Off/display_errors = On/g' /etc/php5/php.ini
RUN sed -ire 's/upload_max_filesize = 2M/upload_max_filesize = 100M/g' /etc/php5/php.ini
RUN echo 'post_max_size = 100M' > /etc/php5/conf.d/custom.ini
RUN sed -ire 's/#LoadModule rewrite_module/LoadModule rewrite_module/g' /etc/apache2/httpd.conf
RUN sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/httpd.conf

### fix permission when mounting volumes
RUN usermod -u 1000 apache
RUN groupmod -g 1000 apache