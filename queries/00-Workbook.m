// Power Query name: _Workbook   (Enable load OFF)
// Stage 2: Excel.Workbook + Web.Contents, not the Google Sheets connector.
let
    WebWorkbook = "https://docs.google.com/spreadsheets/d/10sH4PxnIeT2AO8RK-b6SpHB8TuBfbXwC/export?format=xlsx",
    Source = Excel.Workbook(Web.Contents(WebWorkbook), null, true)
in
    Source
