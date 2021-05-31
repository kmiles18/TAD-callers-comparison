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

runTopDom(){
BIN=$1
echo "Processing size ${BIN}"

list=($(seq $2 $3))
chromList=($(seq 1 19)) 
chromList[${#chromList[*]}]=X

for li in ${list[@]}; do

data=`printf "HIC%03d" $li`

mkdir -p DOMAINS/${data}
mkdir -p DATA/${data}_TopDom

for chrom in ${chromList[@]}; do

python3 convert_N_N+3.py -i /homeb/LiuKun/zongshu/Rao/${data}/${data}_50k_KR.chr${chrom} -o DATA/${data}_TopDom/${data}_TopDom.chr${chrom} -c chr${chrom} -b ${BIN}
Rscript topdom_run.r -i DATA/${data}_TopDom/${data}_TopDom.chr${chrom} -o DOMAINS/${data}/${data}.chr${chrom}

done
done
}

runTopDom 50000 94 98

chromList=(2L 2R 3L 3R X)
BIN=10000
mkdir -p DOMAINS/Kc167
mkdir -p DATA/Kc167
for chrom in ${chromList[@]}; do
python3 convert_N_N+3.py -i ../Kc167/replicate_10k_KR.chr${chrom} -o DATA/Kc167/replicate_10k_KR.chr${chrom} -c chr${chrom} -b ${BIN}
Rscript topdom_run.r -i DATA/Kc167/replicate_10k_KR.chr${chrom} -o DOMAINS/Kc167/replicate_10k_KR.chr${chrom}
python3 convert_N_N+3.py -i ../Kc167/primary_10k_KR.chr${chrom} -o DATA/Kc167/primary_10k_KR.chr${chrom} -c chr${chrom} -b ${BIN}
Rscript topdom_run.r -i DATA/Kc167/primary_10k_KR.chr${chrom} -o DOMAINS/Kc167/primary_10k_KR.chr${chrom}
done


