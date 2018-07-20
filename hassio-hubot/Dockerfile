FROM aarch64/node:7.7.1-slim

# Experimental ARMv8 support for Node-RED

# Home directory for Node-RED application source code.
RUN mkdir -p /usr/src/hubot

# User data directory, contains flows, config and nodes.
RUN mkdir /data


RUN curl http://ftp.de.debian.org/debian/pool/main/j/jq/jq_1.4-2.1+deb8u1_arm64.deb > jq.deb && \
    dpkg -i jq.deb

WORKDIR /usr/src/hubot

# Add hubot user so we aren't running as root.
RUN useradd --home-dir /usr/src/hubot --no-create-home hubot \
    && chown -R hubot:hubot /data \
    && chown -R hubot:hubot /usr/src/hubot

COPY external-scripts.json /usr/src/hubot/external-scripts.json.new
COPY run.sh /
RUN chmod a+x /run.sh && chown -R hubot:hubot /usr/src/hubot

USER hubot

# package.json contains Node-RED NPM module and node dependencies
#COPY package.json /usr/src/hubot/
#RUN npm install

RUN npm install -g generator-hubot yo && \
    yo hubot --owner="Hubot HomeAssistant" --name="Hubot" --adapter=slack --description="Homeassistant Hubot" -f && \
    npm install hubot-home-assistant --save && \
    rm -f /usr/src/hubot/external-scripts.json

RUN sed -e '4d' /usr/src/hubot/external-scripts.json.new > /usr/src/hubot/external-scripts.json

CMD [ "/run.sh" ]
