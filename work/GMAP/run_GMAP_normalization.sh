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
mkdir -p DOMAINS/normalization
Rscript GMAP_run.r -i /homeb/LiuKun/merged_hic/GM12878_50k_KR.chr6 -o DOMAINS/normalization/GM12878_50k_KR.chr6 -r ${BIN}
Rscript GMAP_run.r -i /homeb/LiuKun/merged_hic/GM12878_50k_VC.chr6 -o DOMAINS/normalization/GM12878_50k_VC.chr6 -r ${BIN}
