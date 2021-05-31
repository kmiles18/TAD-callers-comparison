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

mkdir -p DOMAINS/normalization
mkdir -p DATA/normalization_CaTCH

python convert_triple_CaTCH.py /homeb/LiuKun/merged_hic/GM12878_50k_KR.chr6  DATA/normalization_CaTCH/GM12878_50k_KR.chr6 6
gzip DATA/normalization_CaTCH/GM12878_50k_KR.chr6
Rscript CaTCH_run.r -i DATA/normalization_CaTCH/GM12878_50k_KR.chr6.gz -o DOMAINS/normalization/GM12878_50k_KR.chr6

python convert_triple_CaTCH.py /homeb/LiuKun/merged_hic/GM12878_50k_VC.chr6  DATA/normalization_CaTCH/GM12878_50k_VC.chr6 6
gzip DATA/normalization_CaTCH/GM12878_50k_VC.chr6
Rscript CaTCH_run.r -i DATA/normalization_CaTCH/GM12878_50k_VC.chr6.gz -o DOMAINS/normalization/GM12878_50k_VC.chr6

