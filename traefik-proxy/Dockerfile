ARG BUILD_FROM
FROM $BUILD_FROM
ARG BUILD_FROM

ENV LANG C.UTF-8 \
    TERM="xterm-256color"
    
RUN mkdir /data && \
    apk add --no-cache jq && \
    export BUILD_ARCH=$(echo ${BUILD_FROM} | awk -F'-' '{ print $2}' | awk -F':' '{ print $1}'); \
    if [[ "x$BUILD_ARCH" = "xamd64" ]] ; then export TRAEFIK_ARCH="amd64" ; fi && \
    if [[ "x$BUILD_ARCH" = "xaarch64" ]] ; then export TRAEFIK_ARCH="arm64" ; fi && \
    if [[ "x$BUILD_ARCH" = "xarmhf" ]] ; then export TRAEFIK_ARCH="arm" ; fi && \
    if [[ "x$BUILD_ARCH" = "xi386" ]] ; then export TRAEFIK_ARCH="386" ; fi && \
    wget https://github.com/containous/traefik/releases/download/v1.6.6/traefik_linux-${TRAEFIK_ARCH} -O /traefik

COPY run.sh /
COPY traefik.toml /traefik.toml
COPY docker.tmpl /docker.tmpl
RUN chmod a+x /run.sh /traefik

WORKDIR /data
CMD [ "/run.sh" ]
