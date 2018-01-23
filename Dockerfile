ARG base_image_version=0.9.22
FROM phusion/baseimage:$base_image_version

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

ENV DEBIAN_FRONTEND noninteractive
ENV SYSTEM_PACKAGES="apt-transport-https libmicrohttpd10 libssl1.0.0"

# Install prereqs and setup apt (http://dockerfile.github.io/#/ubuntu)
RUN \
  apt-get update && \
  apt-get install -y $SYSTEM_PACKAGES && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


ARG XMR_STAK_CPU_VERSION=v1.1.0-1.2.0
ENV XMR_STAK_CPU_VERSION=${XMR_STAK_CPU_VERSION}
ARG pool_address
ENV POOL_ADDRESS=${pool_address}
ARG pool_password
ENV POOL_PASSWORD=${pool_password}
ARG wallet_address
ENV WALLET_ADDRESS=${wallet_address}

COPY install_xmr_stak.sh /usr/local/bin/install_xmr_stak.sh
RUN chmod +x /usr/local/bin/install_xmr_stak.sh
RUN /usr/local/bin/install_xmr_stak.sh

EXPOSE 8080

RUN mkdir /etc/service/xmr-stak
COPY xmr-stak-service.sh /etc/service/xmr-stak/run
RUN chmod +x /etc/service/xmr-stak/run

COPY config.txt /usr/local/etc/config.txt

RUN useradd -r -M turtle
