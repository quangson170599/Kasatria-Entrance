use Kasatria_Entrance

----1.
with cte as (
select o.*, r.Region
from Orders o
left join Region2 r on o.Country = r.Country)
select [Item type],Region,
sum([Units Sold] * cost) total_cost, sum([Units Sold] * price) total_revenue,
sum([Units Sold] * (price-cost)) total_profit
from cte
group by [Item type],Region

---2.
select count(*) as orders_of_Beverages
from Orders
where [Item Type] = 'Beverages'
and year([Order Date]) = '2011'

---3.
select * from
(select *,
rank() over(partition by [item Type] order by Max_profit desc) as rnk
from
(select [item Type],Country,
max([Units Sold] * (Price - Cost)) as Max_profit
from Orders
group by [item Type],Country) a) b
where rnk = 1

-----4.
with cte as (
select o.*, r.Region
from Orders o
left join Region2 r on o.Country = r.Country),
cte2 as (
select Region, datediff(day, [order Date], [Ship Date]) as delivery_time
from cte
where year([order Date]) = '2016')
select region, avg(delivery_time) as avg_delivery_time
from cte2
group by region
order by avg(delivery_time) desc

----5.
select *, 
rank() over(order by total_profit desc) rnk
from
(select [Item Type], sum(([Units Sold] * (Price - Cost))) as total_profit
from Orders
where month([Order Date])  = 1
group by [Item Type]) a

----6.
select * from
(select *, rank() over(order by total_profit desc) rnk 
from
(select Country, [Sales Channel],
sum([Units Sold] * (Price - Cost)) total_profit
from Orders
where [Sales Channel] = 'Online'
group by Country, [Sales Channel]) a) b
where b.rnk <= 5

--7






