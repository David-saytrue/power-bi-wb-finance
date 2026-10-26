# Marketplace finance dashboard (Power BI)

**Star-schema** semantic model for marketplace seller analytics: fact tables from **PostgreSQL** (Import), dimensions from a **Google Sheet** via `Excel.Workbook(Web.Contents(...))` — no Google connector, no DirectQuery.

**Author:** [David-saytrue](https://github.com/David-saytrue) · Tbilisi, Georgia

Related: [power-bi-sales-dashboard](https://github.com/David-saytrue/power-bi-sales-dashboard) (flat Superstore model) · [data-engineer-prep](https://github.com/David-saytrue/data-engineer-prep) (SQL / course labs)

The checked-in `.pbix` is optional and not in this repo; rebuild from the scripts below.

---

## Model

| Layer | Tables | Source |
|-------|--------|--------|
| Facts | `Fact_Realization`, `Fact_Orders` | PostgreSQL views (Import) |
| Dimensions | `Dim_Nomenclature`, `Dim_Cost`, `Dim_Tariff`, `Dim_Date` | Sheet tabs + calendar |
| Staging | `_Workbook` | xlsx export URL — **Enable load OFF** |

Relationships: **one-to-many**, dimension → fact, **Single** cross-filter only (no **Both**).

Typical keys:

- `Dim_Nomenclature[barcode]` → facts `[barcode]`
- `Dim_Cost[Штрих-код]` → `Dim_Nomenclature[barcode]`
- `Dim_Tariff[subject]` → `Dim_Nomenclature[subject]`
- `Dim_Date[Date]` → fact date columns

---

## Power Query (M)

| File | Query name |
|------|------------|
| `queries/00-Workbook.m` | `_Workbook` |
| `queries/Dim-Nomenclature.m` | `Dim_Nomenclature` |
| `queries/Dim-Cost.m` | `Dim_Cost` |
| `queries/Dim-Tariff.m` | `Dim_Tariff` |

Paste into **Advanced Editor**. Replace the workbook URL in `00-Workbook.m` if you use your own dictionary sheet (sharing: anyone with the link, xlsx export).

Postgres: connect in Desktop with credentials from your environment; load realization and orders views; rename to `Fact_Realization` / `Fact_Orders`.

---

## DAX (draft)

Measures for WB-style finance KPIs: revenue, orders, commission %, logistics, cost of sales/returns, gross profit, ROI, MoM revenue. See [`dax-measures.dax`](dax-measures.dax). Adjust table/column names to match your loaded schema.

---

## Rebuild checklist

1. Blank `.pbix` → paste M queries → Close & Apply.
2. Import Postgres facts.
3. Model view → relationships as above.
4. Create measures from `dax-measures.dax`.
5. Build report (KPIs, trends, tops, MoM) per your assignment spec.

---

## Portfolio note

Interview-style case: multi-source ingest, dimensional modeling, and business metrics on real-scale row counts (~500k+ realization rows). Credentials and host for the shared Postgres sandbox are **not** stored in this repo.
