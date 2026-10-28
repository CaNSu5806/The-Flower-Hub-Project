-- =============================================================================
-- The Flower Hub Database: Analytical & Operational Queries
-- =============================================================================

-- Query 1: Shop Revenue Report (Revenue > 500)
SELECT 
    s.name AS ShopName,
    COUNT(DISTINCT o.order_id) AS TotalOrderCount,
    SUM(od.quantity * od.unit_price) AS TotalRevenue
FROM Shops s
JOIN Orders o ON s.shop_id = o.shop_id
JOIN OrderDetails od ON o.order_id = od.order_id
GROUP BY s.name
HAVING SUM(od.quantity * od.unit_price) > 500
ORDER BY TotalRevenue DESC;

-- Query 2: Pending Orders Pipeline
SELECT 
    u.full_name AS CustomerName,
    o.order_id AS OrderID,
    o.total_price AS OrderTotal,
    o.status AS OrderStatus,
    o.order_date AS OrderDate
FROM Users u
JOIN Orders o ON u.user_id = o.customer_id
WHERE o.status = 'PENDING'
ORDER BY o.order_date DESC;

-- Query 3: High-Rated Categories (Shop Rating Average > 4.0)
SELECT 
    c.category_name AS CategoryName,
    ROUND(AVG(s.rating), 2) AS AverageShopRating,
    COUNT(DISTINCT s.shop_id) AS TotalShopsInCategory
FROM Categories c
JOIN Products p ON c.category_id = p.category_id
JOIN Shops s ON p.shop_id = s.shop_id
GROUP BY c.category_name
HAVING AVG(s.rating) > 4.0
ORDER BY AverageShopRating DESC;

-- Query 4: Daily Operating Vendors Directory
SELECT 
    s.name AS ShopName,
    s.address AS ShopAddress,
    oh.time_details AS OperationHours,
    u.full_name AS VendorName,
    u.email AS VendorEmail
FROM Shops s
JOIN OpeningHours oh ON s.shop_id = oh.shop_id
JOIN Users u ON s.owner_id = u.user_id
WHERE s.is_active = 1
  AND LOWER(oh.time_details) LIKE '%everyday%'
ORDER BY s.name ASC;

-- Query 5: Revenue and Feedback by Payment Channel
SELECT 
    p.payment_method AS PaymentMethod,
    COUNT(p.transaction_id) AS SuccessfulTransactions,
    SUM(o.total_price) AS TotalRevenue,
    ROUND(AVG(r.rating), 2) AS AverageCustomerRating
FROM Payments p
JOIN Orders o ON p.order_id = o.order_id
JOIN Reviews r ON o.order_id = r.order_id
WHERE p.payment_status = 'Completed'
GROUP BY p.payment_method
HAVING SUM(o.total_price) > 500
ORDER BY TotalRevenue DESC;

-- Query 6: Critical Stock Warning (Stock < 20)
SELECT 
    p.name AS ProductName,
    c.category_name AS CategoryName,
    p.stock_quantity AS RemainingStock,
    p.price AS UnitPrice
FROM Products p
JOIN Categories c ON p.category_id = c.category_id
WHERE p.stock_quantity < 20
ORDER BY p.stock_quantity ASC;

-- Query 7: Active Courier Contact Directory
SELECT 
    u.full_name AS CourierName,
    u.email AS CourierEmail,
    u.phone AS CourierPhone
FROM Users u
JOIN Roles r ON u.role_id = r.role_id
WHERE r.role_name = 'Courier'
ORDER BY u.full_name ASC;

-- Query 8: Severe Complaint Log (Rating = 1)
SELECT 
    s.name AS ShopName,
    p.name AS ProductName,
    r.review_text AS CustomerComplaint
FROM Reviews r
JOIN OrderDetails od ON r.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
JOIN Shops s ON p.shop_id = s.shop_id
WHERE r.rating = 1
ORDER BY s.name ASC;

-- Query 9: User Address Utilization Analysis
SELECT 
    u.user_id AS AccountID,
    u.full_name AS AccountOwner,
    r.role_name AS RoleType,
    u.email AS ContactEmail,
    COUNT(a.address_id) AS SavedAddressCount
FROM Users u
JOIN Roles r ON u.role_id = r.role_id
LEFT JOIN UserAddresses a ON u.user_id = a.user_id
WHERE r.role_name IN ('Customer', 'Vendor')
GROUP BY u.user_id, u.full_name, r.role_name, u.email
HAVING COUNT(a.address_id) > 0
ORDER BY SavedAddressCount DESC, u.full_name ASC;

-- Query 10: Inactive Customers Without Saved Addresses
SELECT 
    u.user_id AS CustomerID,
    u.full_name AS CustomerName,
    u.email AS ContactEmail,
    u.phone AS PhoneNumber
FROM Users u
JOIN Roles r ON u.role_id = r.role_id
LEFT JOIN UserAddresses a ON u.user_id = a.user_id
WHERE r.role_name = 'Customer' AND a.address_id IS NULL
ORDER BY u.user_id ASC;
