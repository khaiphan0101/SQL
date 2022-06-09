/* Task 1: Retrieve data for transportation reports 
1.1 Retrieve a list of cities: Initially, you need to produce a list of all of you customers' locations. 
Write a Transact-SQL query that queries the SalesLT.Address table and retrieves the values for City and StateProvince
, removing duplicates , then sorts in ascending order of StateProvince and descending order of City. */

SELECT DISTINCT StateProvince-- removing duplicates
    , City
FROM SalesLT.Address
ORDER BY StateProvince ASC , City DESC

/* 1.2 Retrieve the heaviest products information 
Transportation costs are increasing and you need to identify the heaviest products. 
Retrieve the names, weight of the top ten percent of products by weight. */

SELECT TOP 10 Name, Weight
FROM SalesLT.Product
ORDER BY Weight DESC

/* Task 2: Retrieve product data 
2.1 Filter products by color and size  
Retrieve the product number and name of the products 
that have a color of black, red, or white and a size of S or M */

SELECT ProductNumber
		, Name
        , Color
        , Size 
FROM SalesLT.Product 
WHERE (Color = 'black' or Color = 'red' or Color = 'white') AND (Size = 'S' or Size = 'M') 
-- #2 Color IN ('Black','Red','White') AND Size IN ('S','M')

/*2.2 Filter products by color, size and product number 
Retrieve the ProductID, ProductNumber and Name of the products, 
- that must have Product number begins with 'BK-'
- followed by any character other than 'T' 
- and ends with a '-' followed by any two numerals. 
- And satisfy one of the following conditions: color of black, red, or white size is S or M and */

SELECT ProductID
	, ProductNumber
	, Name
FROM SalesLT.Product
WHERE ProductNumber LIKE 'BK-[^T]%-[0-9][0-9]' 
	AND (Color IN ('Black', 'Red', 'White') OR Size IN ('S','M'))

/*2.3 Retrieve specific products by product ID  
Retrieve the product ID, product number, name, and list price of products whose 
- product name contains "HL " or "Mountain",
- product number is at least 8 characters 
- and never have been ordered. */

SELECT ProductID 
    , Name 
    , ProductNumber
FROM SalesLT.Product
WHERE (Name LIKE '%HL%' OR Name LIKE '%Mountain%')
    AND ProductNumber LIKE '________%'
    AND ProductID NOT IN ( SELECT DISTINCT ProductID
                            FROM SalesLT.SalesOrderDetail )

