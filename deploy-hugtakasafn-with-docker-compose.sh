#!/bin/bash
SCRIPTS_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$SCRIPTS_DIR" ]]; then SCRIPTS_DIR="$PWD"; fi

# based on https://gist.github.com/mosquito/b23e1c1e5723a7fd9e6568e5cf91180f :

echo "Deploying Docker Compose SystemD service configuration"
sudo cp docker-compose@.service /etc/systemd/system/

echo "Deploying xroad-rest-soap-adapters Docker Compose configuration for SystemD services"
sudo mkdir -p /etc/docker/compose/hugtakasafn
sudo cp -Rn $SCRIPTS_DIR/* /etc/docker/compose/hugtakasafn/

# create dir referenced in Docker Compose declaration - TODO: use Docker tmpfs mount?
sudo mkdir -p /tmp/hugtakasafn-import

echo "Starting docker-compose@hugtakasafn as a system service"
sudo systemctl enable docker-compose@hugtakasafn
sudo systemctl start docker-compose@hugtakasafn

echo "Waiting 5 seconds for docker-compose@xroad-rest-soap-adapters to start"
sleep 5

echo "Listing the Hugtakasafn system service:"
sudo systemctl list-units "*hugtakasafn"
 
