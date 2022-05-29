INSERT INTO movies_streamings (movie_id, streaming_id)
SELECT a.id, c.id
FROM movies a, movies_tmp b, streaming_services c
WHERE b.netflix=1
AND b.title = a.movie_name
AND c.id = 1;

INSERT INTO movies_streamings (movie_id, streaming_id)
SELECT a.id, c.id
FROM movies a, movies_tmp b, streaming_services c
WHERE b.disney=1
AND b.title = a.movie_name
AND c.id = 2;

INSERT INTO movies_streamings (movie_id, streaming_id)
SELECT a.id, c.id
FROM movies a, movies_tmp b, streaming_services c
WHERE b.prime=1
AND b.title = a.movie_name
AND c.id = 3;

INSERT INTO movie_genders (movie_id, film_gender_id)
SELECT a.id, c.id
FROM movies a, movie_genres_tmp b, film_genders c
WHERE a.movie_name = b.title
AND c.movie_gender = b.genre;

INSERT INTO movie_countries (movie_id, country_id)
SELECT a.id, c.id
FROM movies a, movie_countries_tmp b, origin_countries c
WHERE a.movie_name = b.title
AND c.origin_country = b.country;

INSERT INTO series_streamings (serie_id, streaming_id)
SELECT a.id, c.id
FROM series a, series_tmp b, streaming_services c
WHERE c.id = 1
AND b.title = a.serie_name;

DELETE FROM serie_genres_tmp WHERE listed_in LIKE '%International TV Shows';

DELETE FROM serie_genres_tmp WHERE listed_in LIKE '%British TV Shows';

DELETE FROM serie_genres_tmp WHERE listed_in LIKE '%Spanish-Language TV Shows';

DELETE FROM serie_genres_tmp WHERE listed_in LIKE '%Spanish-Language TV Shows';

INSERT INTO film_genders (movie_gender) VALUES ('Anime');

INSERT INTO film_genders (movie_gender) VALUES ('Talk Show');

INSERT INTO serie_genders (serie_id, film_gender_id)
SELECT a.id, 
CASE 
    WHEN listed_in LIKE '%Crime TV Shows' THEN 13
    WHEN listed_in LIKE '%TV Dramas' THEN 10
    WHEN listed_in LIKE '%Romantic TV Shows' THEN 15
    WHEN listed_in LIKE '%Docuseries' THEN 19
    WHEN listed_in LIKE '%Anime Series' THEN 7
    WHEN listed_in LIKE '%TV Horror' THEN 22
    WHEN listed_in LIKE '%TV Comedies' THEN 5
    WHEN listed_in LIKE '%TV Action & Adventure' THEN 1
    WHEN listed_in LIKE '%TV Mysteries' THEN 17
    WHEN listed_in LIKE '%TV Thrillers' THEN 4
    WHEN listed_in LIKE '%Teen TV Shows' THEN 8
    WHEN listed_in LIKE '%Korean TV Shows' THEN 25
    WHEN listed_in LIKE '%Stand-Up Comedy & Talk Shows' THEN 26
ELSE 
    8
END
FROM series a, serie_genres_tmp b
WHERE a.serie_name = b.title;

INSERT INTO serie_countries (serie_id, country_id)
SELECT a.id, c.id
FROM series a, serie_countries_tmp b, origin_countries c
WHERE a.serie_name = b.title
AND c.origin_country = b.country;
