#!/bin/bash
#set -e
CONFIG_PATH=/data/options.json

#rm -rf *
#mkdir -p bot && chmod -R 777 bot && cd bot

DEFAULT_HUBOT_SLACK_TOKEN=""
DEFAULT_HUBOT_HOME_ASSISTANT_HOST=""
DEFAULT_HUBOT_HOME_ASSISTANT_API_PASSWORD=""
DEFAULT_HUBOT_HOME_ASSISTANT_MONITOR_EVENTS="Yes"
DEFAULT_HUBOT_HOME_ASSISTANT_MONITOR_ALL_ENTITIES="Yes"
DEFAULT_HUBOT_HOME_ASSISTANT_EVENTS_DESTINATION="#home-assistant"

HUBOT_SLACK_TOKEN=$(jq --raw-output ".hubot_slack_token // empty" $CONFIG_PATH)
HUBOT_HOME_ASSISTANT_HOST=$(jq --raw-output ".hubot_home_assistant_host // empty" $CONFIG_PATH)
HUBOT_HOME_ASSISTANT_API_PASSWORD=$(jq --raw-output ".hubot_home_assistant_api_password // empty" $CONFIG_PATH)
HUBOT_HOME_ASSISTANT_MONITOR_EVENTS=$(jq --raw-output ".hubot_home_assistant_monitor_events // empty" $CONFIG_PATH)
HUBOT_HOME_ASSISTANT_MONITOR_ALL_ENTITIES=$(jq --raw-output ".hubot_home_assistant_monitor_all_entities // empty" $CONFIG_PATH)
HUBOT_HOME_ASSISTANT_EVENTS_DESTINATION=$(jq --raw-output ".hubot_home_assistant_events_destination // empty" $CONFIG_PATH)

cat /external-scripts.json > /data/external-scripts.json
cat /external-scripts.json  > /usr/src/hubot/external-scripts.json

HUBOT_SLACK_TOKEN=$HUBOT_SLACK_TOKEN HUBOT_HOME_ASSISTANT_HOST="$HUBOT_HOME_ASSISTANT_HOST" \
HUBOT_HOME_ASSISTANT_API_PASSWORD=$HUBOT_HOME_ASSISTANT_API_PASSWORD \
HUBOT_HOME_ASSISTANT_MONITOR_EVENTS=$HUBOT_HOME_ASSISTANT_MONITOR_EVENTS \
HUBOT_HOME_ASSISTANT_MONITOR_ALL_ENTITIES=$HUBOT_HOME_ASSISTANT_MONITOR_ALL_ENTITIES \
HUBOT_HOME_ASSISTANT_EVENTS_DESTINATION="$HUBOT_HOME_ASSISTANT_EVENTS_DESTINATION" \
./bin/hubot --adapter slack
