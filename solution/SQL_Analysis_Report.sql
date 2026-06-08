use practice;
select * from market;

select Country, 
round(sum(`2023.0`),1)
from market 
where `Data Type` = 'Retail Value RSP'
group by Country;


select m.Country,
sum(m.`2023.0`) / p.`Population, 2023 (million)` as per_capita
from market m 
join population p 
on m.Country = p.Country
where m.`Data Type` = 'Retail Value RSP'
Group by m.Country, p.`Population, 2023 (million)`;

select m.Country,
sum(m.`2023.0`) / p.`Population, 2023 (million)` as per_capita,
rank() over(order by sum(m.`2023.0`) / p.`Population, 2023 (million)` Desc) as ranking
from market m 
join population p 
on m.Country = p.Country
where m.`Data Type` = 'Retail Value RSP'
Group by m.Country, p.`Population, 2023 (million)`;

select distinct Country, Region
from market;

select Country, Region, 
round(sum(`2023.0`),2) as total_beauty_value_2023
from market
where Industry = 'Beauty and Personal Care' and `Data Type`= 'Retail Value RSP'
group by Country, Region;

select Country, Region, 
round(sum(`2023.0`),2) as total_beauty_volume_2023
from market
where Industry = 'Beauty and Personal Care' and `Data Type`= 'Retail Volume'
group by Country, Region;

select m.Country, 
round(sum(m.`2023.0`),2) as total_beauty_value_2023,
round(sum(m.`2023.0`)/p.`Population, 2023 (million)`,3)as per_capita
from market m
join population p
on m.Country = p.Country
where m.Industry = 'Beauty and Personal Care' and m.`Data Type`= 'Retail Value RSP'
group by m.Country, p.`Population, 2023 (million)`;

select m.Country,
sum(m.`2023.0`)/p.`Population, 2023 (million)` as per_capita,
rank() over(order by sum(m.`2023.0`)/p.`Population, 2023 (million)`Desc )as ranking
from market m 
join population p 
on m.Country = p.Country 
where m.Industry = 'Beauty and Personal Care' and m.`Data Type` = 'Retail Value RSP'
group by m.country, 
p.`Population, 2023 (million)`;


select m.Country,
m.Region,
round(sum(m.`2023.0`)/p.`Population, 2023 (million)`,3) as per_capita,
rank() over(order by sum(m.`2023.0`)/p.`Population, 2023 (million)`desc)as ranking
from market m
join population p
on m.Country = p.Country
where m.Industry= 'Beauty and Personal Care' and m.`Data Type` = 'Retail Value RSP'
group by m.Country , m.Region,
p.`Population, 2023 (million)`;

select m.Country, f.`Local Currency`,
round(sum(m.`2023.0`),2) as usd_value,
round(sum(m.`2023.0`) / f.`USD per 1 LCU (2023)`,3) as local_currency_value
from market m
join fx f
on m.Country = f.Country
where m.Industry = 'Beauty and Personal Care' and m.`Data Type` ='Retail Value RSP'
group by m.Country, f.`Local Currency`,f.`USD per 1 LCU (2023)`;

select Country, Sum(`2023.0`) as total_value
from market
where `Data Type` = 'Retail Value RSP'
group by  Country 
order by total_value DESC
limit 5;

select m.Country, m.Region, f.`Local Currency`,
sum(Case when m.`Data Type`= 'Retail Value RSP' then m.`2023.0` else 0 end
) as total_retail_value_2023,
sum(Case when m.`Data Type`= 'Retail Volume' then m.`2023.0` else 0 end
) as total_retail_volume_2023,
p.`Population, 2023 (million)`,
sum(case when m.`Data Type`='Retail Value RSP' then m.`2023.0` end) / p.`Population, 2023 (million)` as per_capita,
sum(case when m.`Data Type`= 'Retail Value RSP' then m.`2023.0` end)/f.`USD per 1 LCU (2023)` as local_currency_value,
rank() over(order by sum(case when m.`Data Type`='Retail value RSP' then m.`2023.0` else 0 end) / p.`Population, 2023 (million)` desc) as ranking
from market m
join population p 
on m.Country = p.Country
join fx f
on m.Country = f.Country
where m.Country in('USA','China','Germany','United Kingdom','Japan','France','India','Brazil','Italy','Spain')
and m.Industry='Beauty and Personal Care'
group by m.Country,m.Region,p.`Population, 2023 (million)`,
f.`Local Currency`, f.`USD per 1 LCU (2023)`
