#!/bin/bash 

checkMakeDirectory(){
        echo -e "checking directory: $1"
        if [ ! -e "$1" ]; then
                echo -e "\tmakedir $1"
                mkdir -p "$1"
        fi
}
checkMakeDirectory DOMAINS

BIN=50000
echo "Processing size ${BIN}"
mkdir -p DOMAINS/normalization
python3 run_MSTD.py /homeb/LiuKun/merged_hic/GM12878_50k_KR.chr6 DOMAINS/normalization/GM12878_50k_KR.chr6
python3 run_MSTD.py /homeb/LiuKun/merged_hic/GM12878_50k_VC.chr6 DOMAINS/normalization/GM12878_50k_VC.chr6

