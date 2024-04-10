/*Get the products that have the highest and lowest manufacturing costs.
The final output should contain these fields,
product_code
product
manufacturing_cost*/

SELECT 
    m.product_code,
    CONCAT(p.product, ' (', variant, ')') AS product,
    m.manufacturing_cost,
    m.cost_year
FROM
    fact_manufacturing_cost m
        JOIN
    dim_product p ON p.product_code = m.product_code
WHERE
    m.manufacturing_cost IN ((SELECT 
            MAX(manufacturing_cost)
        FROM
            fact_manufacturing_cost) , (SELECT 
                MIN(manufacturing_cost)
            FROM
                fact_manufacturing_cost))
ORDER BY m.manufacturing_cost DESC;



