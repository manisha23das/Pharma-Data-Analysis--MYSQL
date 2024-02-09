use pharma_db
-- 1
select `Customer Name` from pharma 
where `Sub-channel`='Retail'

-- 2. Find the total quantity sold for the ' Antibiotics' product class//ans-1127243.
select sum(Quantity) as total_qty_of_antibiotics from pharma 
where `Product Class` =  'Antibiotics'

-- 3. List all the distinct months present in the dataset.
select distinct Month from pharma

-- 4. Calculate the total sales for each year.
select Year,sum(Sales) as total_sales from pharma group by Year;

-- 5. Find the customer with the highest sales value.
select `Customer Name`,Sales from pharma where Sales = (select max(Sales) from pharma)

-- 6. Get the names of all employees who are Sales Reps and are managed by 'James Goodwill'
select  `Name of Sales Rep` from pharma where Manager='James Goodwill' 

-- 7. Retrieve the top 5 cities with the highest sales.
-- select Country,sum(Sales) as total_sales from pharma group by Country order by total_sales desc limit 5

-- 8. Calculate the average price of products in each sub-channel.
select `Sub-channel`, avg(Price) as avg_price_of_products from pharma group by `Sub-channel`

-- 9. Retrieve all sales of product 'Diaxolol' in the year 2018.
SELECT *FROM pharma WHERE `Product Name`='Diaxolol' and `Year` = 2018;

-- 10. Calculate the total sales for each product class, for each month, and 
-- order the results by year, month, and product class.
select `Product Class`,Month,Year,sum(Sales) as total_sales from pharma group by `Product Class`,Month, Year
order by Year,Month,`Product Class`

-- 11. Find the top 3 sales reps with the highest sales in 2019.
select `Name of Sales Rep`,sum(Sales) as total_sales from pharma where Year=2019 group by `Name of Sales Rep` 
order by total_sales desc limit 3

-- 12. Calculate the monthly total sales for each sub-channel, and then calculate the average
-- monthly sales for each sub-channel over the years.
select `Sub-channel`,Month,sum(Sales) as total_monthly_sales, avg(Sales) as avg_monthly_sales from pharma 
group by `Sub-channel`,Month

-- 13. Create a summary report that includes the total sales, average price, and total quantity
-- sold for each product class
select `Product Class`, sum(Sales) as total_sales,avg(Price) as avg_price,sum(Quantity) as total_qty from pharma 
group by `Product Class`

-- 14. Find the top 5 customers with the highest sales for each year.
with highest_sales as 
(select `Customer Name`,Year,sum(Sales) as total_sales,
row_number() over(partition by Year order by sum(Sales) desc ) as row_num from pharma 
group by `Customer Name`,Year)
select * from highest_sales  where row_num<6 

-- 15. Calculate the year-over-year growth in sales for each country.
with YOY as
(select Country,Year,sum(Sales) as total_sales,lag(sum(Sales)) over(partition by Country order by Year) as prev_sales
from pharma group by Country,Year)
select Country,Year,(total_sales-prev_sales)/prev_sales*100 as YOY_sales
from YOY
order by Country,Year


-- 16. List the months with the lowest sales for each year
with lowest_sales as 
(select Month,Year,sum(Sales) as total_sales,
row_number() over(partition by Year order by sum(Sales) asc) as row_num from pharma 
group by Month,Year)
select Month,Year,total_sales from lowest_sales  where row_num=1 

-- 17. Calculate the total sales for each sub-channel in each country  
select `Sub-channel`,Country,sum(Sales) as total_sales from pharma 
group by `Sub-channel`,Country

-- 18.find the country with the highest total sales for each sub-channel.
with highest_sales as 
(select Country,`Sub-channel`,sum(Sales) as total_sales,
row_number() over(partition by `Sub-channel` order by sum(Sales) desc ) as row_num from pharma 
group by `Sub-channel`,Country)
select * from highest_sales  where row_num=1 








