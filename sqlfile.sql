-- Sales Performance Analysis:
-- Question:
  -- What are the top-selling products?

  SELECT TOP(10) P.ProductName, SUM(OD.Quantity) AS Top_Sales
  FROM Products AS P
  JOIN [Order Details] AS OD ON P.ProductID = OD.ProductID 
  GROUP By ProductName
  ORDER BY Top_Sales DESC

-- Supplier Evaluation: 
-- Question:
  -- Which suppliers consistently meet their delivery times and which ones do not?

  SELECT S.CompanyName, SUM(CASE WHEN O.RequiredDate > O.ShippedDate THEN 1 ELSE 0 END) AS On_Time, COUNT(O.OrderID) AS Total_Orders
  FROM Orders AS O
  JOIN Shippers AS S ON O.ShipVia = S.ShipperID
  GROUP BY S.CompanyName
  ORDER BY On_Time DESC

-- Notes: I struggled to get the answer so I used the intetnet. My thought process before was to use the WHERE clause but the problem was going to be how to calculate the amount on the orders on time

-- Customer Behavior Analysis: 
-- Question:
  -- What is the average order value and how does it vary across different customer segments or regions?

  SELECT O.ShipCountry, AVG(OD.UnitPrice * OD.Quantity) AS AVG_Orders
  FROM [Order Details] AS OD
  JOIN Orders AS O ON OD.OrderID = O.OrderID
  GROUP BY O.ShipCountry

-- Question:
  -- Can we identify customers who have stopped buying from us in the past year?

  SELECT C.CompanyName, YEAR(O.OrderDate) AS Date_Year 
  FROM Customers AS C
  JOIN Orders AS O  ON O.CustomerID = C.CustomerID
  WHERE YEAR(O.OrderDate) != 1998

-- Question:
  -- Which regions generate the most sales?

  SELECT O.ShipCountry, SUM(OD.UnitPrice * OD.Quantity) AS SUM_Orders
  FROM [Order Details] AS OD
  JOIN Orders AS O ON OD.OrderID = O.OrderID
  GROUP BY O.ShipCountry

-- Question:
  -- How does seasonality affect our sales and can we forecast future sales based on past trends?

  SELECT DATENAME(MONTH, DATEADD(MONTH, MONTH(O.OrderDate), '2020-12-01')) AS Months, SUM(OD.UnitPrice * OD.Quantity) AS Total_Orders
  FROM [Order Details] AS OD
  JOIN Orders AS O ON OD.OrderID = O.OrderID
  GROUP BY MONTH(O.OrderDate)

-- Notes: I looked up how to change the month numbers to month names to make it more readable

-- Inventory Management:
-- Question:
  -- Which products are frequently out of stock?

  SELECT ProductName
  FROM Products
  WHERE UnitsInStock = 0

-- Question:
  -- Which products are frequently overstocked?

  SELECT ProductName, SUM(UnitsInStock) AS Stock
  FROM Products
  GROUP BY ProductName
  ORDER BY Stock DESC
