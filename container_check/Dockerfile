ARG BUILD_FROM
FROM $BUILD_FROM
ARG BUILD_FROM
ARG BUILD_ARCH

ENV LANG C.UTF-8 \
    TERM="xterm-256color"
    
RUN mkdir /data /app && \
    apk add --no-cache jq python \
    python-dev \
    py-pip \
    build-base \
  && rm -rf /var/cache/apk/*

COPY run.sh /
RUN chmod a+x /run.sh

COPY ./web /app
WORKDIR /app

RUN pip install -r requirements.txt
ENTRYPOINT ["python"]
CMD ["app.py"]