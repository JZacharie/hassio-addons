#!/bin/bash
set -e
CONFIG_PATH=/data/options.json

DEFAULT_UUID=$(cat /proc/sys/kernel/random/uuid)
DEFAULT_HUBOT_SLACK_TOKEN=""
DEFAULT_HUBOT_HOME_ASSISTANT_HOST=""
DEFAULT_HUBOT_HOME_ASSISTANT_API_PASSWORD=""
DEFAULT_HUBOT_HOME_ASSISTANT_MONITOR_EVENTS="Yes"
DEFAULT_HUBOT_HOME_ASSISTANT_MONITOR_ALL_ENTITIES="Yes"
DEFAULT_HUBOT_HOME_ASSISTANT_EVENTS_DESTINATION="#home-assistant"

UUID=$(jq --raw-output ".uuid // empty" $CONFIG_PATH)
HUBOT_SLACK_TOKEN=$(jq --raw-output ".hubot_slack_token // empty" $CONFIG_PATH)
HUBOT_HOME_ASSISTANT_HOST=$(jq --raw-output ".hubot_home_assistant_host // empty" $CONFIG_PATH)
HUBOT_HOME_ASSISTANT_API_PASSWORD=$(jq --raw-output ".hubot_home_assistant_api_password // empty" $CONFIG_PATH)
HUBOT_HOME_ASSISTANT_MONITOR_EVENTS=$(jq --raw-output ".hubot_home_assistant_monitor_events // empty" $CONFIG_PATH)
HUBOT_HOME_ASSISTANT_MONITOR_ALL_ENTITIES=$(jq --raw-output ".hubot_home_assistant_monitor_all_entities // empty" $CONFIG_PATH)
HUBOT_HOME_ASSISTANT_EVENTS_DESTINATION=$(jq --raw-output ".hubot_home_assistant_events_destination // empty" $CONFIG_PATH)

# Store generated UUID if not set
if [ -z "${UUID}" ]; then
  UUID=${DEFAULT_UUID^^}
  NEW_CONF=$(jq --arg uuid ${UUID} '. + {uuid: $uuid}' $CONFIG_PATH)
  echo "No UUID found, updating config with a generated UUID"
  echo $NEW_CONF
  echo $NEW_CONF > $CONFIG_PATH
fi

#mkdir bot
#chmod -R g+rwx /hubot
#cd /hubot/bot

npm config set unsafe-perm true && npm install -g yo generator-hubot
yo hubot --owner="Hubot HomeAssistant" --name="Hubot" --adapter=slack --description="Homeassistant Hubot"
npm install hubot-home-assistant --save

cat /external-scripts.json > ./external-scripts.json

ls -lrta .
ls -lrt ./bin

HUBOT_SLACK_TOKEN=$HUBOT_SLACK_TOKEN HUBOT_HOME_ASSISTANT_HOST="$HUBOT_HOME_ASSISTANT_HOST" \
HUBOT_HOME_ASSISTANT_API_PASSWORD=$HUBOT_HOME_ASSISTANT_API_PASSWORD \
HUBOT_HOME_ASSISTANT_MONITOR_EVENTS=$HUBOT_HOME_ASSISTANT_MONITOR_EVENTS \
HUBOT_HOME_ASSISTANT_MONITOR_ALL_ENTITIES=$HUBOT_HOME_ASSISTANT_MONITOR_ALL_ENTITIES \
HUBOT_HOME_ASSISTANT_EVENTS_DESTINATION="$HUBOT_HOME_ASSISTANT_EVENTS_DESTINATION" \
./bin/hubot --adapter slack
