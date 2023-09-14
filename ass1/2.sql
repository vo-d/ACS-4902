DROP TABLE IF EXISTS DimensionDay;
-- Day dimension as shown in Figure 1-5
CREATE TABLE IF NOT EXISTS DimensionDay
(
    day_key serial primary key,
    full_date date ,
    month_name character varying(20) ,
    month_abbr character(3) ,
    quarter integer ,
    Year integer ,
    fiscal_period integer
);
-- the following needs modification for day range and for fiscal_period
with recursive days (fulldate) as
(
    values (to_date('1997-01-01','YYYYMMDD'))
    union
    select fulldate + integer '1' from days
    where fulldate < '1997-12-31'
)

insert into DimensionDay (full_date,month_name,month_abbr,quarter,year)
select fulldate, TO_CHAR (fulldate, 'Month') as month_name, TO_CHAR (fulldate, 'Mon') as month_abbr, extract (QUARTER from fulldate) as quarter, extract (YEAR from fulldate) as year
--
-- need to get the fiscal period too
--
from days;
select * from DimensionDay;