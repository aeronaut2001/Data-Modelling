1. The most popular movie genres in specific locations.
SELECT
 t.city,
 t.genres
FROM (
 SELECT
 l.city,
 m.genres,
 RANK() OVER (PARTITION BY l.city ORDER BY COUNT(b.movie_id) DESC) AS ranks
 FROM
 LOCATION l
 JOIN
 BOOKINGS b ON l.location_id = b.location_id
 JOIN
 MOVIE m ON b.movie_id = m.movie_id
 GROUP BY
 l.city,
 m.genres
) AS t
WHERE
 t.ranks = 1;


2. The busiest time of the day/week for movie bookings.
-- For day of the week
SELECT
 DAYNAME(booking_date_time) AS day_of_week,
 COUNT(*) AS booking_count
FROM
 BOOKINGS
GROUP BY
 DAYOFWEEK(booking_date_time)
ORDER BY
 booking_count DESC;

-- For time of the day

SELECT
 HOUR(booking_date_time) AS hour_of_day,
 COUNT(*) AS booking_count
FROM
 BOOKINGS
GROUP BY
 hour_of_day
ORDER BY
 booking_count DESC;


3. The percentage of customers who book tickets for other events (like plays or concerts) after booking movie tickets.

SELECT
 (COUNT(CASE WHEN event_id IS NOT NULL THEN 1 END) / COUNT(*)) * 100 AS 
percentage_other_events
FROM
 BOOKINGS;


4. The average number of tickets booked per transaction.

SELECT
 AVG(ticket_count) AS average_tickets_per_transaction
FROM
 BOOKINGS;


5. The rate of booking cancellations.

SELECT
 (COUNT(CASE WHEN status = 'Cancelled' THEN 1 END) / COUNT(*)) * 100 AS 
cancellation_rate
FROM
 BOOKINGS;


6. The correlation between star cast and movie bookings.

SELECT
 m.starcast,
 COUNT(b.booking_id) AS booking_count
FROM
 MOVIE m
JOIN
 BOOKINGS b ON m.movie_id = b.movie_id
GROUP BY
 m.starcast
ORDER BY
 booking_count DESC;


7. The number of new users acquired each month.

SELECT
 DATE_FORMAT(user_registration_date, '%Y-%m') AS registration_month,
 COUNT(*) AS new_user_count
FROM
 USER
GROUP BY
 registration_month
ORDER BY
 registration_month;


8. The revenue generated from each movie theatre.

SELECT
 t.theatre_name,
 SUM(b.amount_paid) AS revenue
FROM
 THEATRE t
JOIN
 BOOKINGS b ON t.theatre_id = b.theatre_id
GROUP BY
 t.theatre_name
ORDER BY
 revenue DESC;
