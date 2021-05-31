#!/bin/bash 

checkMakeDirectory(){
        echo -e "checking directory: $1"
        if [ ! -e "$1" ]; then
                echo -e "\tmakedir $1"
                mkdir -p "$1"
        fi
}
checkMakeDirectory ../DOMAINS

runSpectral(){
list=($(seq $1 $2))
chromList=($(seq 1 19)) 
chromList[${#chromList[*]}]=X

for li in ${list[@]}; do

data=`printf "HIC%03d" $li`

mkdir -p ../DOMAINS/${data}

for chrom in ${chromList[@]}; do
matlab -nodisplay -r  "file_in='../../Rao/${data}/${data}_50k_KR.chr${chrom}';file_out='../DOMAINS/${data}/${data}_Spectral.chr${chrom}'",<Spectral_run.m
done
done
}

runSpectral 94 98

chromList=(2L 2R 3L 3R X)
mkdir -p ../DOMAINS/Kc167
for chrom in ${chromList[@]}; do
matlab -nodisplay -r  "file_in='../../Kc167/replicate_10k_KR.chr${chrom}';file_out='../DOMAINS/Kc167/replicate_10k_KR.chr${chrom}'",<Spectral_run.m
matlab -nodisplay -r  "file_in='../../Kc167/primary_10k_KR.chr${chrom}';file_out='../DOMAINS/Kc167/primary_10k_KR.chr${chrom}'",<Spectral_run.m
done

