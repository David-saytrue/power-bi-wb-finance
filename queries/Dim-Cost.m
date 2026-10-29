// Power Query name: Dim_Cost   (Enable load ON)
// Depends on query _Workbook
let
    Source = _Workbook,
    Sheet = Source{[Item = "Себестоимость", Kind = "Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Sheet, [PromoteAllScalars = true]),
    #"Removed Blanks" = Table.SelectRows(#"Promoted Headers", each [#"Штрих-код"] <> null),
    #"Barcode Clean" = Table.TransformColumns(
        #"Removed Blanks",
        {
            {
                "Штрих-код",
                each
                    try Text.From(Int64.From(_))
                    otherwise Text.Trim(Text.From(_)),
                type text
            }
        }
    ),
    #"Typed" = Table.TransformColumnTypes(
        #"Barcode Clean",
        {{"Штрих-код", type text}, {"Себестоимость", type number}}
    )
in
    #"Typed"
