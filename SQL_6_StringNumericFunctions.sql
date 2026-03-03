use MyDatabase;

-- STRING FUNCTIONS --

-- MANIPULATION 

-- CONCAT: combine multiple strings into one

-- show a list of customers' first names together with their country in one column

select first_name, country,
concat(first_name, '-' ,country) as name_country
from customers;

-- UPPER: convert all characters to uppercase
-- LOWER: convert all characters to lowercase

-- covert first name to lowercase and country name to uppercase

select first_name, country,
concat(first_name, '-' ,country) as name_country,
lower (first_name) as low_name,
upper (country) as up_country
from customers;

select first_name, country,
concat( lower(first_name), '-' ,upper(country)) as name_COUNTRY
from customers;

-- TRIM: removes leading and trailing spaces

-- find customers whose first name comtains leading or tailing spaces

select first_name from customers
where first_name != trim(first_name);

select 
	first_name,
	len(first_name) as len_name,
	len(trim(first_name)) as len_trim_name,
	len(first_name) - len(trim(first_name)) as flag 
from customers;
--where len(first_name) != len(trim(first_name));

-- REPLACE: replace specift character with a new character

-- remove dadhes (-) from phone numbers

select '123-456-7890' as phone,
replace('123-456-7890', '-', '') as clean_phone

-- replace file extence from txt to csv

select 'report.txt',
replace('report.txt', '.txt', '.csv') as new_filename;

-- CALCULATION

-- LEN: counts how many characters

select first_name,
len(first_name) from customers;

-- STRING EXTRACTION

-- LEFT: extracts specific number od characters from the start
-- RIGHT: extracts specific number od characters from the end

-- retrive the first and last two characters of each first name

select first_name,
left(trim(first_name), 2) as first_2_char,
right(first_name, 2) as last_2_char,
left(trim(first_name), 2) +
right(first_name, 2) as first_last_2_char
from customers;

-- SUBSTRING: extracts a part of string at a specific position
-- SUBSTRING( Value, Start, Length)

-- retrieve a list of customers' first name after removing the first character

select first_name,
substring(trim(first_name), 2, len(first_name) ) as sub_name
from customers;

-- NUMERIC FUNCTIONS

-- ROUND

select 3.516 as raw_number,
round (3.516,2) as round_2,
round (3.516,1) as round_1,
round (3.516,0) as round_0;

-- ABSOLUTE VALUE

select -10 as raw_number, abs (-10) as abs_value
