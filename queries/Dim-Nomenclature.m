// Power Query name: Dim_Nomenclature   (Enable load ON)
// Depends on query _Workbook
let
    Source = _Workbook,
    Sheet = Source{[Item = "Справочник номенклатуры", Kind = "Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Sheet, [PromoteAllScalars = true]),
    #"Removed Blanks" = Table.SelectRows(#"Promoted Headers", each [supplierArticle] <> null and [supplierArticle] <> ""),
    #"Typed" = Table.TransformColumnTypes(
        #"Removed Blanks",
        {
            {"supplierArticle", type text},
            {"subject", type text},
            {"category", type text},
            {"brand", type text},
            {"barcode", type text},
            {"Размер", type text},
            {"Рекомендуемая цена", type number},
            {"Цвет", type text},
            {"Страна производства", type text}
        }
    )
in
    #"Typed"
