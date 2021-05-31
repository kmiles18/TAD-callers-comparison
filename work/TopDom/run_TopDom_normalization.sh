#!/bin/bash 

checkMakeDirectory(){
        echo -e "checking directory: $1"
        if [ ! -e "$1" ]; then
                echo -e "\tmakedir $1"
                mkdir -p "$1"
        fi
}
checkMakeDirectory DOMAINS
checkMakeDirectory DATA

BIN=50000

mkdir -p DOMAINS/normalization
mkdir -p DATA/normalization_TopDom

python3 convert_N_N+3.py -i /homeb/LiuKun/merged_hic/GM12878_50k_KR.chr6 -o DATA/normalization_TopDom/GM12878_50k_KR.chr6 -c chr6 -b ${BIN}
Rscript topdom_run.r -i DATA/normalization_TopDom/GM12878_50k_KR.chr6 -o DOMAINS/normalization/GM12878_50k_KR.chr6

python3 convert_N_N+3.py -i /homeb/LiuKun/merged_hic/GM12878_50k_VC.chr6 -o DATA/normalization_TopDom/GM12878_50k_VC.chr6 -c chr6 -b ${BIN}
Rscript topdom_run.r -i DATA/normalization_TopDom/GM12878_50k_VC.chr6 -o DOMAINS/normalization/GM12878_50k_VC.chr6
