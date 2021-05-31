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

BIN=50000
mkdir -p DOMAINS/normalization
mkdir -p DATA/normalization_HiCExplorer
para1=`expr $(($BIN*3))`
para2=`expr $(($BIN*6))`
python convert_homer.py -i GM12878_50k_KR.chr6 -o DATA/normalization_HiCExplorer/GM12878_50k_KR.chr6 -c chr6 -b ${BIN}
/home/chengzj/mypython/bin/hicConvertFormat -m DATA/normalization_HiCExplorer/GM12878_50k_KR.chr6 --inputFormat homer --outputFormat h5 -o DATA/normalization_HiCExplorer/GM12878_50k_KR.chr6.h5
/home/chengzj/mypython/bin/hicFindTADs  -m DATA/normalization_HiCExplorer/GM12878_50k_KR.chr6.h5 --outPrefix DOMAINS/normalization/GM12878_50k_KR.chr6 --numberOfProcessors 30 --correctForMultipleTesting None --minDepth ${para1} --maxDepth ${para2} --step ${BIN}


python convert_homer.py -i GM12878_50k_VC.chr6 -o DATA/normalization_HiCExplorer/GM12878_50k_VC.chr6 -c chr6 -b ${BIN}
/home/chengzj/mypython/bin/hicConvertFormat -m DATA/normalization_HiCExplorer/GM12878_50k_VC.chr6 --inputFormat homer --outputFormat h5 -o DATA/normalization_HiCExplorer/GM12878_50k_VC.chr6.h5
/home/chengzj/mypython/bin/hicFindTADs  -m DATA/normalization_HiCExplorer/GM12878_50k_VC.chr6.h5 --outPrefix DOMAINS/normalization/GM12878_50k_VC.chr6 --numberOfProcessors 30 --correctForMultipleTesting None --minDepth ${para1} --maxDepth ${para2} --step ${BIN}
