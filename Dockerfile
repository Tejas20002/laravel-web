FROM php:7.4-fpm

# Arguments defined in docker-compose.yml
ARG user
ARG uid

#Copy composer.lock and composer.json into the working directory
COPY composer.lock composer.json /var/www/html/

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u 1000 -d /home/tjhirani tjhirani
RUN mkdir -p /home/tjhirani/.composer && \
    chown -R tjhirani:tjhirani /home/tjhirani

# Set working directory
WORKDIR /var/www

USER tjhirani
