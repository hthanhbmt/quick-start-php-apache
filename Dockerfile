# Sử dụng PHP 8.1 với Apache
FROM php:8.1-apache

# Cài đặt các extensions cần thiết
RUN docker-php-ext-install pdo pdo_mysql mysqli

# Bật các mô-đun Apache
RUN a2enmod rewrite headers vhost_alias

# Copy source code vào container
COPY . /var/www/html

# Cấu hình quyền cho thư mục
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Tạo thư mục cho cấu hình host ảo
RUN mkdir -p /etc/apache2/sites-enabled

# Mở cổng 80 cho Apache
EXPOSE 80

# Thêm tập lệnh entrypoint tùy chỉnh
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
