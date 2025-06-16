Create table sales_dataa(product_id int , sale_date date, quantity_sold int)

Insert into sales_dataa values(1, '2022-01-01', 20),
   		(2, '2022-01-01', 15),
   		(1, '2022-01-02', 10),
    		(2, '2022-01-02', 25),
    		(1, '2022-01-03', 30),
    		(2, '2022-01-03', 18),
            (1, '2022-01-04', 12),
    	(2, '2022-01-04', 22)





SELECT 
    product_id,
    sale_date,
    quantity_sold,
    RANK() OVER (PARTITION BY product_id ORDER BY sale_date DESC) AS rank
FROM 
    sales_dataa;