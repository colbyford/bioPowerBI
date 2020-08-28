// Read SAM Files

let
    // Read in file
    Source = Table.FromColumns({Lines.FromBinary(File.Contents("C:\Users\Colby\Documents\GitHub\bioPowerBI\bam_and_sam\sample.sam"), null, null, 65001)}),
    // Skip @ lines
    #"Filtered Rows" = Table.SelectRows(Source, each not Text.StartsWith([Column1], "@")),
    // Split into columns by \t character and assign names
    // Note: This removes and values past the 11 standard columns
    #"Split Column by Delimiter" = Table.SplitColumn(#"Filtered Rows", "Column1", Splitter.SplitTextByDelimiter("#(tab)", QuoteStyle.Csv), {"QNAME","FLAG","RNAME","POS","MAPQ","CIGAR","RNEXT","PNEXT","TLEN","SEQ","QUAL"}),
    // Change data types
    #"Changed Type" = Table.TransformColumnTypes(#"Split Column by Delimiter",{{"QNAME", type text}, {"FLAG", Int64.Type}, {"RNAME", type text}, {"POS", Int64.Type}, {"MAPQ", Int64.Type}, {"CIGAR", type text}, {"RNEXT", type text}, {"PNEXT", Int64.Type}, {"TLEN", Int64.Type}, {"SEQ", type text}, {"QUAL", type text}})

in
    #"Changed Type"