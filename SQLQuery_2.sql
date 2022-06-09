/* Exercise 1: Retrieve shipping status
You have been asked to create a query that returns a list of sales order IDs and order dates
with a column named ShippingStatus that contains the text Shipped for orders with a known
ship date, and Awaiting Shipment for orders with no ship date. */ 

SELECT SalesOrderID
    , OrderDate
    , ShipDate
    , CASE 
        WHEN ShipDate IS NULL THEN 'Awaiting Shipment'
        ELSE 'Shipped'
    END AS ShippingStatus
    , IIF( ShipDate IS NULL, 'Awaiting Shipment', 'Shipped' ) AS ShippingStatus2 
FROM SalesLT.SalesOrderHeader

/* Exercise 2: From table SalesLT.Customer 
Get name of each sale man. Name is last part of SalesPerson. 
Example: adventure-works\jun0 -> Name = jun0 */

SELECT SalesPerson
    , REPLACE(SalesPerson, 'adventure-works\', '') AS sale_man
    , CHARINDEX('\', SalesPerson) AS position
    , SUBSTRING(SalesPerson, CHARINDEX('\', SalesPerson) + 1, 50) AS sale_man_1
    , RIGHT(SalesPerson, LEN(SalesPerson) - CHARINDEX('\', SalesPerson) ) AS sale_man_2
    , SUBSTRING(SalesPerson, CHARINDEX('\', SalesPerson) + 1, LEN(SalesPerson) - CHARINDEX('\', SalesPerson)) AS sale_man_3
FROM SalesLT.Customer

/* Exercise 3: Retrieve customer names and phone numbers 
Each customer has an assigned salesperson. You must write a query to create a call sheet that lists: 
    - The salesperson 
    - A column named CustomerName that displays how the customer contact should be greeted 
    (for example, Mr Smith) 
    - The customer’s phone number. */

SELECT 
    CustomerID
    , SalesPerson
    , Phone
    , Title --('Mr.', 'Mrs.')
    , ISNULL(Title, ' ') + LastName AS CustomerName
    , CONCAT_WS(' ', Title, LastName) AS CustomerName_2 -- ignore NULL 
FROM SalesLT.Customer

/* Exercise 4: Retrieve the heaviest products information 
Transportation costs are increasing and you need to identify the heaviest products. 
Retrieve the names, weight of the top ten percent of products by weight.  
Then, add new column named Number of sell days (caculated from SellStartDate and SellEndDate)
of these products (if sell end date isn't defined then get Today date)  */

SELECT TOP 10 PERCENT
    ProductID
    , Name 
    , Weight 
    , SellStartDate
    , SellEndDate
    , CURRENT_TIMESTAMP
    , CASE 
        WHEN SellEndDate IS NULL THEN DATEDIFF(day, SellStartDate, CURRENT_TIMESTAMP)
        ELSE DATEDIFF(day, SellStartDate, SellEndDate)
        END AS number_of_sell_days
    , DATEDIFF(day, SellStartDate, ISNULL(SellEndDate, CURRENT_TIMESTAMP)) AS number_of_sell_days_1
    , IIF(SellEndDate IS NULL, DATEDIFF(day, SellStartDate, CURRENT_TIMESTAMP), 
            DATEDIFF(day, SellStartDate, SellEndDate) ) AS number_of_sell_days_2
FROM SalesLT.Product
ORDER BY Weight DESC