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
/homeb/LiuKun/bachelor_thesis/OnTAD/OnTAD-master/OnTAD GM12878_50k_KR.chr6 -o DOMAINS/normalization/GM12878_50k_KR.chr6
/homeb/LiuKun/bachelor_thesis/OnTAD/OnTAD-master/OnTAD GM12878_50k_VC.chr6 -o DOMAINS/normalization/GM12878_50k_VC.chr6

