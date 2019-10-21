FROM leodido/sphinxsearch:2.2.10

RUN yum install sed \
  && yum install -y epel-release \
  && sed -i "s/mirrorlist=https/mirrorlist=http/" /etc/yum.repos.d/epel.repo \
  && yum clean all && yum install -y compat-readline5 \
  && yum clean all && yum install -y socat \
  && mkdir -p /usr/local/etc/sphinx \
  && mkdir -p /usr/local/etc/sphinx/conf.d \
  && mkdir -p /usr/local/etc/sphinx/data

COPY ./root/* /root/

COPY ./usr/local/etc/sphinx.conf /usr/local/etc/sphinx.conf
COPY ./usr/local/etc/sphinx/searchd.conf /usr/local/etc/sphinx/searchd.conf
COPY ./usr/local/etc/sphinx/data/stops.txt /usr/local/etc/sphinx/data/stops.txt
COPY ./usr/local/etc/sphinx/conf.d/vanilla.conf /usr/local/etc/sphinx/conf.d/sphinx.conf

RUN chmod +x /root/startup.sh \
 && chmod +x /root/listen.9399.sh

CMD /root/startup.sh

EXPOSE 9312
EXPOSE 9306
EXPOSE 9399
