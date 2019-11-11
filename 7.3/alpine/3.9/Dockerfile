# Alpine 3.10 has a bug with --virtual, so we use another version
FROM php:7.3-fpm-alpine3.9

ENV MEMCACHED_DEPS zlib-dev libmemcached-dev cyrus-sasl-dev
ENV GD_DEPS zlib-dev freetype-dev libjpeg-turbo-dev libpng-dev libwebp-dev
ENV INTL_DEPS icu-dev

# Issue with the pcre and php version combination provided by the base image.
RUN echo 'pcre.jit=0' >> /usr/local/etc/php/conf.d/zz-disable-pcre-jit.ini
RUN apk add --no-cache --update icu libjpeg libpng libwebp libmemcached-libs zlib
RUN set -xe \
	&& apk add --no-cache --update --virtual .phpize-deps $PHPIZE_DEPS \
	&& apk add --no-cache --update --virtual .memcached-deps $MEMCACHED_DEPS \
	&& apk add --no-cache --update --virtual .gd-deps $GD_DEPS \
	&& apk add --no-cache --update --virtual .intl-deps $INTL_DEPS \
	&& pecl install memcached \
	&& docker-php-ext-enable memcached \
	&& docker-php-ext-install intl \
	&& docker-php-ext-install pcntl \
	&& docker-php-ext-install mysqli pdo pdo_mysql \
	&& docker-php-ext-configure gd \
		--enable-freetype \
		--with-jpeg-dir=/usr/include/ \
		--with-zlib-dir \
		--with-png-dir=/usr/include/ \
		--with-webp-dir=/usr/include/ \
	&& docker-php-ext-install -j$(nproc) gd \
	&& rm -rf /usr/share/php7 \
	&& rm -rf /tmp/* \
	&& apk del .memcached-deps .phpize-deps .gd-deps .intl-deps

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
	# https://composer.github.io/installer.sig
	#&& php -r "if (hash_file('sha384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
	&& php composer-setup.php --install-dir=/bin --filename=composer \
	&& php -r "unlink('composer-setup.php');"
