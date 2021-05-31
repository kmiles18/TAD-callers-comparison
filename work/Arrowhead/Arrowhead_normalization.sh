#!/bin/bash 

#downsample
BIN=50000
echo "Processing size ${BIN}"

mkdir -p DOMAINS/normalization

java -jar juicer_tools.jar arrowhead /homeb/LiuKun/merged_hic/preprocess/GM12878/total_merged.hic DOMAINS/normalization/GM12878_50k_KR.chr6 -c chr6 -r ${BIN} -k KR --ignore_sparsity

java -jar juicer_tools.jar arrowhead /homeb/LiuKun/merged_hic/preprocess/GM12878/total_merged.hic DOMAINS/normalization/GM12878_50k_VC.chr6 -c chr6 -r ${BIN} -k VC --ignore_sparsity

