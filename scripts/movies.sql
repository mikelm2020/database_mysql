SELECT 
'Inception' AS movie_name,
148 AS duration,
2010 AS movie_year,
(SELECT id FROM streaming_services WHERE id = 1) AS streaming_service_id,
(SELECT id FROM age_ratings WHERE age_rating = '13+') AS age_rating_id,
(SELECT id FROM origin_countries WHERE origin_country = 'United States') AS origin_country_id
FROM movies
