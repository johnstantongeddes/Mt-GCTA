## Read .hsq produced by GCTA and save results to single file

# command-line arguments
args <- commandArgs(trailingOnly = TRUE)
trait <- args[1]
sample <- args[2]
iter <- args[3]

# read only the first four lines which contain variance components 
hsq <- read.table(paste("reml_", trait, "_", sample, "_", iter, ".hsq", sep=""), sep="\t", header=TRUE, nrows=4)

# write results of 'V(G)/Vp' to file
cat(trait, "\t", sample, "\t", iter, "\t", hsq[4,2], "\t", hsq[4,3], "\n", file=paste("../H2gcta_", sample,"_", trait, ".txt", sep=""), append=TRUE)
