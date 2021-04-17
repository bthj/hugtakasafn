# hugtakasafn

Term catcher implemented in JavaScript and XUL as a Firefox plugin to assist in the harvest of new terms from translation documents by comparing their content with a term bank and related data.

Accompanying term bank website and it's import/export routines (on data from Trados MultiTerm) scripted in TCL and based on AOLserver.

http://hugtakasafn.utn.stjr.is/


Automatically exported from code.google.com/p/hugtakasafn

## Running locally

Prerequisites:
- [Docker Engine](https://docs.docker.com/engine/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)

```
docker-compose up
```

## Deploy as a Linux SystemD service

```
git clone https://github.com/bthj/hugtakasafn.git

cd hugtakasafn/

./install-docker-ubuntu.sh

./deploy-hugtakasafn-with-docker-compose.sh
```
