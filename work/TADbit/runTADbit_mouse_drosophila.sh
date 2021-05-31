#!/bin/bash 

checkMakeDirectory(){
        echo -e "checking directory: $1"
        if [ ! -e "$1" ]; then
                echo -e "\tmakedir $1"
                mkdir -p "$1"
        fi
}
checkMakeDirectory DOMAINS

runTADbit(){
BIN=$1
echo "Processing size ${BIN}"

list=($(seq $2 $3))
chromList=($(seq 1 19)) 
chromList[${#chromList[*]}]=X

for li in ${list[@]}; do

data=`printf "HIC%03d" $li`

mkdir -p DOMAINS/${data}

for chrom in ${chromList[@]}; do

/home/chengzj/liukun/miniconda2/bin/python TADbit.py ../Rao_preprocessed/${data}/${data}_50k_KR.chr${chrom} DOMAINS/${data}/${data}.chr${chrom}

done
done
}

runTADbit 50000 94 98

BIN=10000
echo "Processing size ${BIN}"

chromList=(2L 2R 3L 3R X)
mkdir -p DOMAINS/Kc167
for chrom in ${chromList[@]}; do
/home/chengzj/liukun/miniconda2/bin/python TADbit.py ../Rao_preprocessed/Kc167/replicate_10k_KR.chr${chrom} DOMAINS/Kc167/replicate_TADbit.chr${chrom}
/home/chengzj/liukun/miniconda2/bin/python TADbit.py ../Rao_preprocessed/Kc167/primary_10k_KR.chr${chrom} DOMAINS/Kc167/primary_TADbit.chr${chrom} 
done


