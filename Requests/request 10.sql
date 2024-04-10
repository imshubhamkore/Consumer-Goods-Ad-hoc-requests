/*Get the Top 3 products in each division that have a high
total_sold_quantity in the fiscal_year 2021? The final output contains these
fields,
division
product_code
product
total_sold_quantity
rank_order*/  

WITH temp_table AS (
    select division, s.product_code, concat(p.product,"(",p.variant,")") AS product , sum(sold_quantity) AS total_sold_quantity,
    rank() OVER (partition by division order by sum(sold_quantity) desc) AS rank_order
 FROM
 fact_sales_monthly s
 JOIN dim_product p
 ON s.product_code = p.product_code
 WHERE fiscal_year = 2021
 GROUP BY p.product_code
)
SELECT * FROM temp_table
WHERE rank_order IN (1,2,3);

WITH ProductRanks AS (
  SELECT
    p.division,
    p.product_code,
    p.product,
    SUM(s.sold_quantity * g.gross_price) AS total_gross_sales,
    RANK() OVER (PARTITION BY p.division ORDER BY SUM(s.sold_quantity * g.gross_price) DESC) AS rank_order
  FROM
    dim_product AS p
    JOIN fact_sales_monthly AS s ON p.product_code = s.product_code
    JOIN fact_gross_price AS g ON p.product_code = g.product_code
  WHERE
    YEAR(s.date) = 2021
  GROUP BY
    p.division, p.product_code, p.product
)
SELECT
  division,
  product_code,
  product,
  total_gross_sales,
  rank_order
FROM ProductRanks
WHERE rank_order <= 3;