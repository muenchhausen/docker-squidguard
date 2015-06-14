FROM sameersbn/squid:latest
MAINTAINER derk@muenchhausen.de

RUN apt-get update \
 && apt-get install -y squidguard

RUN wget http://www.shallalist.de/Downloads/shallalist.tar.gz \
 && tar -xzf shallalist.tar.gz -C /var/lib/squidguard/db \
 && rm shallalist.tar.gz \
 && chown proxy:proxy /var/lib/squidguard/db -R \
 && echo "redirect_program /usr/bin/squidGuard -c /etc/squidguard/squidGuard.conf" >> /etc/squid3/squid.conf

ADD squidGuard.conf /etc/squidguard/squidGuard.conf

RUN sudo -u proxy squidGuard -C all 

EXPOSE 3128
VOLUME ["/var/spool/squid3"]

CMD ["/start"]
