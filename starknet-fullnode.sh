#!/bin/bash

echo "=================================================="
echo -e "\033[0;35m"
echo "                             .__      ";
echo "   _________.__. ____ _____  |  |__   ";
echo "  / ____<   |  |/ __ \\__  \ |  |  \  ";
echo " < <_|  |\___  \  ___/ / __ \|   Y  \ ";
echo "  \__   |/ ____|\___  >____  /___|  / ";
echo "     |__|\/         \/     \/     \/  ";
echo "                                      ";
echo -e "\e[0m"
echo "=================================================="

sleep 2

echo -e "\e[1m\e[32m1. Set your alchemy or infura http address \e[0m" && sleep 1

while :
do
  read -p "INPUT HTTP ADDRESS: " ADDRESS
  if [ -n "$ADDRESS" ]; then
    break
  fi
done

echo "=================================================="

echo -e "\e[1m\e[32m2. Updating list of dependencies... \e[0m" && sleep 1
sudo apt-get update
cd $HOME

echo "=================================================="

echo -e "\e[1m\e[32m3. Checking if Docker is installed... \e[0m" && sleep 1

if ! command -v docker &> /dev/null
then

    echo -e "\e[1m\e[32m3.1 Installing Docker... \e[0m" && sleep 1
    sudo apt-get install ca-certificates curl gnupg lsb-release wget -y
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io -y
fi

echo "=================================================="

echo -e "\e[1m\e[32m4. Checking if Docker Compose is installed ... \e[0m" && sleep 1

docker compose version &> /dev/null
if [ $? -ne 0 ]
then

    echo -e "\e[1m\e[32m4.1 Installing Docker Compose v2.3.3 ... \e[0m" && sleep 1
    mkdir -p ~/.docker/cli-plugins/
    curl -SL https://github.com/docker/compose/releases/download/v2.2.3/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
    chmod +x ~/.docker/cli-plugins/docker-compose
    sudo chown $USER /var/run/docker.sock
fi

echo "=================================================="

echo -e "\e[1m\e[32m5. Downloading Starkware FullNode ... \e[0m" && sleep 1

rm -rf $HOME/pathfinder
sudo mkdir -p $HOME/pathfinder

docker run \
  --detach \
  --name starknet-fullnode \
  -p 9545:9545 \
  -e RUST_LOG=info \
  -e PATHFINDER_ETHEREUM_API_URL=$ADDRESS \
  -v $HOME/pathfinder \
  eqlabs/pathfinder

echo "=================================================="

echo -e "\e[1m\e[32m6. Starting Starknet FullNode ... \e[0m" && sleep 1

docker ps

echo "=================================================="

echo -e "\e[1m\e[32mStarknet FullNode Started \e[0m"

echo "=================================================="

echo -e "\e[1m\e[32mTo update docker image: \e[0m"
echo -e "\e[1m\e[39m"    docker pull eqlabs/pathfinder" \n \e[0m"

echo -e "\e[1m\e[32mTo view logs: \e[0m"
echo -e "\e[1m\e[39m    docker logs -f starknet-fullnode --tail 5000 \n \e[0m"

echo -e "\e[1m\e[32mTo stop: \e[0m"
echo -e "\e[1m\e[39m    docker stop starknet-fullnode \n \e[0m"

echo "=================================================="