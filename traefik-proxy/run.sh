#!/bin/bash
#set -e
CONFIG_PATH=/data/options.json
TRAEFIK_CONFIG_PATH=/data/traefik.toml
ACME_PATH=/data/acme

DEFAULT_BASE_DOMAIN=""
DEFAULT_ACME_EMAIL=""
DEFAULT_ACME_ENABLED=""

BASE_DOMAIN=$(jq --raw-output ".BASE_DOMAIN // empty" $CONFIG_PATH)
ACME_EMAIL=$(jq --raw-output ".ACME_EMAIL // empty" $CONFIG_PATH)
ACME_ENABLED=$(jq --raw-output ".ACME_ENABLED // empty" $CONFIG_PATH)

mkdir -p ${ACME_PATH}

sed -i "s/##BASE_DOMAIN##/${BASE_DOMAIN}/" /traefik.toml
sed -i "s/##ACME_EMAIL##/${ACME_EMAIL}/" /traefik.toml

if [[ ${ACME_ENABLED} -eq "true" ]]
then
    sed -i 's/^##ACME_ENABLED//' /traefik.toml
fi

cp /traefik.toml ${TRAEFIK_CONFIG_PATH}

/traefik --logLevel=DEBUG -c ${TRAEFIK_CONFIG_PATH}