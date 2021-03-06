FROM bregell/wine
MAINTAINER Johan Bregell

ENV WORK "/mnt/root/space-engineers-server"
ENV CONFIG "/mnt/root/space-engineers-server/config"
ENV SERVER_NAME DockerDedicated
ENV WORLD_NAME DockerWorld
ENV STEAM_PORT 8766
ENV SERVER_PORT 27016

USER root
RUN mkdir -p ${WORK}
RUN mkdir -p ${CONFIG}
WORKDIR /home/root
COPY entrypoint.sh /entrypoint.sh
COPY SpaceEngineers-Dedicated.cfg /home/root/SpaceEngineers-Dedicated.cfg
RUN chmod +x /entrypoint.sh

WORKDIR ${WORK}
ENTRYPOINT ["/entrypoint.sh"]

VOLUME ${WORK}

EXPOSE ${STEAM_PORT}/udp
EXPOSE ${SERVER_PORT}/udp
