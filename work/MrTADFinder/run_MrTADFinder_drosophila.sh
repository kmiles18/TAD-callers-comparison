#!/bin/bash

BIN=10000

chromList=($(seq 1 5))
chroms=(2L 2R 3L 3R X)
mkdir -p DOMAINS/Kc167
mkdir -p DATA/Kc167
mkdir -p control/Kc167
for chrom in ${chromList[@]}; do

python3 convert_triple_MrTADFinder.py ../Kc167/replicate_10k_KR.chr${chroms[$chrom-1]} DATA/Kc167/replicate_10k_KR.chr${chrom}
nrows=$(cat ../Kc167/replicate_10k_KR.chr${chroms[$chrom-1]} | wc -l)
python3 generate_coor.py control/Kc167/replicate_chr${chrom}.file1 control/Kc167/replicate_chr${chrom}.file2 ${BIN} ${nrows} chr${chrom}
/home/LiuKun/julia/julia-1.4.2/bin/julia run_MrTADFinder.jl DATA/Kc167/replicate_10k_KR.chr${chrom} control/Kc167/replicate_chr${chrom}.file1 control/Kc167/replicate_chr${chrom}.file2 res=1.8 ${chrom} DOMAINS/Kc167/replicate_10k_KR.chr${chroms[$chrom-1]}

python3 convert_triple_MrTADFinder.py ../Kc167/primary_10k_KR.chr${chroms[$chrom-1]} DATA/Kc167/primary_10k_KR.chr${chrom}
nrows=$(cat ../Kc167/primary_10k_KR.chr${chroms[$chrom-1]} | wc -l)
python3 generate_coor.py control/Kc167/primary_chr${chrom}.file1 control/Kc167/primary_chr${chrom}.file2 ${BIN} ${nrows} chr${chrom}
/home/LiuKun/julia/julia-1.4.2/bin/julia run_MrTADFinder.jl DATA/Kc167/primary_10k_KR.chr${chrom} control/Kc167/primary_chr${chrom}.file1 control/Kc167/primary_chr${chrom}.file2 res=1.8 ${chrom} DOMAINS/Kc167/primary_10k_KR.chr${chroms[$chrom-1]}

done

