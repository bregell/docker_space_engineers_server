FROM bregell/wine
MAINTAINER Johan Bregell

ENV DISPLAY=:0

USER root
RUN mkdir -p /mnt/steam/space-engineers-server
WORKDIR /home/steam
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN chown -R steam /home/steam/*
RUN ls -l

USER steam
ENTRYPOINT ["/entrypoint.sh"]

VOLUME /mnt/steam/space-engineers-server
