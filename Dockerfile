FROM php:8.0-apache

# Install required dependencies.
ENV ACCEPT_EULA=Y
RUN apt-get update && apt-get install -y gnupg2 

# Add Microsoft repository for SQL Server packages
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - 
RUN curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list > /etc/apt/sources.list.d/mssql-release.list 

# Install extensions
RUN apt-get update 
RUN ACCEPT_EULA=Y apt-get -y --no-install-recommends install msodbcsql17 unixodbc-dev libmcrypt-dev
RUN pecl install sqlsrv
RUN pecl install pdo_sqlsrv
RUN pecl install mcrypt
RUN docker-php-ext-enable sqlsrv pdo_sqlsrv mcrypt openssl
RUN a2enmod rewrite

WORKDIR /var/www/html

EXPOSE 80
