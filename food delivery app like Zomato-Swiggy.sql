1. The most popular restaurants in specific locations.
  
SELECT
 r.RestaurantID,
 r.Name AS RestaurantName,
 l.City,
 COUNT(o.OrderID) AS OrderCount
FROM
 Restaurant r
JOIN
 Order o ON r.RestaurantID = o.RestaurantID
JOIN
 Location l ON r.LocationID = l.LocationID
GROUP BY
 r.RestaurantID, r.Name, l.City
ORDER BY
 OrderCount DESC;


2. The busiest times of day/week for food orders.
  
-- For day of the week
SELECT
 DAYNAME(OrderTime) AS DayOfWeek,
 COUNT(*) AS OrderCount
FROM
 Order
GROUP BY
 DayOfWeek
ORDER BY
 OrderCount DESC;

-- For time of the day

SELECT
 HOUR(OrderTime) AS HourOfDay,
 COUNT(*) AS OrderCount
FROM
 Order
GROUP BY
 HourOfDay
ORDER BY
 OrderCount DESC;


3. The average order value for each customer.
  
SELECT
 UserID,
 AVG(TotalAmount) AS AverageOrderValue
FROM
 Order
GROUP BY
 UserID;


4. The average delivery time for each restaurant and/ordelivery personnel.
  
-- For each restaurant
  
SELECT
 r.RestaurantID,
 r.Name AS RestaurantName,
 AVG(TIMESTAMPDIFF(MINUTE, o.OrderTime, o.DeliveryTime)) AS AverageDeliveryTime
FROM
 Restaurant r JOIN
 Order o ON r.RestaurantID = o.RestaurantID
GROUP BY r.RestaurantID, r.Name;

-- For each delivery personnel

SELECT
 dp.DeliveryPersonnelID,
 dp.Name AS DeliveryPersonnelName,
 AVG(TIMESTAMPDIFF(MINUTE, o.OrderTime, o.DeliveryTime)) AS AverageDeliveryTime
FROM
 DeliveryPersonnel dp
JOIN
 Order o ON dp.DeliveryPersonnelID = o.DeliveryPersonnelID
GROUP BY
 dp.DeliveryPersonnelID, dp.Name;


5. The most commonly ordered cuisines.
  
SELECT
 c.Name AS Cuisine,
 COUNT(mi.MenuItemID) AS OrderCount
FROM
 Cuisine c
JOIN
 MenuItem mi ON c.CuisineID = mi.CuisineID
JOIN
 Order o ON mi.MenuItemID = o.MenuItemID
GROUP BY
 c.Name
ORDER BY
 OrderCount DESC;


6. The rate of order cancellations.
  
SELECT
 (COUNT(CASE WHEN Status = 'Cancelled' THEN 1 END) / COUNT(*)) * 100 AS CancellationRate
FROM
 Order;


7. The revenue generated from each restaurant.
  
SELECT
 r.RestaurantID,
 r.Name AS RestaurantName,
 SUM(o.TotalAmount) AS Revenue
FROM
 Restaurant r
JOIN
 Order o ON r.RestaurantID = o.RestaurantID
GROUP BY
 r.RestaurantID, r.Name
ORDER BY
 Revenue DESC;


8. The number of new customers acquired each month.
  
SELECT
 DATE_FORMAT(u.UserRegistrationDate, '%Y-%m') AS RegistrationMonth,
 COUNT(u.UserID) AS NewUserCount
FROM
 User u
GROUP BY
 RegistrationMonth
ORDER BY
 RegistrationMonth;
