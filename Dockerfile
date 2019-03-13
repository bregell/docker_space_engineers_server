FROM bregell/wine
MAINTAINER Johan Bregell

ENV DISPLAY=:0
ENV CONFIG "/home/steam/.wine/drive_c/users/steam/Application Data/SpaceEngineersDedicated"
ENV SERVER_NAME DefaultSavePath

USER root
RUN mkdir -p /mnt/steam/space-engineers-server
RUN mkdir -p $CONFIG
WORKDIR /home/steam
COPY entrypoint.sh /entrypoint.sh
COPY SpaceEngineers-Dedicated.cfg /home/steam/SpaceEngineers-Dedicated.cfg
RUN chmod +x /entrypoint.sh
RUN chown -R steam /home/steam/*

USER steam
ENTRYPOINT ["/entrypoint.sh"]

VOLUME /mnt/steam/space-engineers-server
VOLUME $CONFIG
