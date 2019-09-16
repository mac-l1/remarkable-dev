FROM ubuntu:latest

WORKDIR /home/root

RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get install -y \
  curl \
  qtcreator

RUN curl https://remarkable.engineering/deploy/sdk/poky-glibc-x86_64-meta-toolchain-qt5-cortexa9hf-neon-toolchain-2.1.3.sh \
  -o install-toolchain.sh
RUN chmod +x install-toolchain.sh
RUN ./install-toolchain.sh -y \
  -d /opt/poky/2.1.3/

RUN rm -rf .config
COPY config .config

RUN echo "source /opt/poky/2.1.3/environment-setup-cortexa9hf-neon-poky-linux-gnueabi" \
  >> ~/.bashrc

CMD [ "qtcreator" ]
