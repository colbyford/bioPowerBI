// Read GFF3 Files

let
    // Read in file
    Source = Table.FromColumns({Lines.FromBinary(File.Contents("C:\Users\Colby Ford\Desktop\bioPowerBI\gff3\sample.gff"), null, null, 65001)}),
    // Skip ## lines
    #"Filtered Rows" = Table.SelectRows(Source, each not Text.StartsWith([Column1], "##")),
    // Split into columns by \t character and assign names
    // Note: This removes and values past the 9 standard columns
    #"Split Column by Delimiter" = Table.SplitColumn(#"Filtered Rows", "Column1", Splitter.SplitTextByDelimiter("#(tab)", QuoteStyle.Csv), {"seqid","source","type","start","end","score","strand","phase","attributes"})
in
    #"Split Column by Delimiter"

////////////////////////////////
// Read in Header
let
    // Read in file
    Source = Table.FromColumns({Lines.FromBinary(File.Contents("C:\Users\Colby Ford\Desktop\bioPowerBI\gff3\sample.gff"), null, null, 65001)}),
    #"Filtered Rows" = Table.SelectRows(Source, each Text.StartsWith([Column1], "##")),
    #"Split Column by Delimiter" = Table.SplitColumn(#"Filtered Rows", "Column1", Splitter.SplitTextByEachDelimiter({"="}, QuoteStyle.Csv, false), {"Column1.1", "Column1.2"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Split Column by Delimiter",{{"Column1.1", type text}, {"Column1.2", type text}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"Column1.1", "Keyword"}, {"Column1.2", "Value"}})
in
    #"Renamed Columns"