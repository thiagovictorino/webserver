#!/bin/bash

export LANGUAGE=en_US.UTF-8

export LANG=en_US.UTF-8

export LC_ALL=en_US.UTF-8

locale-gen en_US.UTF-8

dpkg-reconfigure locales

echo "Installing some packages..."

sudo aptitude install apache2 php5 php5-intl mongodb vim php5-curl -y

echo "Installing java7...\n"

sudo echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee /etc/apt/sources.list.d/webupd8team-java.list

sudo echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886

sudo apt-get update

sudo apt-get install oracle-java7-installer -y

echo "Configuring the virtual host..."

wget http://images.pontual.taxi.br:8081/web.dev.conf

sudo cp web.dev.conf /etc/apache2/sites-available/

sudo ln -s /etc/apache2/sites-available/web.dev.conf /etc/apache2/sites-enabled/web.dev.conf

sudo a2enmod rewrite
sudo service apache2 restart

echo "The virtual host created is web.dev.conf"

sudo aptitude install postgresql-9.1 -y

sudo su -c "psql -c \"CREATE USER powertaxi WITH PASSWORD '010powertaxi123'\"" -s /bin/bash postgres

sudo find /etc/postgresql/9.1/main/ -type f -print0 | sudo xargs -0 sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g"

sudo su -c "echo 'host    all             all             192.168.1.0/24          trust' >> /etc/postgresql/9.1/main/pg_hba.conf" -s /bin/bash postgres
sudo su -c "echo 'host    all             all             10.0.2.0/8              trust' >> /etc/postgresql/9.1/main/pg_hba.conf" -s /bin/bash postgres

sudo service postgresql restart

echo "everything OK"
