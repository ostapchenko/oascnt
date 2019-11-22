#!/bin/bash

# add vithosts to hosts:
for vhFile in /etc/apache2/sites-enabled/*.conf
do
    vhName=${vhFile##*/}
    vhost=${vhName%.*}
    echo "127.0.0.1 ${vhost}" >> /etc/hosts
done

bash -c "source /etc/apache2/envvars && apache2 -DFOREGROUND"
