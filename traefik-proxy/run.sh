#!/bin/bash
#set -e
CONFIG_PATH=/data/options.json
ACME_PATH=/data/acme

#rm -rf *
#mkdir -p bot && chmod -R 777 bot && cd bot
DEFAULT_BASE_DOMAIN=""
DEFAULT_ACME_EMAIL=""
DEFAULT_ACME_DOMAINS=""

BASE_DOMAIN=$(jq --raw-output ".DEFAULT_BASE_DOMAIN // empty" $CONFIG_PATH)
ACME_EMAIL=$(jq --raw-output ".DEFAULT_ACME_EMAIL // empty" $CONFIG_PATH)
ACME_DOMAINS=$(jq --raw-output ".DEFAULT_ACME_DOMAINS // empty" $CONFIG_PATH)

/traefik  --web --logLevel=DEBUG --docker --docker.domain=${BASE_DOMAIN} --docker.watch \
--acme --acme.storage=/etc/traefik/acme/acme.json acme.email=${ACME_EMAIL} --acme.entryPoint=https \
--entryPoints='Name:https Address::443 TLS' --entryPoints='Name:http Address::80 Redirect.EntryPoint:https' \
--defaultentrypoints=http,https --acme.domains=${ACME_DOMAINS}