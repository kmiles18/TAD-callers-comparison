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

runIS(){
BIN=$1
square=$2
span=$3
echo "Processing size ${BIN}"

list=($(seq $4 $5))
chromList=($(seq 1 19)) 
chromList[${#chromList[*]}]=X

for li in ${list[@]}; do

data=`printf "HIC%03d" $li`

mkdir -p DOMAINS/${data}
mkdir -p DATA/${data}_IS

for chrom in ${chromList[@]}; do

python convert_insulation.py -i /homeb/LiuKun/zongshu/Rao/${data}/${data}_50k_KR.chr${chrom} -o DATA/${data}_IS/${data}_IS_chr${chrom}.matrix -c chr${chrom} -b ${BIN}
perl scripts/matrix2insulation.pl -i DATA/${data}_IS/${data}_IS_chr${chrom}.matrix -is ${square} -ids ${span} -im mean -bmoe 3 -nt 0.1	
mv ${data}_IS_chr${chrom}.* DOMAINS/${data}/

done
done
}

runIS 50000 2500000 1000000 94 98

BIN=10000
square=500000
span=200000
chromList=(2L 2R 3L 3R X)
mkdir -p DOMAINS/Kc167
mkdir -p DATA/Kc167
for chrom in ${chromList[@]}; do

python convert_insulation.py -i ../Kc167/replicate_10k_KR.chr${chrom} -o DATA/Kc167/replicate_10k_KR_chr${chrom}.matrix -c chr${chrom} -b ${BIN}
perl scripts/matrix2insulation.pl -i DATA/Kc167/replicate_10k_KR_chr${chrom}.matrix -is ${square} -ids ${span} -im mean -bmoe 3 -nt 0.1
mv replicate_10k_KR_chr${chrom}.* DOMAINS/Kc167/

python convert_insulation.py -i ../Kc167/primary_10k_KR.chr${chrom} -o DATA/Kc167/primary_10k_KR_chr${chrom}.matrix -c chr${chrom} -b ${BIN}
perl scripts/matrix2insulation.pl -i DATA/Kc167/primary_10k_KR_chr${chrom}.matrix -is ${square} -ids ${span} -im mean -bmoe 3 -nt 0.1
mv primary_10k_KR_chr${chrom}.* DOMAINS/Kc167/

done

