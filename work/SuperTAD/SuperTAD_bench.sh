#!/bin/bash 

checkMakeDirectory(){
        echo -e "checking directory: $1"
        if [ ! -e "$1" ]; then
                echo -e "\tmakedir $1"
                mkdir -p "$1"
        fi
}
checkMakeDirectory DOMAINS

dataset=bench
mkdir -p DOMAINS/${dataset}

#chromosome index array
chromList=($(seq 1 100)) 

#start chromosome index loop
for chrom in ${chromList[@]}; do
cp  /homeb/LiuKun/zongshu/benchmarks/maptest_${chrom}.txt DOMAINS/${dataset}
/homeb/LiuKun/major_revision/SuperTAD-1.1/build/SuperTAD binary DOMAINS/${dataset}/maptest_${chrom}.txt --chrom1 chr${chrom} -r 1 --chrom1-start 0 -v
done
