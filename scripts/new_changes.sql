USE streaming;

ALTER TABLE movies DROP CONSTRAINT movies_ibfk_4;

ALTER TABLE movies DROP COLUMN origin_country_id;

CREATE TABLE movie_countries (
    id INTEGER UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
    movie_id INTEGER  NOT NULL,
    country_id INTEGER  NOT NULL,
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (country_id) REFERENCES origin_countries(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

ALTER TABLE series DROP CONSTRAINT series_ibfk_4;

ALTER TABLE series DROP COLUMN origin_country_id;

CREATE TABLE serie_countries (
    id INTEGER UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
    serie_id INTEGER  NOT NULL,
    country_id INTEGER  NOT NULL,
    FOREIGN KEY (serie_id) REFERENCES series(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (country_id) REFERENCES origin_countries(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

ALTER TABLE movies DROP CONSTRAINT movies_ibfk_1;

ALTER TABLE movies DROP COLUMN streaming_service_id;

CREATE TABLE movies_streamings (
    id INTEGER UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
    movie_id INTEGER  NOT NULL,
    streaming_id INTEGER  NOT NULL,
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (streaming_id) REFERENCES streaming_services(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

ALTER TABLE series DROP CONSTRAINT series_ibfk_1;

ALTER TABLE series DROP COLUMN streaming_service_id;

CREATE TABLE series_streamings (
    id INTEGER UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
    serie_id INTEGER  NOT NULL,
    streaming_id INTEGER  NOT NULL,
    FOREIGN KEY (serie_id) REFERENCES series(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (streaming_id) REFERENCES streaming_services(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

ALTER TABLE series CHANGE chapters serie_year INT NOT NULL;

ALTER TABLE user_series DROP CONSTRAINT user_series_ibfk_1;

ALTER TABLE user_series DROP COLUMN serie_season_id;

DROP TABLE series_seasons;

DROP TABLE seasons;

ALTER TABLE user_series ADD COLUMN serie_id INT NOT NULL AFTER id;

ALTER TABLE user_series ADD CONSTRAINT `user_series_ibfk_1` FOREIGN KEY (`serie_id`) REFERENCES `series` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

CREATE TABLE movies_tmp (
    title varchar(150),
    netflix INTEGER,
    prime INTEGER,
    disney INTEGER,
    genres varchar(70),
    country varchar(220)
);

CREATE TABLE series_tmp (
    title varchar(105),
    country varchar(83),
    listed_in varchar(70)
);

ALTER TABLE series_tmp ADD COLUMN type varchar(7);

ALTER TABLE series_tmp ADD COLUMN rating varchar(5);

CREATE TABLE movie_genres_tmp (
    title varchar(150),
    genre varchar(70)
);

CREATE TABLE movie_countries_tmp (
    title varchar(150),
    country varchar(100)
);

CREATE TABLE serie_genres_tmp (
    title varchar(105),
    listed_in varchar(70)
);

CREATE TABLE serie_countries_tmp (
    title varchar(105),
    country varchar(83)
);

ALTER TABLE user_movies DROP COLUMN seasons;