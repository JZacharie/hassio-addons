# traefik-proxy


## Prerequisites

This addon requires the addon [Docker Enabler](https://github.com/hassio-addons/addon-docker-enabler/blob/master/README.md) to be installed first.

You should configure it to give Docker's API access to Traefik Proxy.

````
{
  "target": "bfa1c843_hassio_traefik"
}
````

## Configure it

Let's talk abpout this addon configuration.

Here are the parameters this addon needs.

Name | Description | Default Value
------------ | ------------- | -------------
BASE_DOMAIN | This is the base domain on which Traefik will expose things. Shoud be set to `myhass.io` | N/A
ACME_ENABLED | Should we enable Let's Encrypt or not ? If yes, set it to `true`, by doing so, you'll also enable HTTP to HTTPS redirection. | true
ACME_EMAIL | Your email address to use with Let's Encrypt. | N/A

## How it works

Traefik will be launched in an unprotected container, that will be able to listen on Docker's API and be aware of any container changes.

It'll then automatically expose all your container that are exposing some ports on your HassIO box.

Fort example, if your HassIO box's hostname is `myhass.io` and you're running the [Log Viewer](https://github.com/hassio-addons/addon-log-viewer) addon that's listen on port 4277, it'll exposed with the following URL : http(s)://myhass.io/addon_a0d7b954_logviewer/.