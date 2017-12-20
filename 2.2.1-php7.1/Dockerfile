FROM thiagobarradas/lamp:php-7.1
MAINTAINER Thiago Barradas <th.barradas@gmail.com>

# VARIABLES
ENV MAGENTO_VERSION=2.2.1
ENV ADMIN_FIRSTNAME="Admin" 
ENV ADMIN_LASTNAME="Test" 
ENV ADMIN_EMAIL="admin-magento2@mailinator.com" 
ENV ADMIN_USER="admin" 
ENV ADMIN_PASSWORD="Mudar123"

# GET MAGENTO FILES
WORKDIR /var/www/html
RUN rm -f * && mkdir tmp
WORKDIR /var/www/html/tmp
RUN ls -l
RUN wget -O magento2-$MAGENTO_VERSION.zip https://codeload.github.com/magento/magento2/zip/$MAGENTO_VERSION
RUN wget -O magento2-sample-data-$MAGENTO_VERSION.zip https://codeload.github.com/magento/magento2-sample-data/zip/$MAGENTO_VERSION
RUN chmod -R 755 /app

# UNZIP MAGENTO2
RUN unzip magento2-$MAGENTO_VERSION.zip
RUN cp -a magento2-$MAGENTO_VERSION/. /var/www/html

# UNZIP MAGENTO2-SAMPLE-DATA
WORKDIR /var/www/html
RUN unzip magento2-sample-data-$MAGENTO_VERSION.zip
RUN php -f magento2-sample-data-$MAGENTO_VERSION/dev/tools/build-sample-data.php -- --ce-source="/var/www/html"

# COMPOSER INSTALL AND CLEAR TMP FILES
RUN composer install
RUN rm -rf tmp/magento2-$MAGENTO_VERSION

# COPY SCRIPT TO SETUP MAGENTO
ENV IS_INITIALIZED=0
COPY scripts/supervisord-zmagento.conf /etc/supervisor/conf.d/supervisord-zmagento.conf
COPY scripts/setup-magento.sh /setup-magento.sh

# CLEAN
RUN apt purge && apt-get autoremove -y && apt-get clean

# EXPOSE AND RUN
EXPOSE 80 3306
CMD ["/run.sh"]