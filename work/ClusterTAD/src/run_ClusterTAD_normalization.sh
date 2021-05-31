#!/bin/bash 

checkMakeDirectory(){
        echo -e "checking directory: $1"
        if [ ! -e "$1" ]; then
                echo -e "\tmakedir $1"
                mkdir -p "$1"
        fi
}
checkMakeDirectory ../DOMAINS

BIN=50000
max_size=750000
echo "Processing size ${BIN}"

mkdir -p ../DOMAINS/normalization_KR
mkdir -p ../DOMAINS/normalization_VC
matlab -nodisplay -r  "filepath='/homeb/LiuKun/merged_hic/';name='GM12878_50k_KR.chr6';Res=${BIN};chromo='chr6';outputfolder_name='../DOMAINS/normalization_KR';Max_TADsize=${max_size};",< ClusterTAD_main.m
matlab -nodisplay -r  "filepath='/homeb/LiuKun/merged_hic/';name='GM12878_50k_VC.chr6';Res=${BIN};chromo='chr6';outputfolder_name='../DOMAINS/normalization_VC';Max_TADsize=${max_size};",< ClusterTAD_main.m
