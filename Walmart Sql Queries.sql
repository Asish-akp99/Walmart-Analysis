CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT  NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATE NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT,
    gross_income DECIMAL(12, 4),
    rating FLOAT
);
 select * from sales
 
-- Add the time_of_day column

ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);

UPDATE sales
SET time_of_day = (
	CASE
		WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END
);
__ Add the day_name column

ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

Update sales
set day_name = to_char(date, 'Day')

__ add the month_name column

Alter table sales add column month_name varchar(15);

update sales 
set month_name = to_char(date, 'Month')

/* How many unique cities does the data have? */

Select count(distinct city) from sales

/* How many unique product lines does the data have? */

select count(distinct product_line)
from sales

/* Which is the most common payment method? */

select payment,
count(*) as no_of_payment
from sales
group by payment
order by no_of_payment desc
limit 1

/* What is the most selling product line? */

select product_line,
sum(quantity) as total_quantity
from sales
group by product_line
order by total_quantity desc
limit 1

/* What is the total revenue by month? */

select Month_name,
sum(total) as revenue_by_month
from sales
group by Month_name

/* What month had the largest COGS? */

select Month_name,
sum(cogs) as largest_cogs
from sales
group by Month_name
order by largest_cogs desc
limit 1

/* What product line had the largest revenue? */

select product_line,
sum(total) as total_revenue
from sales
group by product_line
order by total_revenue desc
limit 1

/* What is the city with the largest revenue? */

select city,
sum(total) as totalcity_revenue
from sales
group by city
order by totalcity_revenue
limit 1

--What product line had the largest VAT?

select product_line,
(avg(tax_pct), 2) as Vat
from sales
group by product_line
order by Vat
limit 1

-- Which branch sold more products than average product sold?
SELECT 
	branch, 
    SUM(quantity) AS qnty
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);

-- What is the most common product line by gender
SELECT
	gender,
    product_line,
    COUNT(gender) AS total_cnt
FROM sales
GROUP BY gender, product_line
ORDER BY total_cnt DESC;

-- What is the average rating of each product line
SELECT 
	AVG(rating) as avg_rating,
    product_line
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;


-------------------------------------------- 
Customers
--------------------------------------------


-- How many unique customer types does the data have?

SELECT
count(distinct customer_type)
FROM sales;

-- How many unique payment methods does the data have?
SELECT
count(distinct payment)
FROM sales;

-- What is the most common customer type?
SELECT
	customer_type,
	count(*) as cnt
FROM sales
GROUP BY customer_type
ORDER BY cnt DESC;

-- Which customer type buys the most?
SELECT
	customer_type,
    COUNT(*)
FROM sales
GROUP BY customer_type;

-- What is the gender of most of the customers?
SELECT
	gender,
	COUNT(*) as gender_cnt
FROM sales
GROUP BY gender
ORDER BY gender_cnt DESC;

-- Which time of the day do customers give most ratings?
SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Which time of the day do customers give most ratings per branch?
SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Which day fo the week has the best avg ratings?
SELECT
	day_name,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY day_name 
ORDER BY avg_rating DESC;


-- Which day of the week has the best average ratings per branch?
SELECT 
	day_name,
	COUNT(day_name) total_sales
FROM sales
GROUP BY day_name
ORDER BY total_sales DESC;


-------------------------------------------------
sales
-------------------------------------------------

-- Number of sales made in each time of the day per weekday 
SELECT
	time_of_day,
	COUNT(*) AS total_sales
FROM sales
where day_name not in ('saturday' , 'sunday')
GROUP BY time_of_day 
ORDER BY total_sales DESC;

-- Which of the customer types brings the most revenue?
SELECT
	customer_type,
	SUM(total) AS total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue;
Limit 1

-- Which city has the largest tax/VAT percent?
SELECT
	city,
    sum(tax_pct) AS avg_tax_pct
FROM sales
GROUP BY city 
ORDER BY avg_tax_pct DESC;

-- Which customer type pays the most in VAT?
SELECT
	customer_type,
	sum(tax_pct) AS total_tax
FROM sales
GROUP BY customer_type
ORDER BY total_tax;

-----------------------------
END
-----------------------------





 

