FROM ribeirobreno/php:v1.3.0-7.4-alpine-3.10

RUN set -xe \
	&& apk add --no-cache --update --virtual .phpize-deps $PHPIZE_DEPS \
	&& sleep 1 \
	&& docker-php-ext-install bcmath \
	&& rm -rf /usr/share/php7 \
	&& rm -rf /tmp/* \
	&& apk del .phpize-deps

RUN composer self-update
