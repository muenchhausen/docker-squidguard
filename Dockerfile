FROM sameersbn/squid:latest
MAINTAINER derk@muenchhausen.de

RUN apt-get update \
 && apt-get install -y squidguard \ 
 && apt-get install -y apache2

RUN sudo echo 'AddType application/x-ns-proxy-autoconfig .dat' >> /etc/apache2/httpd.conf
ADD wpat.dat /var/www/html/wpat.dat
ADD block.html /var/www/html/block.html

RUN wget http://www.shallalist.de/Downloads/shallalist.tar.gz \
 && tar -xzf shallalist.tar.gz -C /var/lib/squidguard/db \
 && rm shallalist.tar.gz \
 && chown proxy:proxy /var/lib/squidguard/db -R \
 && echo "redirect_program /usr/bin/squidGuard -c /etc/squidguard/squidGuard.conf" >> /etc/squid3/squid.conf

ADD squidGuard.conf /etc/squidguard/squidGuard.conf


ADD startSquidGuard /startSquidGuard
RUN sudo chmod a+x /startSquidGuard

RUN sudo -u proxy squidGuard -C all 

EXPOSE 3128 80
VOLUME ["/var/spool/squid3"]

CMD ["/startSquidGuard"]
