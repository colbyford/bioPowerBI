# install.packages( "http://www.well.ox.ac.uk/~gav/resources/rbgen_v1.1.5.tgz", repos = NULL, type = "source" )

library(rbgen)

file <- "C:\\Users\\Colby Ford\\Desktop\\bioPowerBI\\bgen\\sample.bgen"

dataset <- as.data.frame(bgen.load(file))