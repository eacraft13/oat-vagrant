# Updating & upgrading

sudo apt-get -qq update
sudo apt-get -y -qq upgrade


# Bash

sudo cp /vagrant/lib/bashrc $HOME/.bashrc
sudo cp /vagrant/lib/bash_aliases $HOME/.bash_aliases
source $HOME/.bashrc


# Curl

sudo apt-get -y -qq install curl


# Apache

sudo apt-get -y -qq install apache2

sudo mkdir /var/www/taoplatform
sudo gpasswd -a "$USER" www-data

sudo a2enmod ssl
sudo service apache2 restart

sudo mkdir /etc/apachd2/ssl
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/apache.key -out /etc/apache2/ssl/apache.crt
# Common Name => 'taoplatform'

sudo cp /vagrant/lib/taoplatform.conf /etc/apache2/sites-available/taoplatform.conf
sudo a2ensite taoplatform
sudo service apache2 reload
sudo a2enmod rewrite
sudo service apache2 restart


# MySQL

export MYSQL_PASS=root
export DEBIAN_FRONTEND=noninteractive
sudo debconf-set-selections <<EOT
mysql-server mysql-server/root_password password $MYSQL_PASS
EOT
sudo debconf-set-selections <<EOT
mysql-server mysql-server/root_password_again password $MYSQL_PASS
EOT
sudo apt-get -y -qq install mysql-server


# PHP

sudo apt-get -y -qq install python-software-properties
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get -qq update
sudo apt-get -y -qq install php5.6 php5.6-gd php5.6-mysql php5.6-tidy php5.6-curl php5.6-mbstring php5.6-zip php5.6-xml php5.6-mcrypt php-xml-parser

sudo a2dismod php7.0 ; sudo a2enmod php5.6 ; sudo service apache2 restart # Set php5.6 for Apache
sudo update-alternatives --set php /usr/bin/php5.6 # Set php5.6 for CLI


# Node

sudo apt-get -y -qq install build-essential libssl-dev
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
nvm install node
