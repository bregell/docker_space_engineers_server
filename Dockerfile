FROM ianomaly/docker-ubuntu-steamcmd
MAINTAINER Cameron Boulton <https://github.com/iAnomaly>

RUN apt-get update && apt-get install -y --no-install-recommends \
software-properties-common
RUN dpkg --add-architecture i386 \
&& add-apt-repository ppa:ubuntu-wine/ppa \
&& apt-get update
RUN apt-get install -y --no-install-recommends \
wine1.7 \
winetricks
USER steam
ENV DISPLAY= WINEDEBUG=-all
RUN WINEARCH=win32 winecfg \
&& winetricks -q dotnet40
RUN wine wineboot
RUN mkdir /mnt/steam/space-engineers-server
WORKDIR /mnt/steam/space-engineers-server
RUN ln -s $(readlink -f config) ~/.wine/drive_c/users/steam/Application\ Data/SpaceEngineersDedicated
USER root
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["space-engineers-server"]
