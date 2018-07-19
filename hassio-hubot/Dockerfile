ARG BUILD_FROM
FROM ${BUILD_FROM}

ENV LANG C.UTF-8

RUN apk add --update nodejs nodejs-npm jq curl && \
    npm config set unsafe-perm true && npm install -g yo generator-hubot && \
    mkdir -p /hubot /root/.config/insight-nodejs && \
    chmod g+rwx /root /root/.config /root/.config/insight-nodejs

WORKDIR /data

RUN npm config set unsafe-perm true && npm install -g yo generator-hubot && \
    yo hubot --owner="Hubot HomeAssistant" --name="Hubot" --adapter=slack --description="Homeassistant Hubot" -f && \
    npm install hubot-home-assistant --save

COPY external-scripts.json /external-scripts.json

RUN mv /external-scripts.json /data/external-scripts.json

COPY run.sh /
RUN chmod a+x /run.sh


CMD [ "/run.sh" ]
