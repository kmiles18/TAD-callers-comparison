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

runHiCExplorer(){
list=($(seq $1 $2))
BIN=$3
chromList=($(seq 1 19)) 
chromList[${#chromList[*]}]=X

for li in ${list[@]}; do

data=`printf "HIC%03d" $li`

mkdir -p DOMAINS/${data}
mkdir -p DATA/${data}_HiCExplorer

for chrom in ${chromList[@]}; do
para1=`expr $(($BIN*3))`
para2=`expr $(($BIN*6))`
python convert_homer.py -i ../Rao_preprocessed/${data}/${data}_50k_KR.chr${chrom} -o DATA/${data}_HiCExplorer/${data}.chr${chrom} -c chr${chrom} -b ${BIN}
/home/chengzj/mypython/bin/hicConvertFormat -m DATA/${data}_HiCExplorer/${data}.chr${chrom} --inputFormat homer --outputFormat h5 -o DATA/${data}_HiCExplorer/${data}.chr${chrom}.h5
/home/chengzj/mypython/bin/hicFindTADs  -m DATA/${data}_HiCExplorer/${data}.chr${chrom}.h5 --outPrefix DOMAINS/${data}/${data}_HiCExplorer.chr${chrom} --numberOfProcessors 30 --correctForMultipleTesting None --minDepth ${para1} --maxDepth ${para2} --step ${BIN}
done
done
}

runHiCExplorer 94 98 50000

BIN=10000
para1=`expr $(($BIN*3))`
para2=`expr $(($BIN*6))`
echo "Processing size ${BIN}"

chromList=(2L 2R 3L 3R X)
mkdir -p DOMAINS/Kc167
for chrom in ${chromList[@]}; do

python convert_homer.py -i ../Rao_preprocessed/Kc167/replicate_10k_KR.chr${chrom} -o DATA/Kc167_replicate_10k_KR.chr${chrom} -c chr${chrom} -b ${BIN}
/home/chengzj/mypython/bin/hicConvertFormat -m DATA/Kc167_replicate_10k_KR.chr${chrom} --inputFormat homer --outputFormat h5 -o DATA/Kc167_replicate_10k_KR.chr${chrom}.h5
/home/chengzj/mypython/bin/hicFindTADs  -m DATA/Kc167_replicate_10k_KR.chr${chrom}.h5 --outPrefix DOMAINS/Kc167/replicate_HiCExplorer.chr${chrom} --numberOfProcessors 30 --correctForMultipleTesting None --minDepth ${para1} --maxDepth ${para2} --step ${BIN}

python convert_homer.py -i ../Rao_preprocessed/Kc167/primary_10k_KR.chr${chrom} -o DATA/Kc167_primary_10k_KR.chr${chrom} -c chr${chrom} -b ${BIN}
/home/chengzj/mypython/bin/hicConvertFormat -m DATA/Kc167_primary_10k_KR.chr${chrom} --inputFormat homer --outputFormat h5 -o DATA/Kc167_primary_10k_KR.chr${chrom}.h5
/home/chengzj/mypython/bin/hicFindTADs  -m DATA/Kc167_primary_10k_KR.chr${chrom}.h5 --outPrefix DOMAINS/Kc167/primary_HiCExplorer.chr${chrom} --numberOfProcessors 30 --correctForMultipleTesting None --minDepth ${para1} --maxDepth ${para2} --step ${BIN}

done

