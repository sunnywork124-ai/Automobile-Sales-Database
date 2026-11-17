-- show sales trends for various brands over the past 3 years, by year, month, week
select b.name as brand_name, year(v.sale_date) as sale_year,
month(v.sale_date) as sale_month, week(v.sale_date) as sale_week,
count(v.vin) as unit_sales, sum(v.sale_price) as total_sales
from vehicle v
join model m on m.model_id = v.model_id
join brand b on b.brand_id = m.brand_id
where v.status = 'Sold'
and v.sale_date >= '2024-01-01'
group by b.name, year(v.sale_date), month(v.sale_date), week(v.sale_date)
order by sale_year desc, sale_month desc, sale_week desc;

-- break sales data out by gender of the buyer and then by income range
select b.name as brand_name, c.gender,
case
    when c.annual_income < 2000000 then 'Below 20 Lakhs'
    when c.annual_income between 2000000 and 4000000 then '20 to 40 Lakhs'
    else 'Above 40 Lakhs'
end as income_range,
count(v.vin) as unit_sales, sum(v.sale_price) as total_sales
from vehicle v
join model m on m.model_id = v.model_id
join brand b on b.brand_id = m.brand_id
join customer c on c.c_id = v.c_id
where v.status = 'Sold'
and v.sale_date >= '2024-01-01'
group by b.name, c.gender, income_range
order by b.name, total_sales desc;

-- find the VIN and customer of each car containing a defective transmission made by supplier 
-- Getrag between two given dates from Getrag's Pune plant
select v.vin, c.c_id, c.name as customer_name, c.phone,
p.name as part_name, p.mfg_date, s.name as supplier_name, s.plant_city
from vehicle v
join customer c on c.c_id = v.c_id
join part p on p.part_id = v.part_id
join supplier s on s.supplier_id = p.supplier_id
where s.name = 'Getrag'
and s.plant_city = 'Pune'
and p.type = 'Transmission'
and p.mfg_date between '2026-02-01' and '2026-02-28';

-- find the top 2 brands by dollar-amount sold in the past year
select b.brand_id, b.name as brand_name, sum(v.sale_price) as total_dollar_amount
from vehicle v
join model m on m.model_id = v.model_id
join brand b on b.brand_id = m.brand_id
where v.status = 'Sold'
and v.sale_date >= '2026-01-01'
group by b.brand_id, b.name
order by total_dollar_amount desc
limit 2;

-- find the top 2 brands by unit sales in the past year
select b.brand_id, b.name as brand_name, count(v.vin) as total_unit_sales
from vehicle v
join model m on m.model_id = v.model_id
join brand b on b.brand_id = m.brand_id
where v.status = 'Sold'
and v.sale_date >= '2026-01-01'
group by b.brand_id, b.name
order by total_unit_sales desc
limit 2;

-- in what month(s) do convertibles sell best?
select monthname(v.sale_date) as sale_month, count(v.vin) as convertibles_sold
from vehicle v
join model m on m.model_id = v.model_id
where v.status = 'Sold'
and m.body_style = 'Convertible'
group by month(v.sale_date), monthname(v.sale_date)
order by convertibles_sold desc
limit 1;

-- find those dealers who keep a vehicle in inventory for the longest average time
select d.dealer_id, d.name as dealer_name, d.city,
avg(datediff(ifnull(v.sale_date, '2026-11-17'), v.arrival_date)) as avg_days_in_inventory
from dealer d
join vehicle v on v.dealer_id = d.dealer_id
group by d.dealer_id, d.name, d.city
order by avg_days_in_inventory desc;