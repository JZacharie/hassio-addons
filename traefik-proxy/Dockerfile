ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

RUN mkdir /data && \
    apk add --no-cache jq && \
    wget https://github.com/containous/traefik/releases/download/v1.6.6/traefik_linux-amd64 -O /traefik

COPY run.sh /
COPY traefik.toml /traefik.toml
COPY docker.tmpl /docker.tmpl
RUN chmod a+x /run.sh /traefik

WORKDIR /data
CMD [ "/run.sh" ]
