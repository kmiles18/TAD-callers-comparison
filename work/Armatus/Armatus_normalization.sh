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
echo "Processing size ${BIN}"

mkdir -p DOMAINS/normalization
mkdir -p DATA/normalization_armatus

cp /homeb/LiuKun/merged_hic/GM12878_50k_KR.chr6  DATA/normalization_armatus
gzip DATA/normalization_armatus/GM12878_50k_KR.chr6
armatus-2.2/src/armatus -m -r ${BIN} -c 6 -i DATA/normalization_armatus/GM12878_50k_KR.chr6.gz -g 0.5 -o DOMAINS/normalization/GM12878_50k_KR.chr6

cp /homeb/LiuKun/merged_hic/GM12878_50k_VC.chr6  DATA/normalization_armatus
gzip DATA/normalization_armatus/GM12878_50k_VC.chr6
armatus-2.2/src/armatus -m -r ${BIN} -c 6 -i DATA/normalization_armatus/GM12878_50k_VC.chr6.gz -g 0.5 -o DOMAINS/normalization/GM12878_50k_VC.chr6

