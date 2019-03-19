FROM bregell/wine
MAINTAINER Johan Bregell

ENV DISPLAY=:0
ENV WORK "/mnt/root/space-engineers-server"
ENV CONFIG "/mnt/root/space-engineers-server/config"
ENV SERVER_NAME DefaultSavePath

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
#VOLUME ${CONFIG}
