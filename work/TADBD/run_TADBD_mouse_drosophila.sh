#!/bin/bash 

checkMakeDirectory(){
        echo -e "checking directory: $1"
        if [ ! -e "$1" ]; then
                echo -e "\tmakedir $1"
                mkdir -p "$1"
        fi
}
checkMakeDirectory DOMAINS

runTADBD(){
list=($(seq $1 $2))
chromList=($(seq 1 19)) 
chromList[${#chromList[*]}]=X

for li in ${list[@]}; do

data=`printf "HIC%03d" $li`

mkdir -p DOMAINS/${data}

for chrom in ${chromList[@]}; do
/home/LiuKun/R-3.6.2/bin/Rscript TADBD_run.r -i ../Rao/${data}/${data}_50k_KR.chr${chrom} -o DOMAINS/${data}/${data}_TADBD.chr${chrom}
done
done
}

runTADBD 94 98

chromList=(2L 2R 3L 3R X)
mkdir -p DOMAINS/Kc167
for chrom in ${chromList[@]}; do
/home/LiuKun/R-3.6.2/bin/Rscript TADBD_run.r -i  ../Kc167/replicate_10k_KR.chr${chrom} -o DOMAINS/Kc167/replicate_10k_KR.chr${chrom}
/home/LiuKun/R-3.6.2/bin/Rscript TADBD_run.r -i ../Kc167/primary_10k_KR.chr${chrom} -o DOMAINS/Kc167/primary_10k_KR.chr${chrom}
done

