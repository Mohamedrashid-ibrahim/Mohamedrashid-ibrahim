# Retail Sales Data Analysis

**Author:** Mohamedrashid Ibrahim Osman
**Background:** BCom Finance (Mount Kenya University) | Data Science & Machine Learning (Moringa School)

An end-to-end analysis of retail transaction data, following the CRISP-DM framework. The project cleans a deliberately messy sales dataset, answers six core business questions in Python, and validates the results with a SQL reporting layer in SQLite.

---

## Business Problem

Retail leadership lacks reliable visibility into product profitability, regional performance, and monthly revenue trends. The raw records contain duplicate entries, missing revenue values, inconsistent category and region labels, and corrupted profit figures. Pricing, discounting, and inventory decisions made on this data risk margin erosion and misallocated capital.

## Objectives

1. **Reconcile the data:** clean the raw records so Sales, Cost, Discount, Quantity, and Profit are accurate.
2. **Analyze profitability:** compare revenue against profit across products, categories, and regions.
3. **Understand trends and customers:** track monthly performance and customer segment value.
4. **Deliver BI reporting:** provide a reproducible SQL layer and an executive dashboard.

## Business Questions

1. What are the true Total Revenue, Total Profit, Total Orders, Average Order Value, and Profit Margin?
2. How have monthly sales and profit trended over time?
3. Which products and categories generate the most revenue, and do they deliver strong margins?
4. Which regions perform best and worst?
5. How do discount rates affect profit margins?
6. Which customer segments contribute the most value?

---

## Dataset

| Item | Detail |
|---|---|
| Source file | `data/retail_sales_dirty.csv` |
| Raw size | 10,039 rows × 21 columns |
| Period | Orders from 2015 to 2017 |
| Key fields | Order/Ship Date, Segment, Region, Category, Sub-Category, Product Name, Sales, Quantity, Discount, Profit |

### Data quality issues found

- 43 exact duplicate rows
- Missing values: Sales (55), Customer ID (40), Postal Code (30)
- Inconsistent labels in Region (`west `, `EAST`) and Category (`technology`)
- Invalid financial values: negative quantities, profit as extreme as 99,999.99, and discounts above 100%

## Data Cleaning Summary

| Step | Rows remaining |
|---|---|
| Raw data | 10,039 |
| After removing exact duplicates | 9,996 |
| After removing missing Sales and invalid financial records | 9,878 |

Other steps: standardized column names to snake_case, fixed text labels, converted dates to datetime, labeled missing Customer ID and Postal Code as `Unknown`, and applied validity rules (Quantity > 0, Discount between 0 and 1, Profit ≤ 50,000). No financial figures were fabricated or imputed.

New columns: `cost`, `profit_margin_pct`, `order_month`.
Final dataset: **9,878 rows × 24 columns**, with zero missing values.

---

## Key Findings

### Headline KPIs

| Metric | Value |
|---|---|
| Total Revenue | $2,279,343.87 |
| Total Profit | $284,243.98 |
| Total Orders | 4,980 |
| Average Order Value | $457.70 |
| Overall Profit Margin | 12.47% |

### Category performance

| Category | Sales | Profit | Margin |
|---|---|---|---|
| Technology | $846,590 | $149,715 | 17.68% |
| Office Supplies | $701,864 | $116,241 | 16.56% |
| Furniture | $730,890 | $18,288 | 2.50% |

Furniture brings in more revenue than Office Supplies but delivers a fraction of the profit.

### Regional performance

| Region | Sales | Profit | Margin |
|---|---|---|---|
| West | $723,979 | $106,176 | 14.67% |
| East | $675,700 | $91,827 | 13.59% |
| South | $385,910 | $47,711 | 12.36% |
| Central | $493,755 | $38,531 | 7.80% |

West leads on both profit and margin. Central ranks third in sales but has the lowest margin and lowest profit.

### Customer segments

Consumer is the largest segment ($1.15M sales, $133K profit), followed by Corporate ($702K sales, $91K profit) and Home Office ($426K sales, $60K profit).

### Discount impact

Orders with no discount average a **33.99%** profit margin. Margins turn negative at a 30% discount (-11.64%) and worsen steadily as discounts increase, reaching -182.91% at 80%.

### Loss-making sub-categories

Furniture **Tables** (-$17,777) and **Bookcases** (-$3,251) are the biggest drags on profit. Both carry average discounts above 20%.

---

## SQL Reporting Layer

The cleaned data is loaded into a SQLite database (`data/retail_sales.db`, table `sales`). Four queries reproduce and validate the Python results:

1. Executive KPIs (orders, revenue, profit, margin)
2. Revenue and margin by category
3. Regional performance
4. Five lowest-profit sub-categories

All SQL results match the Python analysis.

## Dashboard

An interactive Tableau dashboard (KPI cards, visual breakdowns, and filters) is part of the project scope. *Link to be added.*

---

## Project Structure

```
├── data/
│   ├── retail_sales_dirty.csv      # raw input
│   ├── retail_sales_cleaned.csv    # cleaned output
│   └── retail_sales.db             # SQLite database
├── notebooks/
│   └── 01_retail_sales_analysis.ipynb
├── reports/
│   ├── 01_monthly_trend.png
│   ├── 02_top_products.png
│   ├── 03_region_profit.png
│   └── 04_discount_impact.png
└── README.md
```

## Tools

Python (pandas, matplotlib, seaborn), SQLite, Jupyter Notebook, Tableau

## How to Run

1. Place `retail_sales_dirty.csv` in the `data/` folder.
2. Install dependencies: `pip install pandas matplotlib seaborn jupyter`
3. Open `notebooks/01_retail_sales_analysis.ipynb` and run all cells in order.
4. The cleaned CSV, SQLite database, and charts are written to `data/` and `reports/`.

## Recommendations

- Cap discounts at or below 20%, since deeper discounts consistently erase margin.
- Review pricing and discounting on Furniture, especially Tables and Bookcases.
- Investigate cost drivers in the Central region, which has the lowest margin.
