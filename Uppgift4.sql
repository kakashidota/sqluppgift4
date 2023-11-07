-- 8 Stored Procedure to add a new product
CREATE PROCEDURE AddNewProduct 
    @ProductName VARCHAR(255),
    @Price DECIMAL(10,2),
    @CategoryID INT,
    @StockQuantity INT
AS
BEGIN
    INSERT INTO Products (ProductName, Price, CategoryID, StockQuantity) 
    VALUES (@ProductName, @Price, @CategoryID, @StockQuantity)
END


-- 9 Stored Procedure to update stock quantity for a product
CREATE PROCEDURE UpdateStockQuantity 
    @ProductID INT,
    @NewStockQuantity INT
AS
BEGIN
    UPDATE Products 
    SET StockQuantity = @NewStockQuantity 
    WHERE ProductID = @ProductID
END


-- 10 Stored Procedure to create a new order
CREATE PROCEDURE CreateNewOrder 
    @CustomerID INT,
    @OrderDate DATETIME,
    @Status VARCHAR(100)
AS
BEGIN
    INSERT INTO Orders (CustomerID, OrderDate, Status) 
    VALUES (@CustomerID, @OrderDate, @Status)
END


-- 11 Stored Procedure to update the status of an order
CREATE PROCEDURE UpdateOrderStatus 
    @OrderID INT,
    @NewStatus VARCHAR(100)
AS
BEGIN
    UPDATE Orders 
    SET Status = @NewStatus 
    WHERE OrderID = @OrderID
END


--12 Stored Procedure to list products by category
CREATE PROCEDURE ListProductsByCategory 
    @CategoryID INT
AS
BEGIN
    SELECT * FROM Products 
    WHERE CategoryID = @CategoryID
END


--13 View for Product Details
CREATE VIEW ProductDetails
AS
SELECT p.ProductID, p.ProductName, p.Price, c.CategoryName, p.StockQuantity
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID;


--14 View for Order Summaries
CREATE VIEW OrderSummaries
AS
SELECT o.OrderID, o.OrderDate, o.Status, c.CustomerName, c.ContactInfo
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID;


--15 View for Stock Status
CREATE VIEW StockStatus
AS
SELECT ProductID, ProductName, StockQuantity
FROM Products;

--16
SELECT p.ProductID, p.ProductName, p.Price, c.CategoryName
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID;


--17
SELECT o.OrderID, o.OrderDate, o.Status, c.CustomerName
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID;


--18
SELECT SUM(Price * StockQuantity) AS TotalStockValue
FROM Products;

-- 19 
CREATE PROCEDURE GetActiveOrderCustomers
AS
BEGIN
    SELECT DISTINCT c.CustomerID, c.CustomerName
    FROM Customers c
    INNER JOIN Orders o ON c.CustomerID = o.CustomerID
    WHERE o.Status = 'Active'
END