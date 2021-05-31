#!/bin/bash 

checkMakeDirectory(){
        echo -e "checking directory: $1"
        if [ ! -e "$1" ]; then
                echo -e "\tmakedir $1"
                mkdir -p "$1"
        fi
}
checkMakeDirectory ../DOMAINS

runClusterTAD(){
BIN=$1
max_size=$2
echo "Processing size ${BIN}"

list=($(seq $3 $4))
chromList=($(seq 1 19)) 
chromList[${#chromList[*]}]=X

for li in ${list[@]}; do

data=`printf "HIC%03d" $li`

mkdir -p ../DOMAINS/${data}

for chrom in ${chromList[@]}; do

matlab -nodisplay -r  "filepath='/homeb/LiuKun/zongshu/Rao/${data}/';name='${data}_50k_KR.chr${chrom}';Res=${BIN};chromo='chr${chrom}';outputfolder_name='../DOMAINS/${data}';Max_TADsize=${max_size};",< ClusterTAD_main.m

done
done
}

runClusterTAD 50000 750000 94 98

BIN=10000
echo "Processing size ${BIN}"

chromList=(2L 2R 3L 3R X)
mkdir -p ../DOMAINS/Kc167
for chrom in ${chromList[@]}; do
matlab -nodisplay -r  "filepath='/homeb/LiuKun/zongshu/Kc167/';name='replicate_10k_KR.chr${chrom}';Res=${BIN};chromo='chr${chrom}';outputfolder_name='../DOMAINS/Kc167';Max_TADsize=${max_size};",< ClusterTAD_main.m
matlab -nodisplay -r  "filepath='/homeb/LiuKun/zongshu/Kc167/';name='primary_10k_KR.chr${chrom}';Res=${BIN};chromo='chr${chrom}';outputfolder_name='../DOMAINS/Kc167';Max_TADsize=${max_size};",< ClusterTAD_main.m
done
