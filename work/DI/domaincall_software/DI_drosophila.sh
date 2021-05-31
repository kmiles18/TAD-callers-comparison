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
fai_path=../dm3.chrom.sizes
BIN=$1
WINDOW=$2
echo "Processing size ${BIN}"

chromList=($(seq 1 5)) 
chroms=(chr2L chr2R chr3L chr3R chrX)

data=$3

mkdir -p DATA/Kc167_${data}_DI
mkdir -p HMM/Kc167_${data}


#start chromosome index loop
for chrom in ${chromList[@]} 
do
#convert raw observed symmetric matrix to N*(N+3) matrix

python ../convert_N_N+3.py -i /homeb/LiuKun/zongshu/Kc167/${data}_10k_KR.${chroms[$chrom-1]} -o DATA/Kc167_${data}_DI/${data}_DI.chr${chrom} -c chr${chrom} -b ${BIN}

## Compute Directionality Index for every chromosome
echo "Computing Directionality Index chr${chrom}"
## one .matrix file for each chromosome. contains the binned genome 
perl ${perl_path}/DI_from_matrix.pl DATA/Kc167_${data}_DI/${data}_DI.chr${chrom} ${BIN} ${WINDOW} ${fai_path}> DI/Kc167_${data}_chr${chrom}.DI

done


## concatenate all the files together

echo "Concatenating all files together. "
cat /dev/null > DI/${data}.DI
for chrom in ${chromList[@]}; do
cat DI/Kc167_${data}_chr${chrom}.DI >> DI/Kc167_${data}.DI
done


## Run HMM 
echo "Running HMM for chr${chrom}"
file1="DI/Kc167_${data}.DI"
file2="DI/Kc167_${data}.out"
nice matlab -nodisplay -r  "inputfile='${file1}',outputfile='${file2}'",< HMM_calls.m &> LOG/hmm_Kc167_${data}.log

## postprocessing:: Clean up and generate 7 col
echo "Post processing files"
perl ${perl_path}/file_ends_cleaner.pl DI/Kc167_${data}.out DI/Kc167_${data}.DI| perl ${perl_path}/converter_7col.pl > HMM/hmm_Kc167_${data}.hmm

## Separate file into chromosome separated files
echo "Post processing files: Breakup files into chromosome separated files"
mkdir -p HMM/Kc167_${data}/Chrom_Sep
awk -v Folder=HMM/Kc167_${data} -f ../Separate_Dixon_7col_by_Chromosome.awk HMM/hmm_Kc167_${data}.hmm

## for each chromosome file generate the final domains
#start chromosome index loop

for chrom in ${chromList[@]}; do

echo "chr${chrom}"
echo "Post processing files: Generating Domains"
perl ${perl_path}/hmm_probablity_correcter.pl HMM/Kc167_${data}/Chrom_Sep/chr${chrom}.sep 2 0.99 ${BIN} | perl ${perl_path}/hmm-state_caller.pl ${fai_path} chr${chrom} | perl ${perl_path}/hmm-state_domains.pl > DOMAINS/Kc167_${data}_chr${chrom}.domain

done
}

runDI 10000 500000 primary
runDI 10000 500000 replicate


