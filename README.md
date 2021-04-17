# Hugtakasafn

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

hugtakasafn/install-docker-ubuntu.sh

hugtakasafn/deploy-hugtakasafn-with-docker-compose.sh
```
- a NaviServer source compilation is performed by the Docker Compose declaration, so the initial deployment by `deploy-hugtakasafn-with-docker-compose.sh` may take several minutes.

### Restart HTS services
```
sudo systemctl start docker-compose@hugtakasafn
```

## Update HTS with MultiTerm export

Place the MultiTerm export XML file in `/tmp/hugtakasafn-import` and run:
```
hugtakasafn/updateHTS.sh
```

## Update the STJR HTML frame around the HTS web UI
```
hugtakasafn/updateSTJRframe.sh
```
