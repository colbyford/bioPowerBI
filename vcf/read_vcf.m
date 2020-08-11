// Read in the file
let
    Source = Table.FromColumns({Lines.FromBinary(Web.Contents("https://raw.githubusercontent.com/vcflib/vcflib/master/samples/sample.vcf"), null, null, 65001)})
in
    Source

// Split out the header
let
    Source = sample,
    #"Filtered Rows" = Table.SelectRows(Source, each Text.StartsWith([Column1], "##")),
    #"Split Column by Delimiter" = Table.SplitColumn(#"Filtered Rows", "Column1", Splitter.SplitTextByEachDelimiter({"="}, QuoteStyle.Csv, false), {"Column1.1", "Column1.2"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Split Column by Delimiter",{{"Column1.1", type text}, {"Column1.2", type text}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"Column1.1", "Keyword"}, {"Column1.2", "Value"}})
in
    #"Renamed Columns"

// Parse the data as a table
let
    Source = sample,
    #"Filtered Rows" = Table.SelectRows(Source, each not Text.StartsWith([Column1], "##")),
    #"Split Column by Delimiter" = Table.SplitColumn(#"Filtered Rows", "Column1", Splitter.SplitTextByDelimiter("#(tab)", QuoteStyle.Csv), {"Column1.1", "Column1.2", "Column1.3", "Column1.4", "Column1.5", "Column1.6", "Column1.7", "Column1.8", "Column1.9", "Column1.10", "Column1.11", "Column1.12"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Split Column by Delimiter",{{"Column1.1", type text}, {"Column1.2", type text}, {"Column1.3", type text}, {"Column1.4", type text}, {"Column1.5", type text}, {"Column1.6", type text}, {"Column1.7", type text}, {"Column1.8", type text}, {"Column1.9", type text}, {"Column1.10", type text}, {"Column1.11", type text}, {"Column1.12", type text}}),
    #"Promoted Headers" = Table.PromoteHeaders(#"Changed Type", [PromoteAllScalars=true]),
    #"Changed Type1" = Table.TransformColumnTypes(#"Promoted Headers",{{"#CHROM", type text}, {"POS", Int64.Type}, {"ID", type text}, {"REF", type text}, {"ALT", type text}, {"QUAL", type text}, {"FILTER", type text}, {"INFO", type text}, {"FORMAT", type text}, {"NA00001", type text}, {"NA00002", type text}, {"NA00003", type text}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type1",{{"#CHROM", "CHROM"}})
in
    #"Renamed Columns"