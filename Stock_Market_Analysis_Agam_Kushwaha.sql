-- ----------------------------------------------------------------------------------------------------------------
--											Stock Market Analysis
-- ----------------------------------------------------------------------------------------------------------------
-- Creating a Database "Assignment":
create database Assignment;

-- Using the database "Assignment":
use Assignment;

-- Created new 6 tabals with the name of the stocks. Used "Tabe Data Import Wizard" for this. Below are the names:
	-- 1. bajaj_auto
	-- 2. eicher_motors
	-- 3. hero_motocorp
	-- 4. infosys
	-- 5. tcs
	-- 6. tvs_motors

-- Checking fields of all the created tables:
select * from bajaj_auto;
select * from eicher_motors;
select * from hero_motocorp;
select * from infosys;
select * from tcs;
select * from tvs_motors;

-- Verifying count of rows of each table. It is 889 for all the tables:
select count(*) from bajaj_auto;
select count(*) from eicher_motors;
select count(*) from hero_motocorp;
select count(*) from infosys;
select count(*) from tcs;
select count(*) from tvs_motors;

-- The column "Date" is in "String" type. Changing it to "Date" Data Type in all the tables:
update `bajaj_auto` SET `date` = str_to_date( `date`, '%d-%M-%Y');
update `eicher_motors` SET `date` = str_to_date( `date`, '%d-%M-%Y');
update `hero_motocorp` SET `date` = str_to_date( `date`, '%d-%M-%Y');
update `infosys` SET `date` = str_to_date( `date`, '%d-%M-%Y');
update `tcs` SET `date` = str_to_date( `date`, '%d-%M-%Y');
update `tvs_motors` SET `date` = str_to_date( `date`, '%d-%M-%Y');

-- Question 1: Create a new table named 'bajaj1' containing the date, close price, 20 Day MA and 50 Day MA. 
--             (This has to be done for all 6 stocks)

-- Solution:

-- Creating table "bajaj1":
create table bajaj1 as (
select `Date`, `Close Price`,
round(avg(`Close Price`) over (order by Date rows 19 preceding), 2) as "20 Days MA",
round(avg(`Close Price`) over (order by Date rows 49 preceding), 2) as "50 Days MA"
from bajaj_auto
order by Date
);

-- Creating table "eicher1":

create table eicher1 as (
select `Date`, `Close Price`,
round(avg(`Close Price`) over (order by Date rows 19 preceding), 2) as "20 Days MA",
round(avg(`Close Price`) over (order by Date rows 49 preceding), 2) as "50 Days MA"
from eicher_motors
order by Date);

-- Creating table "hero1":
create table hero1 as (
select `Date`, `Close Price`,
round(avg(`Close Price`) over (order by Date rows 19 preceding), 2) as "20 Days MA",
round(avg(`Close Price`) over (order by Date rows 49 preceding), 2) as "50 Days MA"
from hero_motocorp
order by Date);

-- Creating table "infosys1":
create table infosys1 as (
select `Date`, `Close Price`,
round(avg(`Close Price`) over (order by Date rows 19 preceding), 2) as "20 Days MA",
round(avg(`Close Price`) over (order by Date rows 49 preceding), 2) as "50 Days MA"
from infosys
order by Date);

-- Creating table "tcs1":
create table tcs1 as (
select `Date`, `Close Price`,
round(avg(`Close Price`) over (order by Date rows 19 preceding), 2) as "20 Days MA",
round(avg(`Close Price`) over (order by Date rows 49 preceding), 2) as "50 Days MA"
from tcs
order by Date);

-- Creating table "tvs1":
create table tvs1 as (
select `Date`, `Close Price`,
round(avg(`Close Price`) over (order by Date rows 19 preceding), 2) as "20 Days MA",
round(avg(`Close Price`) over (order by Date rows 49 preceding), 2) as "50 Days MA"
from tvs_motors
order by Date);

-- Cheking fields of all the newly created tables:
select * from bajaj1;
select * from eicher1;
select * from hero1;
select * from infosys1;
select * from tcs1;
select * from tvs1;


-- Question 2: Create a master table containing the date and close price of all the six stocks.
--             (Column header for the price is the name of the stock)

-- Solution: Creating Master table. Joining all the newly created tables on "Date" column:

create table master_table as (
select bajaj_auto.`date` as Date, bajaj_auto.`Close Price` as Bajaj, tcs.`Close Price` as TCS,  
tvs_motors.`Close Price` as TVS, infosys.`Close Price` as Infosys, eicher_motors.`Close Price` as Eicher, 
hero_motocorp.`Close Price` as Hero from bajaj_auto
inner join eicher_motors
using (Date)
inner join hero_motocorp
using (Date)
inner join infosys
using (Date)
inner join tcs
using (Date)
inner join tvs_motors
using (Date)
order by `Date`);

-- Viewing the master table created:

select * from master_table;

-- Question 3: Use the table created in Part(1) to generate buy and sell signal. 
--             Store this in another table named 'bajaj2'. Perform this operation for all stocks.

-- Solution: So, here we have to create below 6 tables:
	-- bajaj2
	-- eicher2
	-- hero2
	-- infosys2
	-- tcs2
	-- tvs2

-- Creating table "bajaj2":
create table bajaj2 as (
select `Date`, `Close Price`,
	case 
		when `20 Day MA` > `50 Day MA` and (lag(`20 Day MA`, 1) over ()) <  (lag(`50 Day MA`, 1) over ())
			then 'Buy'
		when `20 Day MA` < `50 Day MA` and (lag(`20 Day MA`, 1) over ()) >  (lag(`50 Day MA`, 1) over ())
			then 'Sell'
		else
			'Hold'
	end as 'Signal'
    from bajaj1
);

-- Creating table "eicher2":
create table eicher2 as (
select `Date`, `Close Price`,
	case 
		when `20 Day MA` > `50 Day MA` and (lag(`20 Day MA`, 1) over ()) <  (lag(`50 Day MA`, 1) over ())
			then 'Buy'
		when `20 Day MA` < `50 Day MA` and (lag(`20 Day MA`, 1) over ()) >  (lag(`50 Day MA`, 1) over ())
			then 'Sell'
		else
			'Hold'
	end as 'Signal'
    from eicher1
);

-- Creating table "hero2":
create table hero2 as (
select `Date`, `Close Price`,
	case 
		when `20 Day MA` > `50 Day MA` and (lag(`20 Day MA`, 1) over ()) <  (lag(`50 Day MA`, 1) over ())
			then 'Buy'
		when `20 Day MA` < `50 Day MA` and (lag(`20 Day MA`, 1) over ()) >  (lag(`50 Day MA`, 1) over ())
			then 'Sell'
		else
			'Hold'
	end as 'Signal'
    from hero1
);

-- Creating table "infosys2":
create table infosys2 as (
select `Date`, `Close Price`,
	case 
		when `20 Day MA` > `50 Day MA` and (lag(`20 Day MA`, 1) over ()) <  (lag(`50 Day MA`, 1) over ())
			then 'Buy'
		when `20 Day MA` < `50 Day MA` and (lag(`20 Day MA`, 1) over ()) >  (lag(`50 Day MA`, 1) over ())
			then 'Sell'
		else
			'Hold'
	end as 'Signal'
    from infosys1
);

-- Creating table "tcs2":
create table tcs2 as (
select `Date`, `Close Price`,
	case 
		when `20 Day MA` > `50 Day MA` and (lag(`20 Day MA`, 1) over ()) <  (lag(`50 Day MA`, 1) over ())
			then 'Buy'
		when `20 Day MA` < `50 Day MA` and (lag(`20 Day MA`, 1) over ()) >  (lag(`50 Day MA`, 1) over ())
			then 'Sell'
		else
			'Hold'
	end as 'Signal'
    from tcs1
);

-- Creating table "tvs2":
create table tvs2 as (
select `Date`, `Close Price`,
	case 
		when `20 Day MA` > `50 Day MA` and (lag(`20 Day MA`, 1) over ()) <  (lag(`50 Day MA`, 1) over ())
			then 'Buy'
		when `20 Day MA` < `50 Day MA` and (lag(`20 Day MA`, 1) over ()) >  (lag(`50 Day MA`, 1) over ())
			then 'Sell'
		else
			'Hold'
	end as 'Signal'
    from tvs1
);

-- Viewing all the new tables:
select * from bajaj2;
select * from eicher2;
select * from hero2;
select * from infosys2;
select * from tcs2;
select * from tvs2;

-- Question 4. Create a User defined function, that takes the date as input and returns the signal for that 
--             particular day (Buy/Sell/Hold) for the Bajaj stock.

-- Solution: Creating a user-defined Function "tradeSignalForBajaj for Bajaj Stock":

delimiter $$
create function tradeSignalForBajaj (tradeDate date)
returns varchar (25) deterministic

begin
	declare tradeSignal varchar (25);
    set tradeSignal = (select `Signal`from bajaj2 where `Date` = tradeDate);
    return tradeSignal;
end; $$
delimiter ;

-- Getting output of the function by providing input date:
select tradeSignalForBajaj('2015-05-18') as `Signal`; -- Output - 'Buy'
select tradeSignalForBajaj('2017-08-07') as `Signal`; -- Output - 'Buy'
select tradeSignalForBajaj('2017-04-20') as `Signal`; -- Output - 'Sell'
select tradeSignalForBajaj('2018-02-06') as `Signal`; -- Output - 'Sell'
select tradeSignalForBajaj('2015-01-05') as `Signal`; -- Output - 'Hold'
select tradeSignalForBajaj('2018-07-27') as `Signal`; -- Output - 'Hold'

-- Creating a user-defined Function "tradeSignalForEicher for Eicher Stock":

delimiter $$
create function tradeSignalForEicher (tradeDate date)
returns varchar (25) deterministic

begin
	declare tradeSignal varchar (25);
    set tradeSignal = (select `Signal`from eicher2 where `Date` = tradeDate);
    return tradeSignal;
end; $$
delimiter ;

select tradeSignalForEicher('2017-01-16') as `Signal`; -- Output - 'Buy'
select tradeSignalForEicher('2016-11-15') as `Signal`; -- Output - 'Sell'
select tradeSignalForEicher('2015-01-07') as `Signal`; -- Output - 'Hold'


-- Creating a user-defined Function "tradeSignalForHero for Hero Stock":

delimiter $$
create function tradeSignalForHero (tradeDate date)
returns varchar (25) deterministic

begin
	declare tradeSignal varchar (25);
    set tradeSignal = (select `Signal`from hero2 where `Date` = tradeDate);
    return tradeSignal;
end; $$
delimiter ;

select tradeSignalForHero('2016-03-01') as `Signal`; -- Output - 'Buy'
select tradeSignalForHero('2018-02-06') as `Signal`; -- Output - 'Sell'
select tradeSignalForHero('2015-01-13') as `Signal`; -- Output - 'Hold'


-- Creating a user-defined Function "tradeSignalForInfosys for Infosys Stock":

delimiter $$
create function tradeSignalForInfosys (tradeDate date)
returns varchar (25) deterministic

begin
	declare tradeSignal varchar (25);
    set tradeSignal = (select `Signal`from infosys2 where `Date` = tradeDate);
    return tradeSignal;
end; $$
delimiter ;

select tradeSignalForInfosys('2016-12-22') as `Signal`; -- Output - 'Buy'
select tradeSignalForInfosys('2017-06-30') as `Signal`; -- Output - 'Sell'
select tradeSignalForInfosys('2016-10-27') as `Signal`; -- Output - 'Hold'


-- Creating a user-defined Function "tradeSignalForTcs for TCS Stock":

delimiter $$
create function tradeSignalForTcs (tradeDate date)
returns varchar (25) deterministic

begin
	declare tradeSignal varchar (25);
    set tradeSignal = (select `Signal`from tcs2 where `Date` = tradeDate);
    return tradeSignal;
end; $$
delimiter ;

select tradeSignalForTcs('2018-01-15') as `Signal`; -- Output - 'Buy'
select tradeSignalForTcs('2017-09-19') as `Signal`; -- Output - 'Sell'
select tradeSignalForTcs('2015-01-05') as `Signal`; -- Output - 'Hold'

-- Creating a user-defined Function "tradeSignalForTvs for TVS Stock":

delimiter $$
create function tradeSignalForTvs (tradeDate date)
returns varchar (25) deterministic

begin
	declare tradeSignal varchar (25);
    set tradeSignal = (select `Signal`from tvs2 where `Date` = tradeDate);
    return tradeSignal;
end; $$
delimiter ;

select tradeSignalForTvs('2017-01-06') as `Signal`; -- Output - 'Buy'
select tradeSignalForTvs('2018-01-29') as `Signal`; -- Output - 'Sell'
select tradeSignalForTvs('2015-03-12') as `Signal`; -- Output - 'Hold'
