import os
from webbrowser import get

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
        conection = database_connect(os.environ.get('DB_HOST'), os.environ.get('DB_USER'),
                                     os.environ.get('DB_PASS'), os.environ.get('DB_NAME'))

        # Conect to the dataframe of Movies with pandas
        data_frame_movies = dataframe_connect('../data/movies.csv')
        # Create a new dataframe with especifics columns
        cols = ['ID', 'Title', 'Year', 'Age', 'Netflix', 'Prime Video', 'Disney+', 
                'Genres', 'Country', 'Runtime']
        movies_set = data_frame_movies[cols]

        # Conect to the dataframe of Netflix with pandas
        data_frame_netflix = dataframe_connect('../data/netflix.csv')

        # Conect to the dataframe of iso contries code with pandas
        data_frame_iso_codes = dataframe_connect('../data/paises.csv')

        
        sql_insert = "INSERT INTO " + table_name + "("
        field_count = 0 # Initialize the fields'count
        sql_values = "VALUES ("
        fields_list = []
        list_df_age_rating = []
        list_df_movie_genre = []        

        if table_name == 'age_ratings':
            fields_list = AGE_RATINGS_SCHEMA

        if table_name == 'movie_genres':
            fields_list = MOVIE_GENRES_SCHEMA

        if table_name == 'origin_countries':
            fields_list = ORIGIN_COUNTRIES_SCHEMA

        if table_name == 'movies':
            fields_list = MOVIES_SCHEMA

        # Generate the string for command INSERT in the table
        for field in fields_list:
            sql_insert = sql_insert + field
            field_count +=1
            if field_count < len(fields_list):
                sql_insert = sql_insert + ', '
            else:
                sql_insert = sql_insert + ')'

        if table_name == 'age_ratings':
            # Filter of dataframe by rating
            df_age_rating = movies_set['Age'].unique()
            list_df_age_rating = list(df_age_rating)

        if table_name == 'movie_genres':
                # Filter of dataframe by listed_in
            df_movie_genre = movies_set['Genres'].unique()
            list_df_movie_genre = list(df_movie_genre)

        if table_name == 'origin_countries':

            # function explode() for split the list for each element and
            # create a new row for each of them 

            countries_list = (movies_set['Country'].str.split(',').
                                explode().unique()).tolist()
            
            print(countries_list)

    except (pymysql.err.OperationalError, pymysql.err.InternalError) as e:
        print("Ocurrió un error al conectar: ", e)
 	

if __name__ == '__main__':
    database_insert('origin_countries')
