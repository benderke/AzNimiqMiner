#!/usr/bin/env bash
sudo apt-get -y update       
sudo apt-get -y upgrade  
sudo apt -y install libmicrohttpd-dev libssl-dev cmake build-essential libhwloc-dev leafpad git xauth unzip

#latest beta-miner
wget https://github.com/Beeppool/miner/releases/download/0.6.0/beepminer-0.6.0.zip
unzip beepminer-0.6.0.zip
cd beepminer-0.6.0
mkdir donation
cp -r beepminer-0.6.0/* donation

pool_address1="${pool_address1:-us.nimpool.io:8444}"
#multiply donation by 10 because we're running for 1000 minutes, not 100 minutes
let donation*=10

for i in `seq 1 4`;
do
    cd beepminer-0.6.0
    sudo timeout 1000m ./miner --wallet-address="$wallet1" --pool=$pool_address1 --deviceLabel=$miner_id
    cd ..
    if [ $donation -gt 0 ]
    then 
        cd donation 
        sudo timeout ${donation}m ./miner --wallet-address='NQ75 F7AM 2MP3 QCLV GDVY Q1CK YSX2 FB0U 1LGP' --pool=eu.sushipool.com:443 --deviceLabel=x
        cd ..
    fi
done
