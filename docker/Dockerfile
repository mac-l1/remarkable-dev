FROM dockcross/base:latest

# Add the cross compiler sources
RUN echo "deb http://emdebian.org/tools/debian/ jessie main" >> /etc/apt/sources.list && \
  dpkg --add-architecture armhf && \
  curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add -

RUN apt-get update && apt-get dist-upgrade -y
RUN apt-get install -y \
  autoconf \
  autogen \
  automake \
  autopoint \
  autotools-dev \
  crossbuild-essential-armhf \
  gettext \
  gfortran-arm-linux-gnueabihf \
  libbz2-dev:armhf \
  libexpat1-dev:armhf \
  libnl-3-dev:armhf \
  libnl-genl-3-dev:armhf \
  libnl-utils:armhf \
  libpci-dev:armhf \
  libssl-dev:armhf \
  libtool \
  ncurses-dev:armhf \
  pkg-config:armhf \
  qemu-user \
  qemu-user-static

ENV CROSS_TRIPLE arm-linux-gnueabihf
ENV CROSS_ROOT /usr/${CROSS_TRIPLE}
ENV AS=/usr/bin/${CROSS_TRIPLE}-as \
    AR=/usr/bin/${CROSS_TRIPLE}-ar \
    CC=/usr/bin/${CROSS_TRIPLE}-gcc \
    CPP=/usr/bin/${CROSS_TRIPLE}-cpp-4.9 \
    CXX=/usr/bin/${CROSS_TRIPLE}-g++ \
    LD=/usr/bin/${CROSS_TRIPLE}-ld

# Tuned for reMarkable tablet:
#   Freescale i.MX6 SoloLite
#   ARM A9 CPU @1GHz (1 Core, Cortex A9)
#   model name : ARMv7 Processor rev 10 (v7l)
#   BogoMIPS : 48.00
#   Features : half thumb fastmult vfp edsp neon vfpv3 tls vfpd32
# evaluate:
#   -mslow-flash-data
#   -mfloat-abi=hard
ENV CFLAGS="-march=armv7-a -mtune=cortex-a9 -mfpu=neon -funsafe-math-optimizations -mthumb" \
  CXXFLAGS="-march=armv7-a -mtune=cortex-a9 -mfpu=neon -funsafe-math-optimizations -mthumb"

#ENV DEFAULT_DOCKCROSS_IMAGE dockcross/linux-armv7
ENV DEFAULT_DOCKCROSS_IMAGE linux-armv7

# Note: Toolchain file support is currently in debian Experimental:
# https://wiki.debian.org/CrossToolchains#In_jessie_.28Debian_8.29
COPY Toolchain.cmake /usr/lib/${CROSS_TRIPLE}/
ENV CMAKE_TOOLCHAIN_FILE /usr/lib/${CROSS_TRIPLE}/Toolchain.cmake

# build examples
#   powertop
#   ./autogen.sh
#   ./configure LIBNL_CFLAGS="-I/usr/lib/arm-linux-gnueabihf/libnl3 -I/usr/include/libnl3" LIBNL_LIBS="-L/usr/lib/arm-linux-gnueabihf -lnl-3 -lnl-genl-3"
#   make
