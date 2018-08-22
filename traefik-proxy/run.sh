#!/bin/bash
#set -e
CONFIG_PATH=/data/options.json
TRAEFIK_CONFIG_PATH=/data/traefik.toml
ACME_PATH=/data/acme

DEFAULT_BASE_DOMAIN=""
DEFAULT_ACME_EMAIL=""
#DEFAULT_ACME_DOMAINS="''"

BASE_DOMAIN=$(jq --raw-output ".BASE_DOMAIN // empty" $CONFIG_PATH)
ACME_EMAIL=$(jq --raw-output ".ACME_EMAIL // empty" $CONFIG_PATH)
#ACME_DOMAINS=$(jq --raw-output ".ACME_DOMAINS // empty" $CONFIG_PATH)

mkdir -p ${ACME_PATH}

sed -i "s/##BASE_DOMAIN##/${BASE_DOMAIN}" /traefik.toml
sed -i "s/##ACME_EMAIL##/${ACME_EMAIL}" /traefik.toml

cp /traefik.toml ${TRAEFIK_CONFIG_PATH}

/traefik --web --logLevel=DEBUG --docker --docker.domain="${BASE_DOMAIN}" --docker.watch \
--acme --acme.storage=${ACME_PATH}/acme.json acme.email="${ACME_EMAIL}" --acme.entryPoint=https \
--entryPoints='Name:https Address::443 TLS' --entryPoints='Name:http Address::80 Redirect.EntryPoint:https' \
--defaultentrypoints=http,https --acme.domains="${ACME_DOMAINS}"