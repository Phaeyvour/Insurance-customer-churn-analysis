# Insurance Customer Churn Analysis

## Project Overview

Customer churn is one of the most critical problems in the insurance industry. Retaining customers is significantly cheaper than acquiring new ones, and high churn directly impacts revenue.

In this project, I analyzed a structured insurance dataset to answer a key business question:

> **Why are customers leaving the company at such a high rate?**

Using SQL for data exploration and analysis, I uncovered key patterns driving churn and translated them into actionable business insights.

##  Business Problem

The company is experiencing an extremely high churn rate (~91%).

This raises urgent concerns:
- What factors are causing customers to leave?
- Are certain customer groups more likely to churn?
- Is the issue related to pricing, products, or behavior?
- What is the financial impact of churn?

## Dataset Description

The dataset simulates a real-world insurance database and includes:

### 1. Customer Information
- Age
- Income
- Employment Status
- Marital Status

### 2. Policy Information
- Policy Type
- Premium Amount
- Discounts

### 3. Claims Data
- Claim Amount
- Claim Frequency
- Claim Dates

### 4. Engagement Data
- Digital Engagement Score
- Late Payments

### 5. Target Variable
- `churned` (1 = customer left, 0 = retained)

---

## Data Exploration Process

Before analysis, I performed data validation to ensure quality:

- Checked for missing values
- Verified data consistency (formats, data types)
- Ensured no duplicate customer records
- Validated churn values (0 and 1)
- Reviewed distributions across key variables

## Key Business Questions Answered

### 1. What is the overall churn rate?
→ The churn rate was over **91%**, indicating a severe retention issue.

### 2. Do demographics influence churn?
- Age groups → minimal differences
- Income levels → little variation
- Employment status → similar churn patterns

**Insight:** Demographics are NOT the main driver of churn.

### 3. Do insurance products affect churn?
- All policy types showed consistently high churn

**Insight:** Product type is not a key differentiator.

### 4. Do financial factors matter?
- Late payments → no strong variation
- Claims activity → minimal impact

 **Insight:** Financial behavior alone does not explain churn.

### 5. What is the strongest driver of churn?

**Customer Engagement**

- Low engagement customers had extremely high churn
- Medium/high engagement customers retained more

**Insight:** Engagement is the most significant predictor of churn.

### 6. What is the financial impact?

- High churn leads to **significant revenue loss**
- Lost premium payments directly affect profitability

##  Key Insights

- Churn is **not driven by demographics**
- Churn is **not strongly tied to product type or pricing**
- Customer engagement is the **primary driver of churn**
- Low engagement = high likelihood of leaving
- High churn leads to **major revenue loss**

---

## Business Recommendations

Based on the analysis, the company should focus on:

### 1. Improve Customer Engagement
- Enhance digital platforms
- Increase interaction with customers
- Provide better onboarding experience

### 2. Personalization
- Send targeted communication
- Use customer behavior to tailor offers

### 3. Early Risk Detection
- Identify low-engagement customers early
- Implement retention strategies proactively

### 4. Loyalty Programs
- Reward active and long-term customers
- Increase customer retention incentives

## Tools Used

- **SQL Server**
  - Joins
  - Aggregations
  - CASE statements
  - Data grouping and segmentation

- **Power BI**
  - Dashboard creation
  - KPI visualization
  - Business storytelling

## Conclusion

This project demonstrates how data analysis can move beyond numbers to uncover real business problems.

> **Churn is not random — it is driven by customer engagement.**

Improving how customers interact with the company is the key to reducing churn and protecting revenue.
<img width="582" height="329" alt="Screenshot 2026-05-04 182122" src="https://github.com/user-attachments/assets/d6339c4c-de87-4158-b178-78da0738439e" />
