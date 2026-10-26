// Power Query name: Dim_Cost   (Enable load ON)
// Depends on query _Workbook
let
    Source = _Workbook,
    Sheet = Source{[Item = "Себестоимость", Kind = "Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Sheet, [PromoteAllScalars = true]),
    #"Removed Blanks" = Table.SelectRows(#"Promoted Headers", each [#"Штрих-код"] <> null),
    #"Typed" = Table.TransformColumnTypes(
        #"Removed Blanks",
        {{"Штрих-код", type text}, {"Себестоимость", type number}}
    )
in
    #"Typed"
