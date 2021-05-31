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
square=2500000
span=1000000

mkdir -p DOMAINS/normalization
mkdir -p DATA/normalization_IS

python convert_insulation.py -i /homeb/LiuKun/merged_hic/GM12878_50k_KR.chr6 -o DATA/normalization_IS/GM12878_50k_KR_chr6.matrix -c chr6 -b ${BIN}
perl scripts/matrix2insulation.pl -i  DATA/normalization_IS/GM12878_50k_KR_chr6.matrix -is ${square} -ids ${span} -im mean -bmoe 3 -nt 0.1	
mv GM12878_50k_KR_chr6.* DOMAINS/normalization/

python convert_insulation.py -i /homeb/LiuKun/merged_hic/GM12878_50k_VC.chr6 -o DATA/normalization_IS/GM12878_50k_VC_chr6.matrix -c chr6 -b ${BIN}
perl scripts/matrix2insulation.pl -i  DATA/normalization_IS/GM12878_50k_VC_chr6.matrix -is ${square} -ids ${span} -im mean -bmoe 3 -nt 0.1
mv GM12878_50k_VC_chr6.* DOMAINS/normalization/

