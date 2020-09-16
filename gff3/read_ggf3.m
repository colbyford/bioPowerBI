// Read GFF3 Files

let
    // Read in file
    Source = Table.FromColumns({Lines.FromBinary(File.Contents("C:\Users\Colby Ford\Desktop\bioPowerBI\gff3\sample.gff"), null, null, 65001)}),
    // Skip ## lines
    #"Filtered Rows" = Table.SelectRows(Source, each not Text.StartsWith([Column1], "##")),
    // Split into columns by \t character and assign names
    // Note: This removes and values past the 9 standard columns
    #"Split Column by Delimiter" = Table.SplitColumn(#"Filtered Rows", "Column1", Splitter.SplitTextByDelimiter("#(tab)", QuoteStyle.Csv), {"seqid","source","type","start","end","score","strand","phase","attributes"}),
    // Parse columns from `attributes`
    #"Add_Attr_ID" = Table.AddColumn(#"Split Column by Delimiter", "ID", each Text.BetweenDelimiters([attributes], "ID=", ";"), type text),
    #"Add_Attr_Name" = Table.AddColumn(#"Add_Attr_ID", "Name", each Text.BetweenDelimiters([attributes], "Name=", ";"), type text),
    #"Add_Attr_Alias" = Table.AddColumn(#"Add_Attr_Name", "Alias", each Text.BetweenDelimiters([attributes], "Alias=", ";"), type text),
    #"Add_Attr_Parent" = Table.AddColumn(#"Add_Attr_Alias", "Parent", each Text.BetweenDelimiters([attributes], "Parent=", ";"), type text),
    #"Add_Attr_Target" = Table.AddColumn(#"Add_Attr_Parent", "Target", each Text.BetweenDelimiters([attributes], "Target=", ";"), type text),
    #"Add_Attr_Gap" = Table.AddColumn(#"Add_Attr_Target", "Gap", each Text.BetweenDelimiters([attributes], "Gap=", ";"), type text),
    #"Add_Attr_Derives_from" = Table.AddColumn(#"Add_Attr_Gap", "Derives_from", each Text.BetweenDelimiters([attributes], "Derives_from=", ";"), type text),
    #"Add_Attr_Note" = Table.AddColumn(#"Add_Attr_Derives_from", "Note", each Text.BetweenDelimiters([attributes], "Note=", ";"), type text),
    #"Add_Attr_Dbxref" = Table.AddColumn(#"Add_Attr_Note", "Dbxref", each Text.BetweenDelimiters([attributes], "Dbxref=", ";"), type text),
    #"Add_Attr_Ontology_term" = Table.AddColumn(#"Add_Attr_Dbxref", "Ontology_term", each Text.BetweenDelimiters([attributes], "Ontology_term=", ";"), type text),
    #"Add_Attr_evidence" = Table.AddColumn(#"Add_Attr_Ontology_term", "evidence", each Text.BetweenDelimiters([attributes], "evidence=", ";"), type text),
    // Remove `attributes` column
    #"Removed Columns" = Table.RemoveColumns(Add_Attr_evidence,{"attributes"})

in
    #"Removed Columns"

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