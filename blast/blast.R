# BiocManager::install("annotate")

# install.packages("C:/Users/Colby/Downloads/annotate_1.68.0.zip", 
#                  repos = NULL, 
#                  type = "source")

library(annotate)
library(dplyr)

seq <- seqinr::read.fasta("../fasta/sample.fasta")[1]
seq <- ShortRead:readFastq("../fastq/sample.fastq")

seq_query <- seq[[1]] %>% toupper() %>% paste(collapse = "")
  
output <- annotate::blastSequences(URLencode(seq_query),
                         database= "XML",
                         program = "blastp",
                         timeout = 240,
                         as = "data.frame")



output <- annotate::blastSequences(URLencode(seq_query), program = "blastp", timeout = 240, as = "data.frame")

## In-Power BI Script

dataset <- data.frame(id = c("EAS54_6_R1_2_1_413_324",
                             "EAS54_6_R1_2_1_540_792",
                             "EAS54_6_R1_2_1_443_348"),
                      seq	= c("CCCTTCTTGTCTTCAGCGTTTCTCC",
                              "TTGGCAGGCCAAGGCCGATGGATCA",
                              "GTTGCTTCTGGCGTGGGTGGGGGGG"),
                      qual = c(";;3;;;;;;;;;;;;7;;;;;;;88",
                               ";;;;;;;;;;;7;;;;;-;;;3;83",
                               ";;;;;;;;;;;9;7;;.7;393333"),
                      stringsAsFactors = FALSE)
		

annotate::blastSequences(URLencode("CCCTTCTTGTCTTCAGCGTTTCTCC"), program = "blastn", timeout = 480, as = "data.frame")

dataset$blast <- lapply(dataset$seq, function(x){
  # print(x)
  # result <- length(x)
  
  result <- annotate::blastSequences(URLencode(x), program = "blastn", timeout = 1000, as = "data.frame")
  return(result)
}) %>%  as.data.frame()
