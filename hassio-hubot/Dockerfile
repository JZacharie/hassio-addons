ARG BUILD_FROM
FROM ${BUILD_FROM}

ENV LANG C.UTF-8

RUN apk add --update nodejs nodejs-npm jq && \
    npm install -g yo generator-hubot && \
    mkdir -p /hubot /root/.config/insight-nodejs && \
    chmod g+rwx /root /root/.config /root/.config/insight-nodejs

WORKDIR /hubot

COPY external-scripts.json /hubot/external-scripts.json
COPY run.sh /
RUN chmod a+x /run.sh
CMD [ "/run.sh" ]
