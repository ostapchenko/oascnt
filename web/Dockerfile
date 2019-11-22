FROM ubuntu:18.04

# Install packages

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8
RUN apt-get -y update
RUN apt-get install -y software-properties-common
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
# RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C
RUN apt-get -y update
RUN apt-get -y install libpcre3 curl zip unzip php7.3 telnet netcat mysql-client \
    golang-go libfontconfig1 libxrender1
ENV GOPATH /root/gocode
RUN apt-get -y install git apache2 php7.3-gmp php7.3-xml php7.3-mbstring php7.3-apcu \
    php7.3-mbstring libapache2-mod-php7.3 dos2unix php7.3-gd php7.3-zip php7.3-pdo php7.3-curl \
    php7.3-mysql php7.3-curl pwgen php7.3-json php7.3-redis nano vim php7.3-xml php7.3-mbstring \
    php7.3-sqlite3 php7.3-memcached php7.3-memcache php7.3-mongodb php7.3-soap php7.3-bcmath
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf \
    && a2enmod rewrite && a2enmod ssl

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN curl -s "https://packagecloud.io/install/repositories/phalcon/stable/script.deb.sh" | bash
RUN apt-get install -y nodejs php7.3-phalcon
RUN curl -sS https://getcomposer.org/installer | php
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get -y install yarn
RUN mv composer.phar /usr/local/bin/composer
RUN npm install -g @vue/cli

# TimeZone:
ENV TZ America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN echo "date.timezone = 'America/New_York'" >> /etc/php/7.3/apache2/php.ini \
    && echo "date.timezone = 'America/New_York'" >> /etc/php/7.3/cli/php.ini

# Mailhog:
RUN go get github.com/mailhog/mhsendmail
RUN cp /root/gocode/bin/mhsendmail /usr/local/bin/mhsendmail \
    && echo "sendmail_path = /usr/local/bin/mhsendmail --smtp-addr mailhog:1025" >> /etc/php/7.3/apache2/php.ini \
    && echo "sendmail_path = /usr/local/bin/mhsendmail --smtp-addr mailhog:1025" >> /etc/php/7.3/cli/php.ini

# Environment variables to configure php
ENV PHP_UPLOAD_MAX_FILESIZE 50M
ENV PHP_POST_MAX_SIZE 50M

COPY ssls /ssls
COPY apache/sites-enabled/* /etc/apache2/sites-enabled/
RUN mkdir /var/wwwdefault \
    && echo "<?php phpinfo();" >> /var/wwwdefault/index.php \
    && chown -R www-data. /var/wwwdefault

# Bash:
COPY .bash_aliases /root/.bash_aliases

CMD bash -c "source /etc/apache2/envvars && apache2 -DFOREGROUND"

# CMD ["/run.sh"]
