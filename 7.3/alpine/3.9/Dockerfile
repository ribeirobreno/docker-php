FROM ribeirobreno/php:v1.3.0-7.3-alpine-3.9

RUN set -xe \
	&& apk add --no-cache --update --virtual .phpize-deps $PHPIZE_DEPS \
	&& docker-php-ext-install bcmath \
	&& rm -rf /usr/share/php7 \
	&& rm -rf /tmp/* \
	&& apk del .phpize-deps

RUN composer self-update
