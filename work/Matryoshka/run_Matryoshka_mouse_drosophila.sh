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

runMatryoshka(){
BIN=$1
echo "Processing size ${BIN}"

list=($(seq $2 $3))
chromList=($(seq 1 19)) 
chromList[${#chromList[*]}]=X

for li in ${list[@]}; do

data=`printf "HIC%03d" $li`

mkdir -p DOMAINS/${data}
mkdir -p DATA/${data}_Matryoshka

for chrom in ${chromList[@]}; do
python3 convert_N_N+3.py -i ../Rao/${data}/${data}_50k_KR.chr${chrom} -o DATA/${data}_Matryoshka/${data}_50k_KR.chr${chrom} -c chr${chrom} -b ${BIN}
gzip DATA/${data}_Matryoshka/${data}_50k_KR.chr${chrom}
matryoshka-master/build/src/matryoshka -r ${BIN} -c ${chrom} -i DATA/${data}_Matryoshka/${data}_50k_KR.chr${chrom}.gz -g 0.5 -o DOMAINS/${data}/${data}_Matryoshka.chr${chrom}

done
done
}
runMatryoshka 50000 94 98

BIN=10000
chromList=(2L 2R 3L 3R X)
mkdir -p DOMAINS/Kc167
mkdir -p DATA/Kc167
for chrom in ${chromList[@]}; do

python3 convert_N_N+3.py -i ../Kc167/replicate_10k_KR.chr${chrom} -o DATA/Kc167/replicate_10k_KR.chr${chrom} -c chr${chrom} -b ${BIN}
gzip DATA/Kc167/replicate_10k_KR.chr${chrom}
matryoshka-master/build/src/matryoshka -r ${BIN} -c ${chrom} -i DATA/Kc167/replicate_10k_KR.chr${chrom}.gz -g 0.5 -o DOMAINS/Kc167/replicate_10k_KR.chr${chrom}

python3 convert_N_N+3.py -i ../Kc167/primary_10k_KR.chr${chrom} -o DATA/Kc167/primary_10k_KR.chr${chrom} -c chr${chrom} -b ${BIN}
gzip DATA/Kc167/primary_10k_KR.chr${chrom}
matryoshka-master/build/src/matryoshka -r ${BIN} -c ${chrom} -i DATA/Kc167/primary_10k_KR.chr${chrom}.gz -g 0.5 -o DOMAINS/Kc167/primary_10k_KR.chr${chrom}


done

