FROM ubuntu:16.04

# Install packages

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8
RUN apt-get -y update
RUN apt-get install -y software-properties-common
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C
RUN apt-get update
RUN apt-get -y install libpcre3 curl zip unzip php5.6 telnet netcat mysql-client \
    golang-go pdftk libfontconfig1 libxrender1
RUN update-alternatives --set php /usr/bin/php5.6 \
    && update-alternatives --set phar /usr/bin/phar5.6 \
    && update-alternatives --set phar.phar /usr/bin/phar.phar5.6
    # \
    # && update-alternatives --set phpize /usr/bin/phpize5.6 \
    # && update-alternatives --set php-config /usr/bin/php-config5.6
ENV GOPATH /root/gocode
RUN apt-get -y install supervisor git apache2 php5.6-gmp php5.6-xml php5.6-mbstring php5.6-apcu \
    libapache2-mod-php5.6 dos2unix php5.6-gd php5.6-zip php5.6-pdo php5.6-curl \
    php5.6-mysql php5.6-curl pwgen php5.6-json php5.6-redis nano php5.6-xml \
    php5.6-sqlite3 php5.6-memcached php5.6-memcache php5.6-mongodb php5.6-soap \
    php5.6-pgsql php5.6-bcmath php5.6-mcrypt
RUN apt-get -y install gcc make autoconf libc-dev pkg-config php5.6-dev
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf \
    && a2enmod rewrite && a2enmod ssl

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN curl -s "https://packagecloud.io/install/repositories/phalcon/stable/script.deb.sh" | bash
RUN apt-get install -y nodejs php5.6-phalcon
RUN curl -sS https://getcomposer.org/installer | php
# RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
# RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
# RUN apt-get update && apt-get -y install yarn
RUN mv composer.phar /usr/local/bin/composer
# RUN npm install -g @vue/cli

# TimeZone:
ENV TZ America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN echo "date.timezone = 'America/New_York'" >> /etc/php/5.6/apache2/php.ini \
    && echo "date.timezone = 'America/New_York'" >> /etc/php/5.6/cli/php.ini

# Mailhog:
RUN go get github.com/mailhog/mhsendmail
RUN cp /root/gocode/bin/mhsendmail /usr/local/bin/mhsendmail \
    && echo "sendmail_path = /usr/local/bin/mhsendmail --smtp-addr mailhog:1025" >> /etc/php/5.6/apache2/php.ini \
    && echo "sendmail_path = /usr/local/bin/mhsendmail --smtp-addr mailhog:1025" >> /etc/php/5.6/cli/php.ini

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

RUN apt-get install lftp

ADD run.sh /run.sh
CMD ["/run.sh"]
