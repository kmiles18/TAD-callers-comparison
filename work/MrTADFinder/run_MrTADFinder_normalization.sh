#!/bin/bash

BIN=50000

mkdir -p DOMAINS/normalization
mkdir -p DATA/normalization
mkdir -p control/normalization

python3 convert_triple_MrTADFinder.py /homeb/LiuKun/merged_hic/GM12878_50k_KR.chr6 DATA/normalization/GM12878_50k_KR.chr6
nrows=$(cat /homeb/LiuKun/merged_hic/GM12878_50k_KR.chr6 | wc -l)
python3 generate_coor.py control/normalization/KR.file1 control/normalization/KR.file2 ${BIN} ${nrows} chr6
/home/LiuKun/julia/julia-1.4.2/bin/julia run_MrTADFinder.jl DATA/normalization/GM12878_50k_KR.chr6 control/normalization/KR.file1 control/normalization/KR.file2 res=1.8 6 DOMAINS/normalization/GM12878_50k_KR.chr6

python3 convert_triple_MrTADFinder.py /homeb/LiuKun/merged_hic/GM12878_50k_VC.chr6 DATA/normalization/GM12878_50k_VC.chr6
nrows=$(cat /homeb/LiuKun/merged_hic/GM12878_50k_VC.chr6 | wc -l)
python3 generate_coor.py control/normalization/VC.file1 control/normalization/VC.file2 ${BIN} ${nrows} chr6
/home/LiuKun/julia/julia-1.4.2/bin/julia run_MrTADFinder.jl DATA/normalization/GM12878_50k_VC.chr6 control/normalization/VC.file1 control/normalization/VC.file2 res=1.8 6 DOMAINS/normalization/GM12878_50k_VC.chr6
