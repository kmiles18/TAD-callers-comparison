#!/bin/bash

checkMakeDirectory(){
        echo -e "checking directory: $1"
        if [ ! -e "$1" ]; then
                echo -e "\tmakedir $1"
                mkdir -p "$1"
        fi
}
checkMakeDirectory DOMAINS
checkMakeDirectory LOG

data=(HIC065 HIC066 HIC067 HIC080 HIC081 HIC082 HIC094 HIC095 HIC096 HIC097 HIC098)
for dd in ${data[@]}; do
mkdir -p DOMAINS/${dd}
nohup python2 TADtree.py control/${dd}.txt >LOG/${dd}.log 2>&1 &
done


mkdir -p DOMAINS/Kc167_primary
nohup python2 TADtree.py control/Kc167_primary.txt >LOG/Kc167_primary.log 2>&1 &

mkdir -p DOMAINS/Kc167_replicate
nohup python2 TADtree.py control/Kc167_replicate.txt >LOG/Kc167_replicate.log 2>&1 &
