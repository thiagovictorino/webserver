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

echo "everything OK"
