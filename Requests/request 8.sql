/*In which quarter of 2020, got the maximum total_sold_quantity? The final
output contains these fields sorted by the total_sold_quantity,
Quarter
total_sold_quantity*/

SELECT 
CASE
    WHEN date BETWEEN '2019-09-01' AND '2019-11-01' then "Q1"  
    WHEN date BETWEEN '2019-12-01' AND '2020-02-01' then "Q2"
    WHEN date BETWEEN '2020-03-01' AND '2020-05-01' then "Q3"
    WHEN date BETWEEN '2020-06-01' AND '2020-08-01' then "Q4"
    END AS Quarters,
    round(sum(sold_quantity)/1000000,2) as total_sold_quanity_in_millions
FROM fact_sales_monthly
WHERE fiscal_year = 2020
GROUP BY Quarters
ORDER BY total_sold_quanity_in_millions DESC;


WITH temp_table AS (
  SELECT date,month(date_add(date,interval 4 month)) AS period, fiscal_year,sold_quantity 
FROM fact_sales_monthly
)
SELECT CASE 
   when period/3 <= 1 then "Q1"
   when period/3 <= 2 and period/3 > 1 then "Q2"
   when period/3 <=3 and period/3 > 2 then "Q3"
   when period/3 <=4 and period/3 > 3 then "Q4" END quarter,
 round(sum(sold_quantity)/1000000,2) as total_sold_quanity_in_millions FROM temp_table
WHERE fiscal_year = 2020
GROUP BY quarter
ORDER BY total_sold_quanity_in_millions DESC ;