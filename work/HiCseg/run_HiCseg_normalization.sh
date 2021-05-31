#!/bin/bash 

checkMakeDirectory(){
        echo -e "checking directory: $1"
        if [ ! -e "$1" ]; then
                echo -e "\tmakedir $1"
                mkdir -p "$1"
        fi
}
checkMakeDirectory DOMAINS

mkdir -p DOMAINS/normalization
Rscript hicseg_run_s.r -i /homeb/LiuKun/merged_hic/GM12878_50k_KR.chr6 -o DOMAINS/normalization/GM12878_50k_KR.chr6
Rscript hicseg_run_s.r -i /homeb/LiuKun/merged_hic/GM12878_50k_VC.chr6 -o DOMAINS/normalization/GM12878_50k_VC.chr6

