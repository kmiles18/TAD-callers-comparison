#!/bin/bash

chromList=(2L 2R 3L 3R X)
BIN=10000
mkdir -p DOMAINS/Kc167
for chrom in ${chromList[@]}; do

Rscript chromoR_run.r -i /homeb/LiuKun/zongshu/Kc167/replicate_10k_KR.chr${chrom} -o DOMAINS/Kc167/replicate_10k_KR.chr${chrom}
Rscript chromoR_run.r -i /homeb/LiuKun/zongshu/Kc167/primary_10k_KR.chr${chrom} -o DOMAINS/Kc167/primary_10k_KR.chr${chrom}

done

