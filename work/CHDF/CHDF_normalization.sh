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

rows=$(cat /homeb/LiuKun/merged_hic/GM12878_50k_KR.chr6 | wc -l)
let maxn=rows/10
./CHDF /homeb/LiuKun/merged_hic/GM12878_50k_KR.chr6 DOMAINS/normalization/GM12878_50k_KR.chr6  ${rows} ${rows} ${maxn}

rows=$(cat /homeb/LiuKun/merged_hic/GM12878_50k_VC.chr6 | wc -l)
let maxn=rows/10
./CHDF /homeb/LiuKun/merged_hic/GM12878_50k_VC.chr6 DOMAINS/normalization/GM12878_50k_VC.chr6  ${rows} ${rows} ${maxn}

