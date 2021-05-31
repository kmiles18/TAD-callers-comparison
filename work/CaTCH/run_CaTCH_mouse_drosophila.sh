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

runCaTCH(){
list=($(seq $1 $2))
chromList=($(seq 1 19)) 
chromList[${#chromList[*]}]=X

for li in ${list[@]}; do

data=`printf "HIC%03d" $li`

mkdir -p DOMAINS/${data}
mkdir -p DATA/${data}_CaTCH

for chrom in ${chromList[@]}; do
python convert_triple_CaTCH.py ../Rao/${data}/${data}_50k_KR.chr${chrom}  DATA/${data}_CaTCH/${data}_50k_KR.chr${chrom} ${chrom}
gzip DATA/${data}_CaTCH/${data}_50k_KR.chr${chrom}

Rscript CaTCH_run.r -i DATA/${data}_CaTCH/${data}_50k_KR.chr${chrom}.gz -o DOMAINS/${data}/${data}_CaTCH.chr${chrom}

done
done
}

runCaTCH 94 98

chromList=(2L 2R 3L 3R X)
mkdir -p DOMAINS/Kc167
mkdir -p DATA/Kc167
for chrom in ${chromList[@]}; do
python convert_triple_CaTCH.py ../Kc167/replicate_10k_KR.chr${chrom}  DATA/Kc167/replicate_10k_KR.chr${chrom} ${chrom}
gzip DATA/Kc167/replicate_10k_KR.chr${chrom}
Rscript CaTCH_run.r -i DATA/Kc167/replicate_10k_KR.chr${chrom}.gz -o DOMAINS/Kc167/replicate_TADbit.chr${chrom}

python convert_triple_CaTCH.py ../Kc167/primary_10k_KR.chr${chrom}  DATA/Kc167/primary_10k_KR.chr${chrom} ${chrom}
gzip DATA/Kc167/primary_10k_KR.chr${chrom}
Rscript CaTCH_run.r -i DATA/Kc167/primary_10k_KR.chr${chrom}.gz -o DOMAINS/Kc167/primary_TADbit.chr${chrom}

done
