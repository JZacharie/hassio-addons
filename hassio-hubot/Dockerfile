ARG BUILD_FROM
FROM ${BUILD_FROM}

ENV LANG C.UTF-8

RUN apk add --update nodejs nodejs-npm jq curl && \
#    curl https://raw.github.com/isaacs/uid-number/v0.0.5/uid-number.js > /usr/lib/node_modules/npm/node_modules/uid-number/uid-number.js && \
#    curl https://gist.githubusercontent.com/isaacs/9117286/raw/ad3838d3a41ceed6235bf1f4a33fc092bc77ff93/fix-global-installs.sh > /tmp/fix-global-installs.sh && \
#    sed -e '/exit 1/ s/^#*/#/' -i /tmp/fix-global-installs.sh && \
#    chmod +x /tmp/fix-global-installs.sh && /tmp/fix-global-installs.sh && \
    npm config set unsafe-perm true && npm install -g yo generator-hubot && \
    mkdir -p /hubot /root/.config/insight-nodejs && \
    chmod g+rwx /root /root/.config /root/.config/insight-nodejs

COPY external-scripts.json /external-scripts.json
COPY run.sh /
RUN chmod a+x /run.sh

WORKDIR /data

CMD [ "/run.sh" ]
