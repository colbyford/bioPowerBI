# BiocManager::install("Rsamtools")

library(Rsamtools)
library(dplyr)

file <- "sample.bam"

# asSam(file)

bam_contents <- scanBam(file) %>% as.data.frame()
