FROM lukemauldin/docker-php-laravel

RUN	apt-get -o 'Acquire::CompressionTypes::Order::="gz"' update && \
	apt-get install -y --no-install-recommends \
	curl \
	git \
	nano && \
	curl -o /root/node.tar.gz http://nodejs.org/dist/v0.10.33/node-v0.10.33-linux-x64.tar.gz && \
	cd /usr/local && \
	tar --strip-components 1 -xzf /root/node.tar.gz && \
	rm /root/node.tar.gz && \
	npm install -g grunt-cli bower && \
	curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/bin && \
	/usr/bin/composer self-update && \
	echo "source ~/.aliases" >> /root/.bashrc

RUN mkdir -p /var/composer

VOLUME ["/var/composer"]

ENV COMPOSER_HOME /var/composer
COPY config/aliases /root/.aliases

CMD ["/bin/bash"]
