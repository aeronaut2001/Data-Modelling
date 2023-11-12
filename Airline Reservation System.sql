1. Identify the most frequent flyers:
  
SELECT
 c.CustomerID,
 c.Name AS CustomerName,
 COUNT(r.ReservationID) AS ReservationCount
FROM
 Customer c
JOIN
 Reservation r ON c.CustomerID = r.CustomerID
GROUP BY
 c.CustomerID, CustomerName
ORDER BY
 ReservationCount DESC;


2. Determine which flights are most popular:
  
SELECT
 f.FlightID,
 f.Airline,
 COUNT(r.ReservationID) AS ReservationCount
FROM
 Flight f
JOIN
 Reservation r ON f.FlightID = r.FlightID
GROUP BY
 f.FlightID, f.Airline
ORDER BY
 ReservationCount DESC;


3. Calculate seat occupancy rates for flights:
  
SELECT
 f.FlightID,
 COUNT(r.ReservationID) / a.Capacity AS OccupancyRate
FROM
 Flight f
JOIN
 Reservation r ON f.FlightID = r.FlightID
JOIN
 Aircraft a ON f.AircraftID = a.AircraftID
GROUP BY
 f.FlightID
ORDER BY
 OccupancyRate DESC;


4. Identify the busiest airports for departures and arrivals:
  
-- For departures
  
SELECT
 a.DepartureAirport,
 COUNT(*) AS DepartureCount
FROM
 Flight f
GROUP BY
 DepartureAirport
ORDER BY
 DepartureCount DESC;

-- For arrivals

SELECT
 a.ArrivalAirport,
 COUNT(*) AS ArrivalCount
FROM
 Flight f
GROUP BY
 ArrivalAirport
ORDER BY
 ArrivalCount DESC;


5. Evaluate the performance of different aircraft types:
  
SELECT
 a.AircraftType,
 AVG(flight_duration) AS AverageFlightDuration
FROM
 Aircraft a
JOIN
 Flight f ON a.AircraftID = f.AircraftID
GROUP BY
  a.AircraftType;


6. Calculate revenue generated from each flight and overall:
  
-- For each flight
  
SELECT
 f.FlightID,
 SUM(r.Amount) AS FlightRevenue
FROM
 Flight f
JOIN
 Reservation r ON f.FlightID = r.FlightID
GROUP BY
 f.FlightID
ORDER BY
 FlightRevenue DESC;

-- Overall

SELECT
 SUM(r.Amount) AS TotalRevenue
FROM
 Reservation r;
### Payment Trends:
#### Analyze payment patterns and identify preferred payment methods:
SELECT
 p.PaymentStatus,
 COUNT(*) AS PaymentCount
FROM
 Payment p
GROUP BY
 PaymentStatus;


7. Identify peak reservation times:
  
SELECT
 HOUR(r.ReservationDateTime) AS ReservationHour,
 COUNT(*) AS ReservationCount
FROM
 Reservation r
GROUP BY
 ReservationHour
ORDER BY
 ReservationCount DESC;


8. Analyze booking patterns for different flights:

SELECT
 f.FlightID,
 DATE_FORMAT(r.ReservationDateTime, '%Y-%m-%d') AS ReservationDate,
 COUNT(*) AS ReservationCount
FROM
 Flight f
JOIN
 Reservation r ON f.FlightID = r.FlightID
GROUP BY
 f.FlightID, ReservationDate
ORDER BY
 ReservationCount DESC;


9. Calculate the rate of reservation cancellations:
  
SELECT
 COUNT(*) / (SELECT COUNT(*) FROM Reservation) AS CancellationRate
FROM
 Reservation
WHERE
 Status = 'Cancelled';


10. Analyze on-time performance of flights:
SELECT
 f.FlightID,
 AVG(CASE WHEN Status = 'On Time' THEN 1 ELSE 0 END) AS OnTimePercentage
FROM
 Flight f
JOIN
 Reservation r ON f.FlightID = r.FlightID
GROUP BY
 f.FlightID;
