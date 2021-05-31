#!/bin/bash 

checkMakeDirectory(){
        echo -e "checking directory: $1"
        if [ ! -e "$1" ]; then
                echo -e "\tmakedir $1"
                mkdir -p "$1"
        fi
}
checkMakeDirectory DOMAINS

runICFinder(){
BIN=$1
echo "Processing size ${BIN}"

list=($(seq $2 $3))
chromList=($(seq 1 19)) 
chromList[${#chromList[*]}]=X

for li in ${list[@]}; do

data=`printf "HIC%03d" $li`

mkdir -p DOMAINS/${data}

for chrom in ${chromList[@]}; do

matlab -nodisplay -r  "inputfile='/homeb/LiuKun/zongshu/Rao/${data}/${data}_50k_KR.chr${chrom}';outputfile='DOMAINS/${data}/';filename='${data}_chr${chrom}';",< run_IC_Finder.m

done
done
}

runICFinder 50000 94 98

chromList=(2L 2R 3L 3R X)
mkdir -p DOMAINS/Kc167
for chrom in ${chromList[@]}; do
matlab -nodisplay -r  "inputfile='/homeb/LiuKun/zongshu/Kc167/replicate_10k_KR.chr${chrom}';outputfile='DOMAINS/Kc167/';filename='replicate_10k_KR_chr${chrom}';",< run_IC_Finder.m
matlab -nodisplay -r  "inputfile='/homeb/LiuKun/zongshu/Kc167/primary_10k_KR.chr${chrom}';outputfile='DOMAINS/Kc167/';filename='primary_10k_KR_chr${chrom}';",< run_IC_Finder.m
done
