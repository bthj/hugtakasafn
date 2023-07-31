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
sudo systemctl restart docker-compose@hugtakasafn
```

### View HTS service logs
```
cd hugtakasafn/
sudo docker-compose logs -f -t naviserver
sudo docker-compose logs --tail=1000 naviserver

sudo docker-compose logs -f -t postgres
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

## Bind mount the HTS web root from the host filesystem
If ad-hoc edits of file contents in the HTS web root are desirable, for e.g. simple text updates, a copy of the HTS web root in the host file system can be bind mounted to the corresponding location within the `hugtakasafn_naviserver` container.  This can be accomplished by editing the deployed Docker Compose declaration:
```
sudo vi /etc/docker/compose/hugtakasafn/docker-compose.yaml
```
and adding an entry like:
```
services:
naviserver:
  ...
  volumes:
    ...
    - /home/hugtakasafn/hugtakasafn/HTS/www:/home/nsadmin/web/hugtakasafn/www
```
