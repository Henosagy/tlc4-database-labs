select * from titles 

select title, price from titles where price is null

select title, '20'::money as price from titles where price is null

select * from titles, coalesce(price, '20') as price

select * from pub_info, substring(pr_info, 1, 50) as edited

select pr_info::varchar(50) from pub_info pi2 

select to_char(current_timestamp, 'HH:MM:SS') 

select current_timestamp::varchar

select * from sales, to_char(ord_date, 'Day, DDth Month, YYYY') "Formatted Date"

select * from titles, to_char(pubdate, 'Day, DDth Month, YYYY') as "Formatted Date"

select current_date, current_time, current_timestamp

select '2018-09-26'::date as "Date", '2018-09-26'::timestamp as "Timestamp"

select to_date('2018-09-26', 'YYYY MM DD') as "Date", to_timestamp('2018-09-26', 'YYYY MM DD HH:MM:SS') as "Timestamp"

select ('2018-12-25'::date - '2018-09-26'::date) as "Days between 2018-12-25 and 2018-09-26"

select title, pubdate, current_date, (current_date - pubdate) as "Number of days elapsed" from titles

select title, extract(year from pubdate)::varchar as "Year of Publication", 
          extract(day from pubdate) as "Day of Publication" from titles 

----timestampdiff

select ord_date as "Old date",to_char((ord_date + (current_date - '2011-01-01'::date)), 'DD-MM-YYYY') 
    as "New Date" from sales

select ('2021-11-25'::date - current_date) as "Days to Thanksgiving", 
    ('2021-12-25'::date - current_date) as "Days to Christmas", 
    ('2022-01-01'::date - current_date) as "Days to New Years"

select (current_date - '1999-02-23'::date) as "Number of days old"

select title, pubdate, (current_date - pubdate) as "Days published" from titles 

select stor_id, ord_date, to_char(ord_date, 'DD/MM/YYYY') as "Formatted Date" from sales

select * from sales

select stor_id, to_char(ord_date, 'DD/MM/YYYY')  as "Publication date" from sales 
      order by abs(ord_date - '1999-02-23'::date) limit 1

select stor_id, ord_date from sales where ord_date <= '1999-02-23'::date order by ord_date desc limit 1

select pubdate, to_char(pubdate, 'DD/MM/YYYY') as "US Date Format",
                to_char(pubdate, 'MM/DD/YYYY') as "UK Date Format",
                to_char(pubdate, 'YYYY/MM/DD') as "Japan Date Format" from titles

select title, substring(title, 1, position(' ' in title)) as "firstword" from titles 

select abs(EXTRACT(EPOCH FROM '2018-03-02'::timestamp -'2018-02-01'::timestamp)/(3600) )

select (EXTRACT(EPOCH FROM '2018-03-02'::timestamp) - EXTRACT(EPOCH FROM '2018-02-01'::timestamp))/3600

SELECT ('2018-03-02'::timestamp - '2018-02-01'::timestamp) AS days


select *, replace (address, ' ', '--hello--') as "new address" from authors

select *, regexp_replace (address, ' ', '--hello--') as "new address" from authors


select * from titles, coalesce(price, round((random()*100)::numeric, 2)::money) new_prices;

select * from authors;

select *, substring(phone, position(' ' in phone)) as "only phone number" from authors;

select *, substring(au_lname, 1,1) || upper(substring(au_lname, 2,1)) || substring(au_lname,3) from authors;
