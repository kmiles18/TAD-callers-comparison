#!/bin/bash 

checkMakeDirectory(){
        echo -e "checking directory: $1"
        if [ ! -e "$1" ]; then
                echo -e "\tmakedir $1"
                mkdir -p "$1"
        fi
}
checkMakeDirectory ../DOMAINS

mkdir -p ../DOMAINS/normalization
matlab -nodisplay -r  "file_in='/homeb/LiuKun/merged_hic/GM12878_50k_KR.chr6';file_out='../DOMAINS/normalization/GM12878_50k_KR.chr6'",<Spectral_run.m
matlab -nodisplay -r  "file_in='/homeb/LiuKun/merged_hic/GM12878_50k_VC.chr6';file_out='../DOMAINS/normalization/GM12878_50k_VC.chr6'",<Spectral_run.m
