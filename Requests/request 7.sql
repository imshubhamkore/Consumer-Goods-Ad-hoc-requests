/* Get the complete report of the Gross sales amount for the customer “Atliq
Exclusive” for each month. This analysis helps to get an idea of low and
high-performing months and take strategic decisions.
The final report contains these columns:
Month
Year
Gross sales Amount*/


SELECT 
    MONTHNAME(s.date) AS months,
    YEAR(s.date) AS years,
    ROUND(SUM(s.sold_quantity * g.gross_price), 2) AS Gross_sales_amount
FROM
    fact_gross_price  g
        JOIN
    fact_sales_monthly  s ON g.product_code = s.product_code
        JOIN
    dim_customer  c ON s.customer_code = c.customer_code
WHERE
    c.customer = 'Atliq Exclusive'
GROUP BY months , years; 



  
