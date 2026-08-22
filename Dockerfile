FROM php:8.1.33-apache

RUN apt-get update \
    && apt-get install -y --no-install-recommends libcurl4-openssl-dev libonig-dev \
    && docker-php-ext-install curl mbstring mysqli \
    && a2enmod rewrite \
    && rm -rf /var/lib/apt/lists/*
