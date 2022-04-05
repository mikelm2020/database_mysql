

import pymysql
import pandas as pd

AGE_RATINGS_SCHEMA = ['age_rating']

MOVIE_GENRES_SCHEMA = ['movie_genre']

ORIGIN_COUNTRIES_SCHEMA = ['origin_country', 'iso_code']

MOVIES_SCHEMA = ['movie_name', 'duration', 'movie_year', 
                'streaming_service_id', 'movie_genre_id', 
                'age_rating_id', 'origin_country_id'
                ]


def dataframe_connect(data_frame):
    df = pd.read_csv(data_frame)
    # df = df.query('type == "Movie"')
    # values_list = list(df['title'])

    return df


def database_connect(host_name, user_name, passwd, db_name):
    conection = pymysql.connect(host=host_name,
                             user=user_name,
                             password=passwd,
                             db=db_name)
    return conection


def find_fk(fk):
    pass

def database_insert(table_name):
    try:
        conection = database_connect('localhost', 'root',
                                     'T3cn02$SL', 'streaming')

        # Conect to the dataframe of Netflix with pandas
        data_frame_netflix = dataframe_connect('../data/netflix.csv')

        # Conect to the dataframe of iso contries code with pandas
        data_frame_iso_codes = dataframe_connect('../data/paises.csv')

        # Generate the string for command INSERT in the table
        sql_insert = "INSERT INTO " + table_name + "("
        field_count = 0 # Initialize the fields'count
        sql_values = "VALUES ("
        fields_list = []
        list_df_age_rating = []
        list_df_movie_genre = []
        list_df_origin_country = []
        list_origin_country = []
        string_origin_country = ''
        set_origin_country = {}

        if table_name == 'age_ratings':
            fields_list = AGE_RATINGS_SCHEMA

        if table_name == 'movie_genres':
            fields_list = MOVIE_GENRES_SCHEMA

        if table_name == 'origin_countries':
            fields_list = ORIGIN_COUNTRIES_SCHEMA

        if table_name == 'movies':
            fields_list = MOVIES_SCHEMA


        for field in fields_list:
            sql_insert = sql_insert + field
            field_count +=1
            if field_count < len(fields_list):
                sql_insert = sql_insert + ', '
            else:
                sql_insert = sql_insert + ')'

            if table_name == 'age_ratings':
                # Filter of dataframe by rating
                df_age_rating = data_frame_netflix['rating'].unique()
                list_df_age_rating = list(df_age_rating)

            if table_name == 'movie_genres':
                 # Filter of dataframe by listed_in
                df_movie_genre = data_frame_netflix['listed_in'].unique()
                list_df_movie_genre = list(df_movie_genre)

            if table_name == 'origin_countries':
                # Filter of dataframe by country
                df_origin_country_unique = data_frame_netflix['country'].unique()
                df_origin_country = data_frame_netflix['country'].str.split(',')
                list_df_origin_country = list(df_origin_country[0])
                list_origin_country = [element for element 
                                       in list_df_origin_country
                                       if pd.isnull(element) == False
                                       ]
                # string_origin_country = ','.join(list_origin_country)
                set_origin_country = set(','.join(list_origin_country))
                print(df_origin_country)

            if table_name == 'movies':
                fields_list = MOVIES_SCHEMA

        # for element in fields_list:
        #     for key,value in element.items():
        #         if key == 'field':
        #             sql_insert = sql_insert + value
        #             field_count +=1

        #             if field_count < len(fields_list):
        #                 sql_insert = sql_insert + ', '
        #             else:
        #                 sql_insert = sql_insert + ')'
        #         else:
        #             if key == 'fk':
        #                 if value:
        #                     sql_values = sql_values + find_fk(fk)
        #                 else:
        #                     sql_values = sql_values + value

        
                
                
                
        
        # for field in fields:
        #     sql = sql + field
        #     field_count +=1

        #     if field_count < len(fields):
        #         sql = sql + ', '
        #     else:
        #         sql = sql + ')'

        # try:
        #     with conection.cursor() as cursor:
        #         consulta = "INSERT INTO peliculas(titulo, anio) VALUES (%s, %s);"
        #     conection.commit()
        # finally:
        #     conection.close()
        return list_df_origin_country

    except (pymysql.err.OperationalError, pymysql.err.InternalError) as e:
        print("Ocurrió un error al conectar: ", e)
 	

if __name__ == '__main__':
    # command = database_insert('Movies',MOVIES_SCHEMA)
    # command = dataframe_connect('../data/movies.csv')
    # print(command['Country'])
    # print(list(command['country']))
    sql = database_insert('origin_countries')
    #print(sql)


# try:
# 	conection = database_connect('localhost', 'root', 'T3cn02$SL', 'streaming')
# 	try:
# 		with conection.cursor() as cursor:
# 			consulta = "INSERT INTO peliculas(titulo, anio) VALUES (%s, %s);"
# 			#Podemos llamar muchas veces a .execute con datos distintos
# 			cursor.execute(consulta, ("Volver al futuro 1", 1985))
# 			cursor.execute(consulta, ("Ready Player One", 2018))
# 			cursor.execute(consulta, ("It", 2017))
# 			cursor.execute(consulta, ("Pulp Fiction", 1994))
# 		conection.commit()
# 	finally:
# 		conection.close()
# except (pymysql.err.OperationalError, pymysql.err.InternalError) as e:
# 	print("Ocurrió un error al conectar: ", e)