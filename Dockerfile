FROM ubuntu:latest

#
# fix the sh to use tab and arrow keys
#
ENV SHELL=/bin/bash
RUN ["rm","/bin/sh"]
RUN ["ln", "-s", "/bin/bash", "/bin/sh"]


#
# config the httpd directory and prefixes
#
ENV HTTPD_PREFIX /etc/apache2
ENV PATH $HTTPD_PREFIX/bin:$PATH
ENV TZ America/Los_Angeles
ENV DEBIAN_FRONTEND noninteractive
ENV INETPUB /inetpub

#
# Apache ENVs
#
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOCK_DIR /inetpub/lock
ENV APACHE_LOG_DIR /inetpub/log
ENV APACHE_PID_FILE /inetpub/run/apache2.pid
ENV APACHE_SERVER_NAME salonmanager


#
# make directory
#
WORKDIR $HTTPD_PREFIX


RUN DEBIAN_FRONTEND="noninteractive" apt update \
	&& apt install -y \
	libaprutil1-ldap \
	apache2 \
	nano php libapache2-mod-php libapache2-mod-auth-mellon \
	openssl php-common php-curl php-json php-mbstring php-mysql php-xml php-zip \
	libapache2-mod-evasive \
    libapache2-mod-security2 \
    libapache2-mod-qos	\
	openjdk-8-jre-headless \
    wget \
    && apt clean \
	 && rm -rf /var/lib/apt/lists/*
	 

#
# installing apache gui
#
COPY assets/ApacheGUI-1.12.0.tar.gz /usr/local/apachegui/ApacheGUI-1.12.0.tar.gz
RUN cd /usr/local/apachegui \
	&& tar xvzf ApacheGUI-1.12.0.tar.gz \
	&& rm -f ApacheGUI-1.12.0.tar.gz

#
# copy assets, apache conf folder, and inetpub structure
#
COPY apache $HTTPD_PREFIX
COPY assets/install-apache-gui.sh /usr/bin/apachegui.sh
COPY assets/run.sh /run.sh
COPY inetpub $INETPUB

EXPOSE 80 443 9999

#
# we run start script
#
CMD chmod 0775 /run.sh && /run.sh



