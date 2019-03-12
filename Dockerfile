FROM ubuntu:16.04

RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y \
    apache2 \
    php7.0 \
    php7.0-cli \
    libapache2-mod-php7.0 \
    php-apcu \
    php-xdebug \
    php7.0-gd \
    php7.0-json \
    php7.0-ldap \
    php7.0-mbstring \
    php7.0-mysql \
    php7.0-pgsql \
    php7.0-sqlite3 \
    php7.0-xml \
    php7.0-xsl \
    php7.0-zip \
    php7.0-soap \
    php7.0-opcache \
    php7.0-curl\
    composer

ADD 000-default.conf /etc/apache2/sites-available/000-default.conf

WORKDIR /var/www/html

ADD ./ .

#Comando para alterar o Dono de algum diretorio
#RUN chown -R www-data:www-data diretorio1/ diretorio2/ diretorio3/
RUN chown -R www-data:www-data /var/www/html

#Comando para dar permissao a algum diretorio
#RUN chmod -R 777 diretorio1/ diretorio2/ diretorio3/
RUN chmod -R 777 /var/www/html

RUN a2enmod rewrite

#EXPOSE 80

RUN cp -av index.php ./app
CMD ["apachectl", "-D", "FOREGROUND"]
