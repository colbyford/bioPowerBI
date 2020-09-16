// Read BGEN Files

let
    // Use rbgen in an R Script to get the data from the .bgen file
    Source = R.Execute("library(rbgen)#(lf)file <- ""C:\\Users\\Colby Ford\\Desktop\\bioPowerBI\\bgen\\sample.bgen""#(lf)dataset <- as.data.frame(bgen.load(file))"),
    sample = Source{[Name="dataset"]}[Value]
in
    sample

/// The R Script above is:
// library(rbgen)
// file <- "C:\\Users\\Colby Ford\\Desktop\\bioPowerBI\\bgen\\sample.bgen"
// dataset <- as.data.frame(bgen.load(file))
///
