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
python3  convert_triple.py /homeb/LiuKun/merged_hic/GM12878_50k_KR.chr6 DOMAINS/normalization/GM12878_50k_KR.chr6
java -jar deDoc.jar  DOMAINS/normalization/GM12878_50k_KR.chr6

python3  convert_triple.py /homeb/LiuKun/merged_hic/GM12878_50k_VC.chr6 DOMAINS/normalization/GM12878_50k_VC.chr6
java -jar deDoc.jar  DOMAINS/normalization/GM12878_50k_VC.chr6
