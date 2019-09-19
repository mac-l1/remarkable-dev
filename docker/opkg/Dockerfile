FROM nginx:latest

RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get install -y \
  git \
  make \
  python

# install opkg tools
RUN git clone git://git.yoctoproject.org/opkg-utils /root/opkg-utils
WORKDIR /root/opkg-utils
RUN make
RUN make install

WORKDIR /usr/share/nginx/html/snapshots

# enable website
RUN rm /etc/nginx/conf.d/default.conf
COPY files/snapshots /etc/nginx/conf.d/snapshots.conf

COPY files/entrypoint.sh /root/entrypoint.sh

ENTRYPOINT [ "/root/entrypoint.sh" ]
