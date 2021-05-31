#!/bin/bash

checkMakeDirectory(){
        echo -e "checking directory: $1"
        if [ ! -e "$1" ]; then
                echo -e "\tmakedir $1"
                mkdir -p "$1"
        fi
}
# create subdirectories
checkMakeDirectory DI
checkMakeDirectory HMM
checkMakeDirectory DOMAINS
checkMakeDirectory LOG
checkMakeDirectory DATA

runDI(){
perl_path=./perl_scripts
fai_path=../hg19.fai
BIN=$1
WINDOW=$2
echo "Processing size ${BIN}"

mkdir -p DATA/normalization_DI
mkdir -p HMM/normalization_$3

#convert raw observed symmetric matrix to N*(N+3) matrix

python ../convert_N_N+3.py -i /homeb/LiuKun/merged_hic/GM12878_50k_$3.chr6 -o DATA/normalization_DI/GM12878_50k_$3.chr6 -c chr6 -b ${BIN}

## Compute Directionality Index for every chromosome
echo "Computing Directionality Index chr6"
## one .matrix file for each chromosome. contains the binned genome 
perl ${perl_path}/DI_from_matrix.pl DATA/normalization_DI/GM12878_50k_$3.chr6 ${BIN} ${WINDOW} ${fai_path}> DI/GM12878_50k_chr6_$3.DI

## Run HMM 
echo "Running HMM for chr6"
file1="DI/GM12878_50k_chr6_$3.DI"
file2="DI/GM12878_50k_chr6_$3.out"
nice matlab -nodisplay -r  "inputfile='${file1}',outputfile='${file2}'",< HMM_calls.m &> LOG/GM12878_50k_chr6_$3.log

## postprocessing:: Clean up and generate 7 col
echo "Post processing files"
perl ${perl_path}/file_ends_cleaner.pl DI/GM12878_50k_chr6_$3.out DI/GM12878_50k_chr6_$3.DI| perl ${perl_path}/converter_7col.pl > HMM/GM12878_50k_chr6_$3.hmm

## Separate file into chromosome separated files
echo "Post processing files: Breakup files into chromosome separated files"
mkdir -p HMM/normalization_$3/Chrom_Sep
awk -v Folder=HMM/normalization_$3 -f ../Separate_Dixon_7col_by_Chromosome.awk HMM/GM12878_50k_chr6_$3.hmm

## for each chromosome file generate the final domains
#start chromosome index loop
echo "chr6"
echo "Post processing files: Generating Domains"
perl ${perl_path}/hmm_probablity_correcter.pl HMM/normalization_$3/Chrom_Sep/chr6.sep 2 0.99 ${BIN} | perl ${perl_path}/hmm-state_caller.pl ${fai_path} chr6 | perl ${perl_path}/hmm-state_domains.pl > DOMAINS/GM12878_50k_chr6_$3.domain

}

runDI 50000 2500000 KR
runDI 50000 2500000 VC


