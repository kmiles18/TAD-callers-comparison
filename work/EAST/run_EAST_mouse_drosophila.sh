#!/bin/bash

checkMakeDirectory(){
        echo -e "checking directory: $1"
        if [ ! -e "$1" ]; then
                echo -e "\tmakedir $1"
                mkdir -p "$1"
        fi
}
checkMakeDirectory DOMAINS

BIN=10000
echo "Processing size ${BIN}"

chromList=(2L 2R 3L 3R X)
mkdir -p DOMAINS/Kc167
for chrom in ${chromList[@]}; do
python3 EAST2.py ../Rao_preprocessed/Kc167/replicate_10k_KR.chr${chrom}  DOMAINS/Kc167/replicate_EAST.chr${chrom} ${BIN}
python3 EAST2.py ../Rao_preprocessed/Kc167/primary_10k_KR.chr${chrom}  DOMAINS/Kc167/primary_EAST.chr${chrom} ${BIN}
done

runEAST(){
list=($(seq $1 $2))
BIN=$3
chromList=($(seq 1 19)) 
chromList[${#chromList[*]}]=X

for li in ${list[@]}; do

data=`printf "HIC%03d" $li`

mkdir -p DOMAINS/${data}
mkdir -p DATA/${data}_CaTCH

for chrom in ${chromList[@]}; do
python3 EAST2.py ../Rao_preprocessed/${data}/${data}_50k_KR.chr${chrom}  DOMAINS/${data}/${data}_EAST.chr${chrom} ${BIN}

done
done
}

runEAST 94 98 50000

