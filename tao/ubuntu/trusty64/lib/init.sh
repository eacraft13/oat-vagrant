# Updating & upgrading

sudo apt-get -qq update
sudo apt-get -y -qq upgrade


# Make swap memory

sudo dd if=/dev/zero of=/var/swap.1 bs=1M count=1024
sudo mkswap /var/swap.1
sudo swapon /var/swap.1


# Apache

sudo apt-get -y -qq install apache2

sudo mkdir /var/www/taoplatform
sudo gpasswd -a "$USER" www-data

sudo ln -s /vagrant/lib/taoplatform.conf /etc/apache2/sites-available/
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
sudo apt-get -y -qq install php5.6 php5.6-gd php5.6-mysql php5.6-tidy php5.6-curl php5.6-mbstring php5.6-zip php5.6-xml php-xml-parser
sudo apt-get -y -qq install php5.6-mcrypt

sudo a2dismod php7.0 ; sudo a2enmod php5.6 ; sudo service apache2 restart # Set php5.6 for Apache
sudo update-alternatives --set php /usr/bin/php5.6 # Set php5.6 for CLI


# Git

sudo apt-get -y -qq install git

git config --global color.ui true
git config --global user.name "eric"
git config --global user.email "eric@taotesting.com"
git config --global core.fileMode false


# Curl

sudo apt-get -y -qq install curl


# Composer

curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
sudo chown -R $USER $HOME/.composer
sudo chgrp -R $USER $HOME/.composer
echo "" >> $HOME/.bashrc
echo "export PATH=\$PATH:\$HOME/.composer/vendor/bin # Add composer to path" >> $HOME/.bashrc
source $HOME/.bashrc


# Ruby

curl -#LO https://rvm.io/mpapis.asc
gpg --import mpapis.asc
curl -sSL https://get.rvm.io | bash -s stable --ruby
source $HOME/.rvm/scripts/rvm
rvm requirements


# Node

sudo apt-get -y -qq install build-essential libssl-dev
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
nvm install node


# Standards & Linters

composer global require "squizlabs/php_codesniffer=*"
npm install --global eslint


# Vim

ln -s /vagrant/lib/vimrc $HOME/.vimrc
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
vim +PluginInstall +qall


# bashrc & aliases

ln -s /vagrant/lib/bash_aliases $HOME/.bash_aliases


# Misc.

composer global require "phpunit/phpunit:4.8.*"
rvm @global do gem install sass
npm install --global grunt-cli bower


# Cleanup

sudo apt-get clean
sudo dd if=/dev/zero of=/EMPTY bs=1M
sudo rm -f /EMPTY

rm .mkshrc .zlogin .zshrc .viminfo .sudo_as_admin_successful mpapis.asc

cat /dev/null > $HOME/.bash_history && history -c

