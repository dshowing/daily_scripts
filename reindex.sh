#!/bin/bash
# 夜间重启es节点

green=`curl http://192.168.8.80:9200/_cluster/health\?pretty 2>/dev/null| grep green`

while true
do
    curl "http://192.168.8.80:9200/_cluster/health?pretty" 2>/dev/null| grep green >/dev/null
    [[ $? != 0 ]] && {
        echo $(date)'--no health, sleep 10min.'
        sleep 600
    } || {
        echo $(date)'--health, restart es node.'
        sudo systemctl restart elasticsearch
        break
    }
done
