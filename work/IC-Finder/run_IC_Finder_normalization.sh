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
matlab -nodisplay -r  "inputfile='/homeb/LiuKun/merged_hic/GM12878_50k_KR.chr6';outputfile='DOMAINS/normalization/';filename='GM12878_50k_KR.chr6';",< run_IC_Finder.m
matlab -nodisplay -r  "inputfile='/homeb/LiuKun/merged_hic/GM12878_50k_VC.chr6';outputfile='DOMAINS/normalization/';filename='GM12878_50k_VC.chr6';",< run_IC_Finder.m

