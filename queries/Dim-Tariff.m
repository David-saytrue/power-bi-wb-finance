// Power Query name: Dim_Tariff   (Enable load ON)
// Depends on query _Workbook
let
    Source = _Workbook,
    Sheet = Source{[Item = "Тарифы и доставка", Kind = "Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Sheet, [PromoteAllScalars = true]),
    #"Removed Blanks" = Table.SelectRows(#"Promoted Headers", each [subject] <> null and [subject] <> ""),
    #"Typed" = Table.TransformColumnTypes(
        #"Removed Blanks",
        {
            {"subject", type text},
            {"Процент комиссии", type number},
            {"Процент комиссии по FBS", type number},
            {"Cтоимость логистики", type number},
            {"Базовая стоимость хранения", type number},
            {"Платная приёмка, ₽/ед.товара", type number}
        }
    )
in
    #"Typed"
