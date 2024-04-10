##What is the percentage of unique product increase in 2021 vs. 2020? The final output contains these fields, 
##unique_products_2020 unique_products_2021 percentage_chg

WITH unique_products AS (
    SELECT 
        fiscal_year, 
        COUNT(DISTINCT Product_code) as unique_products 
    FROM 
        fact_gross_price 
    GROUP BY 
        fiscal_year
)
SELECT 
    up_2020.unique_products as unique_products_2020,
    up_2021.unique_products as unique_products_2021,
    round((up_2021.unique_products - up_2020.unique_products)/up_2020.unique_products * 100,2) as percentage_change
FROM 
    unique_products up_2020
CROSS JOIN 
    unique_products up_2021
WHERE 
    up_2020.fiscal_year = 2020 
    AND up_2021.fiscal_year = 2021;
    
    
    
    
