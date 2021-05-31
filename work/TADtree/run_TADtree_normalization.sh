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

mkdir -p DOMAINS/normalization_KR
mkdir -p DOMAINS/normalization_VC
nohup python TADtree.py control/GM12878_50k_KR.chr6.txt >LOG/GM12878_50k_KR.chr6.log 2>&1 &
nohup python TADtree.py control/GM12878_50k_VC.chr6.txt >LOG/GM12878_50k_VC.chr6.log 2>&1 &
