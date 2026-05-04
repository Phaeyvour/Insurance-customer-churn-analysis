--1.What is the overall churn rate of the company?
SELECT ROUND(100.0 * SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS Churn_rate
FROM churn;

--2.Which age group has the highest churn rate?
SELECT 
    CASE 
        WHEN C.age BETWEEN 18 AND 25 THEN 'Teenagers'
        WHEN C.age BETWEEN 26 AND 35 THEN 'Young Adults'
        WHEN C.age BETWEEN 36 AND 50 THEN 'Adults'
        ELSE 'Old'
    END AS age_group,
COUNT(*) AS total_customers,
SUM(CH.churned) AS churned_customers,
ROUND(100.0 * SUM(CH.churned) / COUNT(*),2) AS churn_rate
FROM customers AS C
JOIN churn AS CH
ON C.customer_id = CH.customer_id
GROUP BY 
    CASE 
		WHEN C.age BETWEEN 18 AND 25 THEN 'Teenagers'
        WHEN C.age BETWEEN 26 AND 35 THEN 'Young Adults'
        WHEN C.age BETWEEN 36 AND 50 THEN 'Adults'
        ELSE 'Old'
    END
ORDER BY age_group ASC;

--3.Do married customers churn less than single customers?
SELECT C.marital_status,COUNT(*) AS total_customers,SUM(CH.churned) AS churned_customers
FROM customers C
JOIN churn CH
ON C.customer_id = CH.customer_id
WHERE C.marital_status IN ('Married', 'Single')
GROUP BY C.marital_status
ORDER BY C.marital_status;

--4.Does income level affect churn probability?
SELECT 
    CASE 
        WHEN C.income BETWEEN 1000 AND 10000 THEN 'Low Income'
        WHEN C.income BETWEEN 11000 AND 25000 THEN 'Lower Middle Income'
        WHEN C.income BETWEEN 26000 AND 40000 THEN 'Upper Middle Income'
        WHEN C.income BETWEEN 41000 AND 50000 THEN 'High Income '
        ELSE 'Very High Income'
    END AS Income_group,COUNT(*) AS total_customers,SUM(CH.churned) AS churned_customers
FROM customers C
JOIN churn CH
ON C.customer_id = CH.customer_id
GROUP BY 
    CASE 
        WHEN C.income BETWEEN 1000 AND 10000 THEN 'Low Income'
        WHEN C.income BETWEEN 11000 AND 25000 THEN 'Lower Middle Income'
        WHEN C.income BETWEEN 26000 AND 40000 THEN 'Upper Middle Income'
        WHEN C.income BETWEEN 41000 AND 50000 THEN 'High Income '
        ELSE 'Very High Income' END
ORDER BY income_group DESC;

--5.Which employment type has the highest churn rate?
SELECT C.employment_status, COUNT(*) AS total_customers, SUM(CH.churned) AS churned_customers
FROM customers C
JOIN churn CH
ON C.customer_id = CH.customer_id
GROUP BY C.employment_status
ORDER BY churned_customers DESC;

--6.Which policy type generates the highest revenue?
SELECT policy_type, SUM(premium_amount) AS Revenue 
FROM policies
GROUP BY policy_type
ORDER BY Revenue DESC;

--7.What is the average premium paid by churned vs retained customers?
SELECT 
    CASE WHEN churned = 1 THEN 'Churned' ELSE 'Retained' END AS Customer_Status,
    AVG(premium_amount) AS Avg_Premium
FROM policies AS p
JOIN churn AS c 
ON P.customer_id = C.customer_id
GROUP BY churned;

--8.What is the total revenue lost due to churned customers?
SELECT SUM(P.premium_amount) AS total_revenue_lost
FROM policies AS P
JOIN Churn AS C
ON P.customer_id = C.customer_id
WHERE C.churned = 1;

--9.Do customers with discounts churn less?
SELECT 
    CASE 
        WHEN P.discount_applied = 1 THEN 'Discount'
        ELSE 'No Discount'
    END AS discount_group,
COUNT(*) AS total_customers,
SUM(C.churned) AS churned_customers
FROM churn C
JOIN policies P
ON C.customer_id = P.customer_id
GROUP BY 
    CASE 
    WHEN P.discount_applied = 1 THEN 'Discount'
    ELSE 'No Discount'
    END;

--10.Do customers with higher claim amounts churn more?
SELECT 
    CASE 
        WHEN C.claim_amount BETWEEN 0 AND 5000 THEN 'Low Claims'
        WHEN C.claim_amount BETWEEN 5001 AND 20000 THEN 'Medium Claims'
        ELSE 'High Claims'
    END AS claim_group,
    COUNT(*) AS total_customers,
    SUM(CH.churned) AS churned_customers,
    ROUND(100.0 * SUM(CH.churned) / COUNT(*), 2) AS churn_rate
FROM policies AS P
JOIN claims AS C
ON P.customer_id = C.customer_id
JOIN churn AS CH
ON CH.customer_id = P.customer_id
GROUP BY 
    CASE 
        WHEN C.claim_amount BETWEEN 0 AND 5000 THEN 'Low Claims'
        WHEN C.claim_amount BETWEEN 5001 AND 20000 THEN 'Medium Claims'
        ELSE 'High Claims'END
ORDER BY churn_rate DESC;

--11. What is the average number of claims for churned customers?
SELECT AVG(C.claim_frequency_per_year) AS avg_claims_for_churned_customers
FROM Claims AS C
JOIN churn AS CH
ON C.customer_id = CH.customer_id
WHERE CH.churned = 1;

--12.Which policy type has the highest claim frequency?
SELECT P.policy_type, AVG(C.claim_frequency_per_year) AS avg_claim_frequency
FROM policies AS P
JOIN claims AS C
ON P.customer_id = C.customer_id
GROUP BY P.policy_type
ORDER BY avg_claim_frequency DESC

--13.Do customers with low digital engagement scores churn more?
SELECT 
    CASE 
        WHEN engagement.digital_engagement_score BETWEEN 0 AND 30 THEN 'Low Engagement'
        WHEN engagement.digital_engagement_score BETWEEN 31 AND 70 THEN 'Medium Engagement'
        ELSE 'High Engagement'
    END AS engagement_group,
    COUNT(*) AS total_customers,
    SUM(churn.churned) AS churned_customers,
    ROUND(100.0 * SUM(churn.churned) / COUNT(*), 2) AS churn_rate
FROM engagement
JOIN churn
ON engagement.customer_id = churn.customer_id
GROUP BY 
    CASE 
        WHEN engagement.digital_engagement_score BETWEEN 0 AND 30 THEN 'Low Engagement'
        WHEN engagement.digital_engagement_score BETWEEN 31 AND 70 THEN 'Medium Engagement'
        ELSE 'High Engagement'
    END
ORDER BY churn_rate DESC;

--15.Why are customers leaving ??
--i. Check churn by income group (PRICE sensitivity)
SELECT 
    CASE 
        WHEN income BETWEEN 1000 AND 10000 THEN '1k-10k'
        WHEN income BETWEEN 11000 AND 25000 THEN '11k-25k'
        WHEN income BETWEEN 26000 AND 40000 THEN '26k-40k'
        WHEN income BETWEEN 41000 AND 50000 THEN '41k-50k'
        ELSE '51k+'
    END AS income_group,

    COUNT(*) AS total_customers,
    SUM(churned) AS churned_customers

FROM customers c
JOIN churn ch
ON c.customer_id = ch.customer_id

GROUP BY 
    CASE 
        WHEN income BETWEEN 1000 AND 10000 THEN '1k-10k'
        WHEN income BETWEEN 11000 AND 25000 THEN '11k-25k'
        WHEN income BETWEEN 26000 AND 40000 THEN '26k-40k'
        WHEN income BETWEEN 41000 AND 50000 THEN '41k-50k'
        ELSE '51k+'
    END
ORDER BY churned_customers DESC;
--Income is not the issue, lets dive deeper

--ii. Check churn by employment status
SELECT 
    c.employment_status,
    COUNT(*) AS total_customers,
    SUM(churned) AS churned_customers

FROM customers c
JOIN churn ch
ON c.customer_id = ch.customer_id

GROUP BY c.employment_status
ORDER BY churned_customers DESC;
--Employment status does not meaningfully explain churn differences — churn is consistently high across all job types.

--iii.Check churn by policy type (PRODUCT issue)
SELECT 
    p.policy_type,
    COUNT(*) AS total_customers,
    SUM(ch.churned) AS churned_customers

FROM policies p
JOIN churn ch
ON p.customer_id = ch.customer_id

GROUP BY p.policy_type
ORDER BY churned_customers DESC;
--Churn rates are consistently high across all policy types, indicating that product category is not a key differentiator of churn behavior.

--iv.Check churn by engagement
SELECT 
    CASE 
        WHEN digital_engagement_score < 30 THEN 'Low'
        WHEN digital_engagement_score BETWEEN 30 AND 70 THEN 'Medium'
        ELSE 'High'
    END AS engagement_level,

    COUNT(*) AS total_customers,
    SUM(churned) AS churned_customers
FROM engagement AS E
JOIN churn ch
ON E.customer_id = ch.customer_id
GROUP BY 
    CASE 
        WHEN digital_engagement_score < 30 THEN 'Low'
        WHEN digital_engagement_score BETWEEN 30 AND 70 THEN 'Medium'
        ELSE 'High'
    END
ORDER BY churned_customers DESC;
--Customer engagement level is the strongest predictor of churn. Customers with low engagement are significantly more likely to churn(302 out of 302, that is 100%), 
--suggesting that lack of interaction and customer involvement is the primary driver of customer loss.

--iv.Check churn by late payments
SELECT 
    late_payments_count,
    COUNT(*) AS total_customers,
    SUM(churned) AS churned_customers

FROM Engagement AS E
JOIN churn AS CH
ON E.customer_id = ch.customer_id
GROUP BY late_payments_count
ORDER BY late_payments_count DESC;
--Churn rates remain consistently high across all late payment categories, suggesting that late payment behavior is not a strong differentiating factor for churn in this dataset.


--16.Which employment group experiences the most customer churn?
SELECT 
    C.employment_status,
    COUNT(*) AS total_customers,
    SUM(CH.churned) AS churned_customers

FROM customers C
JOIN churn CH
ON C.customer_id = CH.customer_id

GROUP BY C.employment_status
ORDER BY churned_customers DESC;


--17.Which policy type has the highest customer churn?
SELECT 
    P.policy_type,
    COUNT(*) AS total_customers,
    SUM(CH.churned) AS churned_customers
FROM policies AS P
JOIN churn AS CH
ON P.customer_id = CH.customer_id
GROUP BY P.policy_type
ORDER BY churned_customers DESC;

--18.Which customer segments contribute the most to revenue loss?
SELECT 
    CASE 
        WHEN C.income BETWEEN 1000 AND 10000 THEN 'Low Income'
        WHEN C.income BETWEEN 11000 AND 25000 THEN 'Lower-Middle Income'
        WHEN C.income BETWEEN 26000 AND 40000 THEN 'Upper-Middle Income'
        WHEN C.income BETWEEN 41000 AND 50000 THEN 'High Income'
        ELSE 'Very High Income'
    END AS Income_group,

    SUM(P.premium_amount) AS revenue_lost
FROM customers C
JOIN policies P
ON C.customer_id = P.customer_id
JOIN churn CH
ON C.customer_id = CH.customer_id
WHERE CH.churned = 1
GROUP BY 
    CASE 
        WHEN C.income BETWEEN 1000 AND 10000 THEN 'Low Income'
        WHEN C.income BETWEEN 11000 AND 25000 THEN 'Lower-Middle Income'
        WHEN C.income BETWEEN 26000 AND 40000 THEN 'Upper-Middle Income'
        WHEN C.income BETWEEN 41000 AND 50000 THEN 'High Income'
        ELSE 'Very High Income'
    END
ORDER BY revenue_lost DESC;

--19.Are claims increasing or decreasing over time?
SELECT 
    FORMAT(claim_date, 'yyyy-MM') AS month,
    COUNT(*) AS number_of_claims
FROM claims
GROUP BY FORMAT(claim_date, 'yyyy-MM')
ORDER BY month;

--20.How does the number of late payments affect customer churn?
SELECT late_payments_count, COUNT(*) AS total_customers,SUM(churned) AS churned_customers
FROM engagement AS E
JOIN churn CH
ON E.customer_id = CH.customer_id
GROUP BY late_payments_count
ORDER BY late_payments_count;

--The analysis of customer churn across multiple factors (income, employment status, policy type, and engagement level)
--revealed that churn is extremely high across the dataset, averaging above 90% in most segments.

--Demographic and financial factors such as income, employment status, and policy type showed minimal variation
--in churn rates, indicating they are not primary drivers of customer attrition.

--A strong pattern emerged with customer engagement. Customers with low engagement exhibited near-total churn,
--while churn decreased significantly for medium and high engagement groups. This identifies engagement as the
--most significant predictor of customer retention.

--Further analysis showed that late payment behavior and claims activity had limited influence on churn,
--as rates remained consistently high across these factors.

--From a business perspective, this high churn rate has resulted in substantial revenue loss, as many customers
--are no longer contributing premium payments. This highlights the need to shift focus from customer acquisition
--to retention.

--Overall, the findings indicate that the core issue is not related to pricing, product offerings, or customer
--demographics, but rather low customer engagement.

--My final Recommendations:
--To reduce churn, the company should focus on improving customer engagement by:
--1. Enhancing digital platforms to increase interaction because if they dont, most customers will feel left out.
--2. Implementing personalized communication and follow-ups
--3. Introducing loyalty programs and engagement incentives
--4. Monitoring engagement levels to identify at-risk customers early

--Improving engagement will significantly enhance customer retention and reduce revenue loss.