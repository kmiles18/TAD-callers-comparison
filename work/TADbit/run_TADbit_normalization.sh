#!/bin/bash 

checkMakeDirectory(){
        echo -e "checking directory: $1"
        if [ ! -e "$1" ]; then
                echo -e "\tmakedir $1"
                mkdir -p "$1"
        fi
}
checkMakeDirectory DOMAINS

mkdir -p DOMAINS/normalization
/home/chengzj/liukun/miniconda2/bin/python TADbit.py ../Rao_preprocessed/GM12878_50k_KR.chr6 DOMAINS/normalization/GM12878_50k_KR.chr6
/home/chengzj/liukun/miniconda2/bin/python TADbit.py ../Rao_preprocessed/GM12878_50k_VC.chr6 DOMAINS/normalization/GM12878_50k_VC.chr6

