# Superstore Sales Analysis
## Power BI Dashboard Preview

![Superstore Sales Dashboard](Superstore%20Sales_Dashboard_Screenshot.png)
## Project Overview

This project analyzes Superstore sales data to understand sales
performance, profitability, customer segments, product performance,
regional results, and monthly trends. The goal is to turn transactional
data into useful business insights that can support better decisions.

## Objectives

-   Measure overall sales, profit, order volume, and customer count.
-   Compare performance across product categories and customer segments.
-   Identify top-performing products, regions, and months.
-   Review data quality before interpreting results.
-   Present findings through SQL, Power BI, and a report.

## Tools Used

-   **PostgreSQL** --- data validation, querying, aggregation, and
    analysis.
-   **Power BI Desktop** --- dashboard creation and interactive
    exploration.
-   **Excel / CSV** --- source-data preparation and storage.

## Dataset and Data Quality

The project uses an original Superstore dataset and a cleaned CSV
version. The PostgreSQL database is `money` and the analysis table is
`superstore`.

Validation results recorded during the project: - Total records:
**10,194** - Unique row IDs: **10,194** - Unique orders: **5,111** -
Unique customers: **804**

## Key Performance Indicators

  Metric                                  Result
  ----------------------- ----------------------
  Total sales                       2,326,534.52
  Total profit                        292,297.57
  Total orders                             5,111
  Total customers                            804
  Overall profit margin     Approximately 12.56%

## Key Findings

### Product Categories

  Category                 Sales       Profit   Profit Margin
  ----------------- ------------ ------------ ---------------
  Technology          839,893.35   146,544.09          17.45%
  Office Supplies     731,893.23   126,023.54          17.22%
  Furniture           754,747.94    19,729.94           2.61%

Technology generated the highest sales and profit among the categories.
Furniture generated substantial sales but a much lower profit margin,
making it an area for further review.

### Regional Performance

-   **West** recorded the highest regional sales: **739,813.71**.
-   **South** recorded the lowest regional sales: **391,721.90**.

### Monthly Performance

-   **November** had the highest monthly sales: **352,666.01**.
-   **February** had the lowest monthly sales in the analysis:
    **59,751.26**.

### Product Performance

The **Canon imageCLASS 2200 Advanced Copier** was the top product by
sales, with **61,599.83** in sales, and also led product profit with
**25,199.94** in profit.

## Business Recommendations

1.  **Investigate Furniture profitability.** Review product costs,
    pricing, discounting, and product mix to understand why its margin
    is lower than the other categories.
2.  **Learn from Technology performance.** Examine high-performing
    products and customer needs to identify opportunities to maintain
    profitable sales.
3.  **Review regional differences.** Investigate factors behind the
    West's stronger sales and the South's lower sales before deciding on
    region-specific actions.
4.  **Plan around monthly trends.** Review demand, promotions, and stock
    availability around high- and low-sales months. Confirm whether the
    period covered is complete before making seasonal decisions.
5.  **Monitor profit as well as sales.** High sales do not always mean
    high profit; track both measures when evaluating products and
    customers.

These recommendations are starting points for further business
investigation, not proof of the causes behind the observed results.

## Project Files

The project folder is organized as follows:

``` text
Superstore Sales Analysis Project/
├── README.md
├── 01_SQL_Analysis/
│   └── Superstore_Analysis.sql
├── 02_Power_BI_Dashboard/
│   └── [Power BI .pbix file]
├── 03_Reports/
│   └── [Final report .pdf]
├── 04_Database_Backup/
│   └── Superstore_Backup.backup
└── 05_Source_Data/
    ├── [Original dataset]
    └── [Cleaned CSV dataset]
```

Replace bracketed filenames with the actual filenames where useful.

## Deliverables

-   PostgreSQL SQL analysis script
-   Interactive Power BI dashboard
-   PDF report
-   PostgreSQL database backup
-   Original and cleaned datasets

## Conclusion

This project demonstrates an end-to-end analytics workflow: organizing
source data, checking data quality, analyzing business performance with
SQL, presenting results in Power BI, and communicating findings through
a report. It provides a foundation for further analysis of
profitability, customer behavior, product performance, and regional
trends.
