library("optparse")
library("chromoR")

option_list = list(
  make_option(c("-i", "--input"), type = "character", default = NA,
              help = "normalized HiC matrix"),
  make_option(c("-o", "--output"), type = "character", default = NA,
              help = "output domains")
)

opt_parser <- OptionParser(option_list=option_list)
opt <- parse_args(opt_parser)

if ( is.na(opt$input) | is.na(opt$output)) {
  stop("Missing required parameters. See usage (--help)")
}

mat_in <- opt$input
domain_out <- opt$output

if ( !file.exists(mat_in) ) {
  stop("Cannot open inputfile.")
}

print(mat_in)
mat=read.table(mat_in)
mat=as.matrix(mat)
p = rowSums(mat)-diag(mat)
res = segmentCIM(p)
write.table(res$changePoints,file=domain_out,row.names=F,col.names=F,sep="\t")
