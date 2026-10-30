# Phase 1: Ask (Problem Definition & Objectives)

### Business Context
The leadership team at The Look eCommerce wants to improve overall cash flow efficiency. 
While top-line sales have expanded, warehouse storage expenses are rising, and certain product lines appear to carry thin margins.

### Project Objective
Analyze order fulfillment and warehouse inventory records to identify margin drivers, quantify dead stock liability, and provide actionable recommendations for stock liquidation and marketing focus.

### Primary Business Questions
1. **Category Profitability:** What are the top 5 product categories by total profit and profit margin, versus those with high revenue but poor margins?
2. **Inventory Aging & Tied-up Capital:** How many inventory units have remained unsold for over 180 days, and what is the total capital tied up in this slow-moving stock?
3. **Order Value Distribution:** What percentage of total orders fall into low, medium, and high order-value brackets, and how does this affect average order profitability?

### Success Criteria & Key Metrics
- Gross Merchandise Value (GMV) & Total Realized Revenue
- Gross Profit Margin (%)
- Unsold Inventory Aging Distribution (Days in Warehouse)
- Total Tied-Up Inventory Cost ($)

# 2. Prepare Phase (Data Verification & ROCCC)
- **Dataset:** `bigquery-public-data.thelook_ecommerce` on Google BigQuery
- **ROCCC Assessment:**
  - **Reliable:** Managed dataset with consistent foreign keys and valid constraints.
  - **Original:** Standardized e-commerce transaction model by Looker/Google.
  - **Comprehensive:** Covers catalog items, basket items, orders, and unit-level warehouse storage.
  - **Current:** Includes timestamps extending into recent operational periods.
  - **Cited:** Google Cloud Public Datasets.

  status	total_items	percentage
Shipped	54344	30.03
Complete	45119	24.94
Processing	36365	20.1
Cancelled	27085	14.97
Returned	18033	9.97