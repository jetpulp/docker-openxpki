FROM debian:jessie

RUN echo "deb http://packages.openxpki.org/debian/ jessie release" > /etc/apt/sources.list.d/openxpki.list \
    && apt-get update

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install -y mysql-server libdbd-mysql-perl
RUN echo "deb http://httpredir.debian.org/debian jessie non-free" >> /etc/apt/sources.list \
    && apt-get update
RUN apt-get install -y libapache2-mod-fcgid
RUN apt-get install -y --force-yes libopenxpki-perl openxpki-i18n

RUN apt-get update -qq && apt-get install -y locales -qq && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen ; locale-gen

RUN a2enmod fcgid

ADD config/database.yaml /etc/openxpki/config.d/system/database.yaml
ADD config/openxpki-apache.conf /etc/apache2/conf-enabled/openxpki.conf
ADD scripts/sampleconfig.sh /usr/share/doc/libopenxpki-perl/examples/sampleconfig.sh

ADD scripts/launch.sh /usr/local/bin/launch.sh
CMD [ "/bin/bash", "/usr/local/bin/launch.sh" ]
