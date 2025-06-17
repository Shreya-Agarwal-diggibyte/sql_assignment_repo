create table product_details (product_date date, product_name varchar(20));

Insert into product_details values ('2020-05-30', 'Headphones'),
('2020-06-01','Pencil'),
('2020-06-02','Mask'),
('2020-05-30','Basketball'),
('2020-06-01','Book'),
('2020-06-02', ' Mask '),
('2020-05-30','T-Shirt');

select * from product_details

'''select product_date as sell_date,count(Distinct product_name) as num_date
from (select distinct product_date,product_name from product_details)temp
group by product_date
order by product_date'''

SELECT 
    product_date AS sell_date,
    COUNT(DISTINCT product_name) AS num_sold,
    STUFF((
        SELECT DISTINCT ', ' + product_name
        FROM product_details AS pd
        WHERE pd.product_date = p.product_date
        FOR XML PATH(''), TYPE
    ).value('.', 'NVARCHAR(MAX)'), 1, 2, '') AS product_list
FROM 
    product_details AS p
GROUP BY 
    product_date
ORDER BY 
    product_date;
