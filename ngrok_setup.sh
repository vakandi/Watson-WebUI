#!/bin/bash


api_android="k-1deb4a7ba1f3"
host="$(hostname)"
daatee=$(date "+%Y_%m_%d_%H:%M")
PORT=7860
IP="$(curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//')"
if [ -z $link ]
then
    echo "Ngrok Server Not Started.."
    ngrok http $PORT > /dev/null &
    sleep 1.5s
    echo "$(curl -s localhost:4040/api/tunnels | jq -r ".tunnels[0].public_url")" > $HOME/.link_watson 
    link="$(cat $HOME/.link_watson)"
    curl http://xdroid.net/api/message\?k\=$api_android\&t\=Watson+Active\&c\=IP:$IP+$host+$daatee\&u\=$link 
else
    echo "Ngrok Server Already Started.."
    pkill ngrok    
    sleep 1s
    ngrok http $PORT > /dev/null &
    sleep 1.5s
    echo "$(curl -s localhost:4040/api/tunnels | jq -r ".tunnels[0].public_url")" > $HOME/.link_watson
    link="$(cat $HOME/.link_watson)"
    curl http://xdroid.net/api/message\?k\=$api_android\&t\=Watson+Active\&c\=IP:$IP+$host+$daatee\&u\=$link 
fi
