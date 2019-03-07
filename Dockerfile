FROM ubuntu:16.04

LABEL maintainer=https://github.com/bregell/docker_space_engineers_server

ARG USER=space
ARG GROUP=space
ARG PUID=898
ARG PGID=898

RUN addgroup --gid $PGID $GROUP && \
	adduser --uid $PUID --gid $PGID --shell /bin/bash --no-create-home --disabled-password $USER && \
	mkdir -p /home/$USER && \
	chown -R $USER:$GROUP /home/$USER

ENV HOME /home/$USER
WORKDIR /home/$USER

ENV WINEPREFIX /home/$USER/.wine
ENV WINEARCH win32
ENV WINEDEBUG -all

ENV DEBIAN_FRONTEND noninteractive

COPY gacutil-net40.tar.bz2 .

# We want the 32 bits version of wine allowing winetricks.
RUN	dpkg --add-architecture i386 && \

	# Dot Net 4.0 req
	mkdir -p /home/$USER/.cache/winetricks/dotnet40 && \
	mv gacutil-net40.tar.bz2 /home/$USER/.cache/winetricks/dotnet40 && \
	chown -R $USER:$GROUP /home/$USER && \

# Set the time zone.
#	echo "Europe/Stockholm" > /etc/timezone && \
#	dpkg-reconfigure -f noninteractive tzdata && \
	apt-get update && apt-get install -y --no-install-recommends apt-utils && \

# Updating and upgrading a bit.
	apt-get update && \
	apt-get upgrade -y && \

# We need software-properties-common to add ppas.
	apt-get install -y --no-install-recommends software-properties-common apt-transport-https wget && \

# Add the wine PPA.
	wget -nc https://dl.winehq.org/wine-builds/winehq.key && \
	apt-key add winehq.key && \
	apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ xenial main' && \
#	add-apt-repository ppa:wine/wine-builds && \
#	wget https://dl.winehq.org/wine-builds/Release.key && \
#	apt-key add Release.key && \
#	apt-add-repository 'https://dl.winehq.org/wine-builds/ubuntu/' && \
	apt-get update && \

# Installation of win, winetricks and temporary xvfb to install winetricks tricks during docker build.
	apt-get install -y --no-install-recommends --allow-unauthenticated winehq-stable winetricks xvfb && \

# Installation of winbind to stop ntlm error messages.
	apt-get install -y --no-install-recommends winbind && \

# Installation of winetricks tricks as wine user.
	su -p -l $USER -c 'winecfg' && \
#	su -p -l $USER -c 'xvfb-run -a winetricks -q corefonts && wineserver --wait' && \
#	su -p -l $USER -c 'xvfb-run -a winetricks -q dotnet20 && wineserver --wait' && \
	su -p -l $USER -c 'xvfb-run -a winetricks -q dotnet40' && \
#	su -p -l $USER -c 'xvfb-run -a winetricks -q xna40 && wineserver --wait' && \
#	su -p -l $USER -c 'xvfb-run -a winetricks d3dx9 && wineserver --wait' && \
#	su -p -l $USER -c 'xvfb-run -a winetricks -q directplay && wineserver --wait' && \

# Installation of git, build tools and sigmap.
	apt-get install -y --no-install-recommends build-essential git-core && \
	git clone https://github.com/marjacob/sigmap.git && \
	(cd sigmap && exec make) && \
	install sigmap/bin/sigmap /usr/local/bin/sigmap && \
	rm -rf sigmap/ && \

# Install SteamCMD
	mkdir -p /steamcmd && cd /steamcmd && \
	wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz && \
	tar -xvzf steamcmd_linux.tar.gz && \

# Cleaning up.
	apt-get autoremove -y --purge build-essential git-core && \
	apt-get autoremove -y --purge software-properties-common && \
	apt-get autoremove -y --purge xvfb && \
	apt-get autoremove -y --purge && \
	apt-get clean -y && \
	rm -rf /home/$USER/.cache && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Download Space Engineers Dedicated Server
RUN cd /steamcmd && ./steamcmd.sh +login anonymous +force_install_dir /home/$USER/.wine/drive_c/users/$USER/DedicatedServer +app_update 298740 +quit

######################### END OF INSTALLATIONS ##########################

# Add the dedicated server files.
ADD SpaceEngineers-Dedicated.cfg /home/root/

#ADD install.sh /install.sh
#RUN /install.sh && rm /install.sh

# Launching the server as the wine user.
#ENTRYPOINT ["/usr/local/bin/sigmap", "-m 15:2", "/usr/local/bin/space-engineers-server", "-noconsole"]
#CMD [""]
