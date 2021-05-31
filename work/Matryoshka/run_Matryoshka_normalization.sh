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
mkdir -p DATA/normalization_Matryoshka

python3 convert_N_N+3.py -i /homeb/LiuKun/merged_hic/GM12878_50k_KR.chr6 -o DATA/normalization_Matryoshka/GM12878_50k_KR.chr6 -c chr6 -b ${BIN}
gzip DATA/normalization_Matryoshka/GM12878_50k_KR.chr6
matryoshka-master/build/src/matryoshka -r ${BIN} -c 6 -i DATA/normalization_Matryoshka/GM12878_50k_KR.chr6.gz -g 0.5 -o DOMAINS/normalization/GM12878_50k_KR.chr6

python3 convert_N_N+3.py -i /homeb/LiuKun/merged_hic/GM12878_50k_VC.chr6 -o DATA/normalization_Matryoshka/GM12878_50k_VC.chr6 -c chr6 -b ${BIN}
gzip DATA/normalization_Matryoshka/GM12878_50k_VC.chr6
matryoshka-master/build/src/matryoshka -r ${BIN} -c 6 -i DATA/normalization_Matryoshka/GM12878_50k_VC.chr6.gz -g 0.5 -o DOMAINS/normalization/GM12878_50k_VC.chr6
