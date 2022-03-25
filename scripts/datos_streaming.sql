INSERT INTO origin_countries (id, origin_country,iso_code) VALUES (1,'Alemania','DEU'),
(2,'Bulgaria','BGR'),
(3,'Canada','CAN'),
(4,'La República de Corea','KOR'),
(5,'Dinamarca','DNK'),
(6,'España','ESP'),
(7,'Los Estados Unidos de América','USA'),
(8,'Francia','FRA'),
(9,'India','IND'),
(10,'Italia','ITA'),
(11,'México','MEX'),
(12,'Nueva Zelandia','NZL'),
(13,'Polonia','POL'),
(14,'Rumania','ROU'),
(15,'Singapur','SGP'),
(16,'Sudáfrica','ZAF'),
(17,'Turquía','TUR'),
(18,'Argentina','ARG'),
(19,'Australia','AUS'),
(20,'Austria','AUT'),
(21,'Bélgica','BEL'),
(22,'Brasil','BRA'),
(23,'Colombia','COL'),
(24,'Finlandia','FIN'),
(25,'El Reino Unido de Gran Bretaña','GBR'),
(26,'Japón','JPN'),
(27,'Portugal','PRT'),
(28,'Suecia','SWE');

INSERT INTO age_ratings (id, age_rating) VALUES (1,'TV-MA'),
(2,'R'),
(3,'NC-17'),
(4,'TV-Y'),
(5,'TV-Y7'),
(6,'G'),
(7,'TV-G'),
(8,'PG'),
(9,'TV-PG'),
(10,'PG-13'),
(11,'TV-14');

INSERT INTO movie_genres (id, movie_genre) VALUES (1,'Acción'),
(2,'Comedia'),
(3,'Drama'),
(4,'Intriga'),
(5,'Romance'),
(6,'Sci-fi'),
(7,'Suspenso'),
(8,'Terror'),
(9,'Thriller'),
(10,'Fantasía'),
(11,'Reality Show');

INSERT INTO streaming_services (id, streaming_service) VALUES (1,'Netfix'),
(2,'Disney Plus'),
(3,'Amazon Prime'),
(4,'HBO Max'),
(5,'Paramount Plus');

INSERT INTO movies (id,movie_name,duration,movie_year,streaming_service_id,movie_genre_id,age_rating_id,origin_country_id) VALUES (1,'Confianza','1:34',2021,1,5,1,7),
(2,'Purasangre','1:43',2016,1,1,1,11),
(3,'No me mates','1:30',2022,1,8,1,10),
(4,'Talk to her','1:53',2002,1,3,2,6),
(5,'Bigbug','1:51',2022,1,6,1,8),
(6,'Kika','1:53',1993,1,3,2,6),
(7,'Carne trémula','1:40',1997,1,7,2,6),
(8,'A través de mi ventana','1:53',2022,1,5,1,6),
(9,'Bliss','1:43',1997,1,5,2,7),
(10,'Lang tong','1:21',2015,1,7,1,15),
(11,'Anatomia','1:39',2000,1,8,2,1),
(12,'Ninfomania volumen 1','1:57',2013,1,3,1,5),
(13,'Ninfomania volumen 2','2:03',2013,1,3,1,5),
(14,'La hija oscura','2:02',2021,1,3,2,7),
(15,'Las separadoras de parejas','1:22',2018,1,2,1,12),
(16,'Amores modernos','1:22',2019,1,2,1,11),
(17,'Los doble vida','1:48',2016,1,2,1,7),
(18,'Buenos vecinos','1:38',2014,1,2,2,7),
(19,'La cruda verdad','1:36',2009,1,2,2,7),
(20,'Cómo impedir una boda','1:27',2012,1,2,2,7),
(21,'Hermanas','1:57',2015,1,2,2,7),
(22,'Fuimos canciones','1:51',2021,1,5,1,6),
(23,'Está chica es un desastre','2:04',2015,1,2,2,7),
(24,'Gloria','2:07',2015,1,3,2,11),
(25,'Dos','1:11',2021,1,3,1,6),
(26,'American Pie 2 tu segunda vez','1:36',2003,1,2,2,7),
(27,'Oh Ramona','1:49',2019,1,2,1,14),
(28,'La lista de pendientes','1:43',2003,1,2,2,7),
(29,'Todos mis amigos están muertos','1:36',2020,1,2,1,13),
(30,'Nido de amor','1:33',2017,1,2,1,7),
(31,'La chica de al lado','1:49',2014,1,2,2,7),
(32,'Ni en sueños','2:04',2019,1,2,2,7),
(33,'Dónde caben dos','1:51',2021,1,2,1,6),
(34,'Quiéreme tanto','2:04',2021,1,3,1,17),
(35,'Las leyes de la frontera','2:10',2021,1,3,1,6),
(36,'Vanilla sky','2:16',2021,1,5,2,7),
(37,'Infidelidad','2:03',2002,1,5,2,7),
(38,'De amor y otras adicciones','1:52',2010,1,2,2,7),
(39,'En carne viva','1:58',2003,1,7,2,7),
(40,'La isla negra','1:44',2021,1,7,1,1),
(41,'Mudanza mortal','1:54',2021,1,8,1,7),
(42,'Venganza del más allá','1:48',2018,1,7,2,8),
(43,'Lo que ellos quieren','1:58',2019,1,2,2,7),
(44,'Red de peligro','1:36',2018,1,4,2,7),
(45,'Un pequeño favor','1:56',2018,1,9,2,7),
(46,'Cercana obsesión','1:30',2015,1,4,2,7),
(47,'Anon','1:40',2018,1,6,1,7),
(48,'El baile de los 41','1:39',2021,1,3,1,11),
(49,'Yo soy todas las niñas','1:47',2021,1,9,1,16),
(50,'Crímen y deseo','1:44',2019,1,4,2,7),
(51,'Madame Claude','1:52',2021,1,3,1,8),
(52,'Ilusiones mortales','1:54',2021,1,7,2,7),
(53,'Dulce venganza','1:48',2010,1,8,2,7),
(54,'Sr. Brooks','2:00',2007,1,7,2,7),
(55,'Los despiadados','1:51',2019,1,3,1,10),
(56,'Juegos del destino','2:02',2012,1,5,1,7),
(57,'Spencer confidencial','1:51',2020,1,1,2,7),
(58,'La vida inmoral de la pareja ideal','1:30',2016,1,2,2,11),
(59,'El diablo a todas horas','2:18',2020,1,4,2,7),
(60,'Hater','2:16',2020,1,3,1,13),
(61,'Frutos del viento','1:32',2022,1,3,2,7),
(62,'Fragmentos de una mujer','2:06',2006,1,3,2,7),
(63,'White girl','1:30',2016,1,3,1,7),
(64,'Nadie duerme en el bosque esta noche','1:43',2020,1,8,1,13),
(65,'Actos de venganza','1:26',2017,1,1,1,2),
(66,'Bajo la piel de lobo','1:50',2018,1,3,1,6),
(67,'Te quiero, imbécil','1:27',2019,1,2,1,6),
(68,'Furia','1:38',2019,1,4,1,8),
(69,'Todo bien','1:30',2019,1,3,1,1),
(70,'Polar','1:58',2019,1,1,1,3),
(71,'Los últimos días del crimen','2:29',2020,1,6,1,7),
(72,'Proyecto X','1:28',2012,1,2,1,7),
(73,'Diamantes en bruto','2:15',2019,1,4,2,7),
(74,'Vida privada','2:04',2018,1,2,2,7),
(75,'Perdida','2:28',2014,1,7,2,7),
(76,'Someone great: Alguíen extraordinario','1:32',2019,1,5,2,7),
(77,'Sergio','1:58',2020,1,3,2,7),
(78,'Menendez: El día del Señor','1:33',2020,1,8,1,11),
(79,'Culpable','1:59',2020,1,3,1,9),
(80,'Dos tortolos','1:27',2020,1,2,2,7),
(81,'Paradise beach','1:34',2019,1,1,1,8),
(82,'Los hermanos Santana','1:46',2020,1,1,1,16),
(83,'365 días','1:54',2020,1,3,1,13),
(84,'Perversa adicción','1:45',2014,1,9,2,7),
(85,'Mio o de nadie','1:40',2017,1,4,2,7),
(86,'Alta sociedad','2:17',2018,1,3,1,4),
(87,'La marca del demonio','1:20',2020,1,8,1,11),
(88,'Newness','1:57',2017,1,3,1,7),
(89,'La vida que queríamos','1:33',2020,1,3,1,20),
(90,'Romina','1:14',2018,1,8,1,11);

INSERT INTO series (id,serie_name,seasons,chapters,streaming_service_id,movie_genre_id,age_rating_id,origin_country_id) VALUES (1,'Tabú',1,8,1,3,1,25),
(2,'Cómo peces dorados',1,8,1,3,1,26),
(3,'Ritmo salvaje',1,8,1,3,1,23),
(4,'Inventando a Ana',1,9,1,3,1,7),
(5,'Venir del frío',1,8,1,6,1,7),
(6,'Fidelidad',1,6,1,3,1,10),
(7,'El caso Hartung',1,6,1,7,1,5),
(8,'El juego del calamar',1,9,1,7,1,4),
(9,'Nuevo sabor a cereza',1,8,1,8,1,7),
(10,'La cocinera de Castamar',1,12,1,3,1,6),
(11,'Quien mató a Sarah',2,18,1,7,1,11),
(12,'Sexo/Vida',1,8,1,3,1,7),
(13,'Black Mirror',5,22,1,6,1,25),
(14,'El inocente',1,8,1,7,1,6),
(15,'Sexify',1,8,1,2,1,13),
(16,'La serpiente',1,8,1,7,1,25),
(17,'Luis Miguel la Serie',3,27,1,3,1,11),
(18,'SKY rojo',2,16,1,1,1,6),
(19,'Detrás de sus ojos',1,6,1,9,1,25),
(20,'Amor y Anarquía',1,8,1,3,1,28),
(21,'El desorden que dejas',1,8,1,7,1,6),
(22,'Ozark',4,37,1,9,1,7),
(23,'Bridgerton',1,8,1,3,1,7),
(24,'Crown',4,40,1,3,1,25),
(25,'Outlander',5,67,1,3,1,7),
(26,'Monarca',2,18,1,3,1,11),
(27,'Equinox',1,6,1,9,1,5),
(28,'Ratched',1,8,1,7,1,7),
(29,'Élite',4,32,1,7,1,6),
(30,'White lines',1,10,1,7,1,25),
(31,'Narcos: México',3,30,1,1,1,7),
(32,'El jurado',1,10,1,3,1,21),
(33,'Valeria',2,16,1,2,1,6),
(34,'Hache',2,14,1,9,1,6),
(35,'Sex education',3,24,1,3,1,25),
(36,'Mesias',1,10,1,7,1,7),
(37,'Califato',1,8,1,3,1,28),
(38,'13 reason why',4,49,1,7,1,7),
(39,'The Witcher',2,16,1,10,1,7),
(40,'Bonding',2,15,1,3,1,7),
(41,'Cómo vender drogas en línea',3,18,1,2,1,1),
(42,'El sabor de las margaritas',2,12,1,7,1,6),
(43,'El reto del beso',1,6,1,7,1,22),
(44,'Casi feliz',1,10,1,2,1,18),
(45,'Vampiros',1,6,1,8,1,8),
(46,'Mortal',2,12,1,7,1,8),
(47,'Jugar con fuego (reality)',3,29,1,11,1,7),
(48,'Easy',3,25,1,2,1,7),
(49,'El perfume',1,6,1,9,1,1),
(50,'Oscuro deseo',2,33,1,7,1,11),
(51,'Suburra: Sangre sobre Roma',3,24,1,9,1,10),
(52,'Freud',1,8,1,7,1,20),
(53,'Case',1,9,1,9,1,28),
(54,'Sorjonen',3,31,1,3,1,24),
(55,'13 mandamientos',1,13,1,9,1,21),
(56,'Tabula Rasa',1,9,1,7,1,21),
(57,'Dark',3,26,1,6,1,1),
(58,'The sinner',4,32,1,7,1,7),
(59,'Secret City',2,12,1,7,1,19),
(60,'Jugar con fuego',1,10,1,7,1,11),
(61,'Hasta que la vida nos separe',1,8,1,2,1,27),
(62,'Ju-on: streaming_services',1,6,1,8,1,26);

INSERT INTO seasons (id,season,chapters) VALUES (1,1,8),
(2,1,9),
(3,1,6),
(4,1,12),
(5,1,10),
(6,1,3),
(7,1,13),
(8,1,7),
(9,1,18),
(10,1,11),
(11,2,8),
(12,2,4),
(13,2,10),
(14,2,13),
(15,2,6),
(16,2,15),
(17,3,6),
(18,3,10),
(19,3,13),
(20,3,8),
(21,3,9),
(22,4,6),
(23,4,7),
(24,4,10),
(25,4,13),
(26,4,8),
(27,5,3),
(28,5,12),
(29,1,16);

INSERT INTO series_seasons (id,serie_id,season_id) VALUES (1,6,3),
(2,7,3),
(3,19,3),
(4,27,3),
(5,43,3),
(6,45,3),
(7,49,3),
(8,62,3),
(9,1,1),
(10,2,1),
(11,3,1),
(12,5,1),
(13,9,1),
(14,12,1),
(15,14,1),
(16,15,1),
(17,16,1),
(18,20,1),
(19,21,1),
(20,23,1),
(21,28,1),
(22,37,1),
(23,52,1),
(24,61,1),
(25,4,2),
(26,8,2),
(27,53,2),
(28,56,2),
(29,30,5),
(30,32,5),
(31,36,5),
(32,44,5),
(33,60,5),
(34,10,4),
(35,55,7),
(36,11,5),
(37,18,1),
(38,26,5),
(39,33,1),
(40,34,1),
(41,39,8),
(42,40,7),
(43,42,3),
(44,46,6),
(45,50,9),
(46,59,3),
(47,11,11),
(48,18,11),
(49,26,11),
(50,33,11),
(51,34,15),
(52,39,11),
(53,40,11),
(54,42,15),
(55,46,6),
(56,50,16),
(57,59,15),
(58,17,7),
(59,31,5),
(60,35,1),
(61,41,6),
(62,47,9),
(63,48,1),
(64,51,5),
(65,54,10),
(66,57,5),
(67,17,11),
(68,31,13),
(69,35,11),
(70,41,15),
(71,47,13),
(72,48,11),
(73,51,11),
(74,54,13),
(75,57,11),
(76,17,17),
(77,31,18),
(78,35,20),
(79,41,17),
(80,47,18),
(81,48,21),
(82,51,17),
(83,54,18),
(84,57,20),
(85,22,5),
(86,24,5),
(87,29,1),
(88,38,7),
(89,58,1),
(90,22,13),
(91,24,13),
(92,29,11),
(93,38,14),
(94,58,11),
(95,22,18),
(96,24,18),
(97,29,20),
(98,38,19),
(99,58,20),
(100,22,23),
(101,24,24),
(102,29,26),
(103,38,24),
(104,58,26),
(105,13,6),
(106,25,29),
(107,13,12),
(108,25,14),
(109,13,17),
(110,25,19),
(111,13,22),
(112,25,25),
(113,13,27),
(114,25,28);

INSERT INTO users (id,login,pass,user_name) VALUES (1,'mikelm3','Mk2022','Miguel Angel López');

INSERT INTO user_movies (id,movie_view,movie_id,user_id) VALUES (1,1,1,1),
(2,0,2,1),
(3,0,3,1),
(4,0,4,1),
(5,0,5,1),
(6,0,6,1),
(7,1,7,1),
(8,1,8,1),
(9,1,9,1),
(10,0,10,1),
(11,0,11,1),
(12,1,12,1),
(13,1,13,1),
(14,1,14,1),
(15,0,15,1),
(16,0,16,1),
(17,0,17,1),
(18,0,18,1),
(19,0,19,1),
(20,0,20,1),
(21,1,21,1),
(22,0,22,1),
(23,1,23,1),
(24,0,24,1),
(25,1,25,1),
(26,0,26,1),
(27,1,27,1),
(28,1,28,1),
(29,0,29,1),
(30,1,30,1),
(31,0,31,1),
(32,1,32,1),
(33,1,33,1),
(34,0,34,1),
(35,0,35,1),
(36,1,36,1),
(37,1,37,1),
(38,1,38,1),
(39,1,39,1),
(40,1,40,1),
(41,1,41,1),
(42,1,42,1),
(43,1,43,1),
(44,1,44,1),
(45,1,45,1),
(46,1,46,1),
(47,1,47,1),
(48,1,48,1),
(49,0,49,1),
(50,1,50,1),
(51,1,51,1),
(52,1,52,1),
(53,1,53,1),
(54,1,54,1),
(55,0,55,1),
(56,1,56,1),
(57,0,57,1),
(58,1,58,1),
(59,1,59,1),
(60,1,60,1),
(61,1,61,1),
(62,1,62,1),
(63,1,63,1),
(64,0,64,1),
(65,0,65,1),
(66,1,66,1),
(67,1,67,1),
(68,1,68,1),
(69,1,69,1),
(70,1,70,1),
(71,1,71,1),
(72,0,72,1),
(73,0,73,1),
(74,1,74,1),
(75,1,75,1),
(76,0,76,1),
(77,0,77,1),
(78,0,78,1),
(79,1,79,1),
(80,0,80,1),
(81,0,81,1),
(82,0,82,1),
(83,1,83,1),
(84,1,84,1),
(85,1,85,1),
(86,1,86,1),
(87,0,87,1),
(88,1,88,1),
(89,0,89,1),
(90,1,90,1);

INSERT INTO user_series (id,serie_view,serie_season_id,user_id) VALUES (1,1,1,1),
(2,1,2,1),
(3,1,3,1),
(4,1,4,1),
(5,0,5,1),
(6,0,6,1),
(7,1,7,1),
(8,0,8,1),
(9,0,9,1),
(10,0,10,1),
(11,0,11,1),
(12,0,12,1),
(13,1,13,1),
(14,1,14,1),
(15,1,15,1),
(16,1,16,1),
(17,0,17,1),
(18,1,18,1),
(19,1,19,1),
(20,1,20,1),
(21,1,21,1),
(22,0,22,1),
(23,1,23,1),
(24,0,24,1),
(25,0,25,1),
(26,0,26,1),
(27,1,27,1),
(28,1,28,1),
(29,1,29,1),
(30,1,30,1),
(31,1,31,1),
(32,0,32,1),
(33,1,33,1),
(34,1,34,1),
(35,1,35,1),
(36,1,36,1),
(37,1,37,1),
(38,1,38,1),
(39,1,39,1),
(40,1,40,1),
(41,0,41,1),
(42,0,42,1),
(43,1,43,1),
(44,0,44,1),
(45,1,45,1),
(46,1,46,1),
(47,1,47,1),
(48,0,48,1),
(49,1,49,1),
(50,1,50,1),
(51,1,51,1),
(52,0,52,1),
(53,0,53,1),
(54,0,54,1),
(55,0,55,1),
(56,1,56,1),
(57,1,57,1),
(58,0,58,1),
(59,0,59,1),
(60,1,60,1),
(61,0,61,1),
(62,0,62,1),
(63,1,63,1),
(64,0,64,1),
(65,1,65,1),
(66,1,66,1),
(67,0,67,1),
(68,0,68,1),
(69,1,69,1),
(70,0,70,1),
(71,0,71,1),
(72,1,72,1),
(73,0,73,1),
(74,1,74,1),
(75,1,75,1),
(76,0,76,1),
(77,0,77,1),
(78,0,78,1),
(79,0,79,1),
(80,0,80,1),
(81,1,81,1),
(82,0,82,1),
(83,1,83,1),
(84,1,84,1),
(85,1,85,1),
(86,1,86,1),
(87,0,87,1),
(88,1,88,1),
(89,1,89,1),
(90,1,90,1),
(91,1,91,1),
(92,0,92,1),
(93,1,93,1),
(94,1,94,1),
(95,1,95,1),
(96,0,96,1),
(97,0,97,1),
(98,1,98,1),
(99,1,99,1),
(100,0,100,1),
(101,0,101,1),
(102,0,102,1),
(103,1,103,1),
(104,1,104,1),
(105,1,105,1),
(106,0,106,1),
(107,1,107,1),
(108,0,108,1),
(109,1,109,1),
(110,0,110,1),
(111,1,111,1),
(112,0,112,1),
(113,1,113,1),
(114,0,114,1);