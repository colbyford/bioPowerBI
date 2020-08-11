// Read FASTQ Files

let
    // Read in file
    Source = Table.FromColumns({Lines.FromBinary(File.Contents("C:\Users\Colby\Documents\GitHub\bioPowerBI\fastq\sample.fastq"), null, null, 65001)}),
    // Add index column for getting subsequent row placement
    #"Added Index" = Table.AddIndexColumn(Source, "Index", 0, 1, Int64.Type),
    // Extract IDs and add to new column (also remove @ character)
    #"Added id column" = Table.AddColumn(#"Added Index", "id", each if Text.StartsWith([Column1], "@") then Text.Remove([Column1], "@") else ""),
    // Extract sequence and add to new column
    #"Added seq column" = Table.AddColumn(#"Added id column", "seq", each if Text.StartsWith([Column1], "@") then Text.Combine(List.Range(Source[Column1], [Index]+1, 1)) else ""),
    // Extract quality sequence and add to new column
    #"Added qual column" = Table.AddColumn(#"Added seq column", "qual", each if Text.StartsWith([Column1], "@") then Text.Combine(List.Range(Source[Column1], [Index]+3, 1)) else ""),
    // Remove raw column and index column
    #"Removed Columns" = Table.RemoveColumns(#"Added qual column",{"Column1", "Index"}),
    // Remove blank rows
    #"Removed Blank Rows" = Table.SelectRows(#"Removed Columns", each not List.IsEmpty(List.RemoveMatchingItems(Record.FieldValues(_), {"", null})))
in
    #"Removed Blank Rows"