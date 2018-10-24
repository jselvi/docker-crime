FROM yamamuteki/debian-etch-i386
MAINTAINER Jose Selvi <jselvi@pentester.es>

WORKDIR /opt
USER root

# Update operating system
RUN apt-get update && apt-get -y install apache2 openssl ssl-cert ntpdate

# Sync time (not working for automated build on docker hub)
#RUN ntpdate

# Create SSL self-signed certificate
RUN openssl req $@ -new -x509 -days 365000 -nodes -out /etc/apache2/apache.pem -keyout /etc/apache2/apache.pem
RUN chmod 600 /etc/apache2/apache.pem

# Upload Apache configuration
COPY apache2/ports.conf /etc/apache2/ports.conf
RUN a2enmod ssl
RUN touch /etc/apache2/httpd.conf
COPY apache2/httpd.conf /etc/apache2/sites-available/default
RUN sync

# Upload Demo Website
COPY web/index.html /var/www/index.html

# Upload init.sh script
COPY init.sh /usr/local/bin/init.sh
RUN sync
RUN chmod a+xr /usr/local/bin/init.sh

# Starging script
CMD /usr/local/bin/init.sh
