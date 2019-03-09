FROM bregell/wine
MAINTAINER Johan Bregell

ENV DISPLAY=:0

ENV CONFIG /home/steam/.wine/drive_c/users/steam/Application\ Data/SpaceEngineersDedicated
ENV MODS $CONFIG/Mods
ENV SAVES $CONFIG/Saves
ENV UPDATER $CONFIG/Updater

USER root
RUN mkdir -p /mnt/steam/space-engineers-server
WORKDIR /mnt/steam/space-engineers-server
RUN mkdir -p /mnt/steam/space-engineers-server/config
COPY Nerdz/ Nerdz
COPY entrypoint.sh /entrypoint.sh
COPY SpaceEngineers-Dedicated.cfg SpaceEngineers-Dedicated.cfg
RUN chmod +x /entrypoint.sh

RUN ln -s $CONFIG /mnt/steam/space-engineers-server/config
#RUN mkdir -p /home/steam/.wine/drive_c/users/steam/Application\ Data/SpaceEngineersDedicated
#RUN mkdir -p $MODS
#RUN mkdir -p $SAVES
#RUN mkdir -p $UPDATER
#RUN cp /mnt/steam/space-engineers-server/SpaceEngineers-Dedicated.cfg /home/steam/.wine/drive_c/users/steam/Application\ Data/SpaceEngineersDedicated/SpaceEngineers-Dedicated.cfg

RUN chown -R steam /mnt/steam/space-engineers-server /home/steam/*

VOLUME /mnt/steam/space-engineers-server
VOLUME /home/steam/.wine/drive_c/users/steam/Application\ Data/SpaceEngineersDedicated

USER steam
ENTRYPOINT ["/entrypoint.sh"]
