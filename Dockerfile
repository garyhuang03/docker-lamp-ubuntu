FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /usr/local/bin

COPY init.sh /usr/local/bin
COPY install_lamp.sh /usr/local/bin

RUN chmod +x /usr/local/bin/*.sh && \
    sh /usr/local/bin/install_lamp.sh && \
    rm -rf /var/lib/apt/lists/*

VOLUME /var/www/html 
EXPOSE 80

CMD ["./init.sh"]
