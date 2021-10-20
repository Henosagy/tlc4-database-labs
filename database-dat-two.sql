select type, pubdate from titles order by type;

-- Get average prices from the titles table for each type of book, and convert type to char(30).
select type::char(30), avg(coalesce(price, '0')::numeric) from titles
group by type;

-- Print the difference between (to a resolution of days) the earliest and latest publication date in titles
select max(pubdate)-min(pubdate) as "difference in number of days" from titles;

-- Print the average, min and max book prices within the titles table organised into groups based on type and publisher id
select type, pub_id, avg(coalesce(price, '0')::numeric) as "average price", min(coalesce(price, '0')::numeric) as "min price", max(coalesce(price, '0')::numeric) as "max price"  
from titles
group by type, pub_id
having avg(coalesce(price, '0')::numeric) > 20
order by "average price";

-- List the books in order of the length of their title
select title  from titles
order by length(title);

-- What is the average age in months of each type of title?
select type, avg(extract(year from age(pubdate))*12  + extract(month from age(pubdate)))
from titles
group by type
order by type;

-- How many authors live in each city?
select city, count(city) from authors
group by city
order by count(city);

-- What is the longest title?
select title, length(title) from titles
order by length(title) desc limit 1 ;

-- How many books have been sold by each store
select stor_id, sum(qty) from sales
group by stor_id;

-- How many books have been sold in total
select sum(qty) from sales;

-- Join the publishers and pub_info and show the publisher name and the first 40 characters of the pr_info information.
select p.pub_name as "Publisher name", substring(pi2.pr_info, 1, 40) as "First 40 characters" 
from publishers p inner join pub_info pi2 
on p.pub_id = pi2.pub_id 

-- Join the publishers and titles tables to show all titles published by each publisher. 
-- Display the pub_id, pub_name and and title_id.
select p.pub_id as "Publication ID", p.pub_name as "Publisher Name", t.title_id  as "Title ID"
from publishers p 
inner join titles t on p.pub_id = t.pub_id 

-- For each title_id in the table titles, rollup the corresponding qty in sales and show:
-- title_id, title, ord_num and the rolled-up value as a column aggregate called Total Sold
select t.title_id as "Title ID", t.title as "Title Name", s.ord_num as "Order Number" , s.qty as "Total Sold"
from titles t inner join sales s  on t.title_id = s.title_id 
order by t.title_id 

select t.title_id as "Title ID", t.title as "Title Name", s.ord_num as "Order Number" , sum(s.qty) as "Total Sold"
from titles t inner join sales s  on t.title_id = s.title_id 
group by t.title_id, s.ord_num 
order by t.title_id 

select title_id, ord_num, qty from sales
order by title_id 

-- For each stor_id in stores, show the corresponding ord_num in sales and the discount type from table discounts
-- The output should consist of three columns: ord_num, discount and discounttype and should be sorted on ord_num
select s.stor_id, s2.ord_num, d.discount, d.discounttype
from stores s 
inner join sales s2 on s.stor_id = s2.stor_id 
inner join discounts d on s2.stor_id = d.stor_id 
order by s2.ord_num 

-- Show au_lname from authors, and pub_name from publishers when both publisher and author live in the same city.
select a.au_fname || ' ' || a.au_lname as "Author's name", p.pub_name as "Publisher's Name", 
a.city as "Author's city", p.city as "Publisher's city"
from authors a inner join publishers p on a.city = p.city 

-- Refine 5 so that for each author you show all publishers who live in the same city and have 
-- published one of the authors titles.
select a.au_fname || ' ' || a.au_lname as "Author's name", p.pub_name as "Publisher's Name", 
a.city as "Author's city", p.city as "Publisher's city"
from authors a inner join publishers p on a.city = p.city 
inner join pub_info pi2 on p.pub_id = pi2.pub_id 

select pi2.pub_id, p.pub_id, p.pub_name, p.city,a.au_fname, a.au_lname 
from pub_info pi2 
inner join publishers p on pi2.pub_id = p.pub_id 
inner join authors a on a.city = p.city 

-- Refine 1 so that an outer join is performed. All of the publishers from the first table should be shown, 
-- not just those with pr_info information in pub_info. You should use the ANSI SQL92 syntax.
select p.pub_name as "Publisher name", substring(pi2.pr_info, 1, 40) as "First 40 characters" 
from publishers p full outer join pub_info pi2 
on p.pub_id = pi2.pub_id 


-- List each publisher's name, the title of each book they have sold and the total quantity of that title.
select p.pub_name as "Publisher name", t.title as "Title of book", sum(s.qty) as "Quantity sold"
from publishers p 
inner join titles t on p.pub_id = t.pub_id 
inner join sales s on s.title_id = t.title_id 
group by p.pub_name, t.title_id 
order by p.pub_name 

-- How many books have been published by each publisher?
select p.pub_name as "Publisher's name", sum(t.ytd_sales) as "Books Published"
from publishers p inner join titles t on p.pub_id = t.pub_id 
group by p.pub_name 

-- How many different types of book has each publisher published?
select p.pub_name as "Publisher's name", count(distinct(t.title)) as "Books "
from publishers p inner join titles t on p.pub_id = t.pub_id 
group by p.pub_name 


-- What is the average royalty percentage payed to each author?
select a.au_fname || ' ' || a.au_lname as "Author's name",
avg(r.royalty) as "Average royalty paid"
from  authors a
inner join titleauthor t2  on a.au_id = t2.au_id 
inner join roysched r on r.title_id = t2.title_id
group by a.au_id 
order by a.au_id 

-- For each store list which authors have had their books sold through that store.
select s.stor_name as "Store Name" , a.au_fname || ' ' || a.au_lname as "Author's name"
from stores s 
inner join sales s2 on s.stor_id = s2.stor_id 
inner join titleauthor t2 on t2.title_id = s2.title_id 
inner join authors a on a.au_id = t2.au_id 
