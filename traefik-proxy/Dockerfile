ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

RUN wget https://github.com/containous/traefik/releases/download/v1.6.6/traefik_linux-amd64 &&

COPY run.sh /
RUN chmod a+x /run.sh && chown -R hubot:hubot /usr/src/hubot
CMD [ "/run.sh" ]
