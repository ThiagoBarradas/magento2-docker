sleep 30

mysqladmin create magento2
php -f /app/bin/magento setup:install --base-url=http://localhost --backend-frontname=admin --db-host=localhost --db-name=magento2 --db-user=root --admin-firstname=$ADMIN_FIRSTNAME --admin-lastname=$ADMIN_LASTNAME --admin-email=$ADMIN_EMAIL --admin-user=$ADMIN_USER --admin-password=$ADMIN_PASSWORD --language=pt_BR --currency=BRL --timezone=America/Sao_Paulo --use-rewrites=1
php /app/bin/magento setup:upgrade
php /app/bin/magento setup:di:compile
php /app/bin/magento indexer:reindex
php /app/bin/magento cache:flush
chmod -R 755 /var/www/html  && chmod -R 777 /var/www/html/var /var/www/html/pub && chmod u+x /app/bin/magento
rm -f /etc/supervisor/conf.d/supervisord-zmagento.conf