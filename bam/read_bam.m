// Read BAM Files

let
    // Use rsamtools in an R Script to get the data from the .bam file
    Source = R.Execute("library(Rsamtools)#(lf)file <- ""C:\\Users\\Colby\\Documents\\GitHub\\bioPowerBI\\bam\\sample.bam""#(lf)dataset <- as.data.frame(scanBam(file))"),
    sample = Source{[Name="dataset"]}[Value]
in
    sample

/// The R Script above is:
// library(Rsamtools)
// file <- "C:\\Users\\Colby\\Documents\\GitHub\\bioPowerBI\\bam\\sample.bam"
// dataset <- as.data.frame(scanBam(file))
///
