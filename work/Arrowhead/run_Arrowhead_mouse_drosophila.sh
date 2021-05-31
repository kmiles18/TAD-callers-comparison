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
java -jar juicer_tools.jar arrowhead ../Rao_preprocessed/GSM2358971_Kc167primary.hic DOMAINS/Kc167/primary_arrowhead.chr${chrom} -c chr${chrom} -r ${BIN} -k KR --ignore_sparsity
java -jar juicer_tools.jar arrowhead ../Rao_preprocessed/GSM2358972_Kc167replicate.hic DOMAINS/Kc167/replicate_arrowhead.chr${chrom} -c chr${chrom} -r ${BIN} -k KR --ignore_sparsity
done


runArrowhead(){
BIN=$1
echo "Processing size ${BIN}"

list=($(seq $2 $3))
chromList=($(seq 1 19)) 
chromList[${#chromList[*]}]=X

for li in ${list[@]}; do

j=$((1551546+li-1))
previous_name="GSM"$j
latter_name=`printf "HIC%03d" $li`
dataset=${previous_name}_${latter_name}.hic
#echo $dataset

mkdir -p DOMAINS/${latter_name}

for chrom in ${chromList[@]}; do
java -jar juicer_tools.jar arrowhead ../Rao_preprocessed/${dataset} DOMAINS/${latter_name}/${latter_name}_arrowhead.chr${chrom} -c chr${chrom} -r ${BIN} -k KR --ignore_sparsity
#java -jar juicer_tools.jar dump observed KR /home/chengzj/Rao_preprocessed/${dataset} chr${chrom} chr${chrom} BP 50000 ${latter_name}/${latter_name}_50k_KR.chr${chrom}_tmp -d
#python remove_nan.py ${latter_name}/${latter_name}_50k_KR.chr${chrom}_tmp ${latter_name}/${latter_name}_50k_KR.chr${chrom}

done
done
}
runArrowhead 50000 94 98



