CREATE DATABASE IF NOT EXISTS streaming
DEFAULT 
CHARACTER SET utf8
COLLATE utf8_spanish2_ci;


USE streaming;

CREATE TABLE age_ratings(
id INT NOT NULL AUTO_INCREMENT,
age_rating VARCHAR(5) NOT NULL,
PRIMARY KEY (id)
) COMMENT 'Age ratings for movies and series ';

CREATE TABLE movie_genres(
id INT NOT NULL AUTO_INCREMENT,
movie_genre VARCHAR(50) NOT NULL,
PRIMARY KEY (id)
) COMMENT 'The genre of the movies';

CREATE TABLE streaming_services(
id INT NOT NULL AUTO_INCREMENT,
streaming_service VARCHAR(15) NOT NULL,
PRIMARY KEY (id)
) COMMENT 'The service of streamings';

CREATE TABLE origin_countries(
id INT NOT NULL AUTO_INCREMENT,
origin_country VARCHAR(50) NOT NULL,
iso_code CHAR(3) NOT NULL,
PRIMARY KEY (id)
) COMMENT 'The countries of origin of movies or series with ISO 3166-1 code';

CREATE TABLE seasons(
id INT NOT NULL AUTO_INCREMENT,
season SMALLINT NOT NULL DEFAULT "1",
chapters SMALLINT NOT NULL DEFAULT "8",
PRIMARY KEY (id)
) COMMENT 'The seasons of the series by number of chapters';

CREATE TABLE users(
id INT NOT NULL AUTO_INCREMENT,
login VARCHAR(10) NOT NULL,
pass VARCHAR(10) NOT NULL,
user_name VARCHAR(30) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE movies(
id INT NOT NULL AUTO_INCREMENT,
movie_name VARCHAR(150) NOT NULL,
duration TIME NOT NULL,
movie_year INT NOT NULL,
streaming_service_id INT NOT NULL,
movie_genre_id INT NOT NULL,
age_rating_id INT NOT NULL,
origin_country_id INT NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (streaming_service_id) REFERENCES streaming_services(id) ON UPDATE CASCADE ON DELETE RESTRICT,
FOREIGN KEY (movie_genre_id) REFERENCES movie_genres(id) ON UPDATE CASCADE ON DELETE RESTRICT,
FOREIGN KEY (age_rating_id) REFERENCES age_ratings(id) ON UPDATE CASCADE ON DELETE RESTRICT,
FOREIGN KEY (origin_country_id) REFERENCES origin_countries(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE series(
id INT NOT NULL AUTO_INCREMENT,
serie_name VARCHAR(150) NOT NULL,
seasons SMALLINT NOT NULL DEFAULT "1",
chapters SMALLINT NOT NULL,
streaming_service_id INT NOT NULL,
movie_genre_id INT NOT NULL,
age_rating_id INT NOT NULL,
origin_country_id INT NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (streaming_service_id) REFERENCES streaming_services(id) ON UPDATE CASCADE ON DELETE RESTRICT,
FOREIGN KEY (movie_genre_id) REFERENCES movie_genres(id) ON UPDATE CASCADE ON DELETE RESTRICT,
FOREIGN KEY (age_rating_id) REFERENCES age_ratings(id) ON UPDATE CASCADE ON DELETE RESTRICT,
FOREIGN KEY (origin_country_id) REFERENCES origin_countries(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE user_movies(
id INT NOT NULL AUTO_INCREMENT,
movie_view TINYINT NOT NULL DEFAULT "0",
seasons SMALLINT NOT NULL DEFAULT "1",
movie_id INT NOT NULL,
user_id INT NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (movie_id) REFERENCES movies(id) ON UPDATE CASCADE ON DELETE RESTRICT,
FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE RESTRICT
) COMMENT 'The play lists with movies for the users';

CREATE TABLE series_seasons(
id INT NOT NULL AUTO_INCREMENT,
serie_id INT NOT NULL,
season_id INT NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (serie_id) REFERENCES series(id) ON UPDATE CASCADE ON DELETE RESTRICT,
FOREIGN KEY (season_id) REFERENCES seasons(id) ON UPDATE CASCADE ON DELETE RESTRICT
) COMMENT 'All seasons of the series actually ';

CREATE TABLE user_series(
id INT,
serie_view TINYINT NOT NULL DEFAULT "0",
serie_season_id INT NOT NULL,
user_id INT NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (serie_season_id) REFERENCES series_seasons(id) ON UPDATE CASCADE ON DELETE RESTRICT,
FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE RESTRICT
) COMMENT 'The play list with series for the users';