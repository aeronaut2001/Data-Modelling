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
