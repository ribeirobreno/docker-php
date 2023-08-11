FROM ribeirobreno/php:v1.3.0-8.1-alpine-3.18

RUN set -xe \
	&& apk add --no-cache --update --virtual .phpize-deps $PHPIZE_DEPS \
	&& docker-php-ext-install bcmath \
	&& rm -rf /usr/share/php8 \
	&& rm -rf /tmp/* \
	&& apk del .phpize-deps

RUN composer self-update