/* Exercise 1: Retrieve a list of customer companies 
You have been asked to provide a list of all customer companies in the format. Customer ID : Company Name - for example, 78: Preferred Bikes. */

SELECT
    CustomerID
    , Companyname
    , CAST(CustomerID AS nvarchar(100)) + ': ' + CompanyName AS FormatedName
    , CONCAT(CustomerID, ': ', CompanyName) AS FormatedName_1
FROM SalesLT.Customer


/*Exercise 2: Retrieve a list of sales order revisions 
The SalesLT.SalesOrderHeader table contains records of sales orders.  You have been asked to retrieve data for a report that shows: 
    - The sales order number and revision number in the format () – for example SO71774 (2). 
    - The order date converted to ANSI standard 102 format (yyyy.mm.dd – for example 2015.01.31). */

SELECT 
    SalesOrderNumber +' (' + CAST(revisionNumber AS nvarchar) + ')' AS SalesOrder 
   , CONVERT(nvarchar,OrderDate, 102) AS OrderDate_ANSI
FROM SalesLT.SalesOrderHeader

/* Exercise 3: Retrieve customer contact names with middle names if known 
You have been asked to write a query that returns a list of customer names. 
The list must consist of a single column in the format first last (for example Keith Harris) if the middle name is unknown, or first middle last (for example Jane M. Gates) if a middle name is known. */

SELECT 
    FirstName
    , MiddleName
    , LastName
    , CONCAT(FirstName,' ', MiddleName, ' ', LastName) AS full_name
    , CONCAT_WS(' ', FirstName, MiddleName, LastName) AS full_name_2
FROM SalesLT.Customer

/* Exercise 4: Retrieve primary contact details 
Customers may provide Adventure Works with an email address, a phone number, or both. 
If an email address is available, then it should be used as the primary contact method; 
if not, then the phone number should be used. You must write a query that returns a list of customer IDs in one column, 
and a second column named PrimaryContact that contains the email address if known, 
and otherwise the phone number. */

SELECT TOP 10 
    CustomerID 
    , EmailAddress
    , Phone            
    , ISNULL(EmailAddress, Phone) AS PrimaryContact_1
    ,(CASE  
        WHEN EmailAddress IS NOT NULL THEN EmailAddress  
        ELSE Phone 
    END) AS PrimaryContact_2
    , COALESCE(EmailAddress, Phone) AS PrimaryContact_3
FROM SalesLT.Customer 

/* Exercise 5: As you continue to work with the Adventure Works customer, product and sales data, you must create queries for reports that have been requested by the sales team.
Retrieve a list of customers with no address.
A sales employee has noticed that Adventure Works does not have address information for all customers. 
You must write a query that returns a list of customer IDs, company names, contact names (first name and last name), and phone numbers for customers with no address stored 
in the database. */

SELECT CustomerID
    , CompanyName
    , FirstName + LastName AS Contact_Name
    , Phone
FROM SalesLT.Customer
WHERE CustomerID NOT IN (SELECT CustomerID
                        FROM SalesLT.CustomerAddress)
//test
