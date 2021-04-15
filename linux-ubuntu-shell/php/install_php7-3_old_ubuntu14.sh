
# instructions and commands

# https://www.configserverfirewall.com/ubuntu-linux/install-php-7-on-ubuntu-14/
sudo apt-get install -y openssl libxml2-dev libcurl4-openssl-dev

mkdir -p /usr/src/php7.3/
cd /usr/src/php7.3/
sudo wget https://www.php.net/distributions/php-7.3.27.tar.gz
tar -zxvf php-7.3.27.tar.gz 
cd /usr/src/php7.3/php-7.3.27


./configure --prefix=/usr/local/php7.3 --enable-opcache --enable-intl --enable-mbstring --enable-zip \
        --enable-bcmath --enable-pcntl --enable-ftp --enable-exif --enable-calendar --enable-sysvmsg --enable-sysvsem \
        --enable-sysvshm --enable-wddx --enable-filter --enable-gd-native-ttf --enable-gd-jis-conv \
        --with-curl --with-mcrypt --with-iconv --with-gd --with-jpeg-dir=/usr --with-png-dir=/usr --with-zlib-dir=/usr \
        --with-freetype-dir=/usr --with-openssl --with-pdo-mysql=/usr --with-gettext=/usr --with-zlib=/usr --with-bz2=/usr \
        --with-mysqli=/usr/bin/mysql_config

# install the php        
sudo make && sudo make install

# make it a binary available form the 'php' command on the server
sudo ln -s /usr/local/php7.3/bin/php /usr/local/bin/php7.3


# Test the new php bin
/usr/src/php7.3/php-7.3.27/sapi/cli/php -v
/usr/src/php7.3/php-7.3.27/sapi/cli/php --ini
/usr/src/php7.3/php-7.3.27/sapi/cli/php -i | grep -i openssl
/usr/src/php7.3/php-7.3.27/sapi/cli/php -r "phpinfo();" | grep ssl

# in case needed 'install composer 1'
# composer 1
mkdir -p /usr/local/src/composer1
cd /usr/local/src/composer1/
/usr/src/php7.3/php-7.3.27/sapi/cli/php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
/usr/src/php7.3/php-7.3.27/sapi/cli/php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
/usr/src/php7.3/php-7.3.27/sapi/cli/php composer-setup.php
/usr/src/php7.3/php-7.3.27/sapi/cli/php -r "unlink('composer-setup.php');"
sudo ln -s /usr/local/src/composer1/composer.phar /usr/local/bin/composer1
composer1 self-update 1.10.10

# If composer is already installed from the above steps
composer self-update


# in case more than one version of the composer is needed (for i.g 'composer2')
# composer 2
mkdir -p /usr/local/src/composer
cd /usr/local/src/composer/
/usr/src/php7.3/php-7.3.27/sapi/cli/php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
/usr/src/php7.3/php-7.3.27/sapi/cli/php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
/usr/src/php7.3/php-7.3.27/sapi/cli/php composer-setup.php
/usr/src/php7.3/php-7.3.27/sapi/cli/php -r "unlink('composer-setup.php');"
sudo ln -s /usr/local/src/composer/composer.phar /usr/local/bin/composer
composer --version



