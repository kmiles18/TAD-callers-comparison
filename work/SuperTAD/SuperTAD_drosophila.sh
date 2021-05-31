#!/bin/bash

chromList=(2L 2R 3L 3R X)
BIN=10000
mkdir -p DOMAINS/Kc167
for chrom in ${chromList[@]}; do

cp /homeb/LiuKun/zongshu/Kc167/replicate_10k_KR.chr${chrom} DOMAINS/Kc167
nohup /homeb/LiuKun/major_revision/SuperTAD-1.1/build/SuperTAD binary DOMAINS/Kc167/replicate_10k_KR.chr${chrom} --chrom1 chr${chrom} -r $BIN --chrom1-start 0 -v > replicate_chr${chrom}.out&
cp /homeb/LiuKun/zongshu/Kc167/primary_10k_KR.chr${chrom} DOMAINS/Kc167
nohup /homeb/LiuKun/major_revision/SuperTAD-1.1/build/SuperTAD binary DOMAINS/Kc167/primary_10k_KR.chr${chrom} --chrom1 chr${chrom} -r $BIN --chrom1-start 0 -v > primary_chr${chrom}.out&
done

