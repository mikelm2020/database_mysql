import csv
import os
import time


import pymysql
import pymysql.cursors
import pandas as pd
from faker import Faker


AGE_RATINGS_SCHEMA = ['age_rating']

FILM_GENDERS_SCHEMA = ['movie_gender']

ORIGIN_COUNTRIES_SCHEMA = ['origin_country', 'iso_code']

MOVIES_SCHEMA = ['movie_name', 'duration', 'movie_year',
                 'age_rating_id']

STREAMING_SERVICES_SCHEMA = ['streaming_service']

USERS_SCHEMA = ['login', 'pass', 'user_name']

SERIES_SCHEMA = ['serie_name', 'seasons', 'serie_year', 'age_rating_id']

MOVIES_TMP_SCHEMA = ['title', 'netflix',
                     'prime', 'disney', 'genres', 'country']
                    
MOVIE_GENRES_TMP_SCHEMA = ['title', 'genre']

MOVIE_COUNTRIES_TMP_SCHEMA = ['title', 'country']

SERIES_TMP_SCHEMA = ['title', 'country', 'listed_in', 'type', 'rating']

SERIE_GENRES_TMP_SCHEMA = ['title', 'listed_in']

SERIE_COUNTRIES_TMP_SCHEMA = ['title', 'country']


def execute_insert_two(table_name, field_1, field_2, obj_list, conect_obj):
    sql_command = f"INSERT INTO {table_name} ({field_1}, {field_2}) VALUES (%s, %s)"
    try:
        with conect_obj.cursor() as cursor:
            counter_command = "Select count(*) from " + table_name
            cursor.execute(counter_command)
            # Return the count of registers.
            registers_count = cursor.fetchone()[0]

            # If the count is zero then excute the command.
            if registers_count == 0:
                cursor.executemany(sql_command, obj_list)
                message_success('the process of insertion was successful')
            else:
                print('The table {}'.format(table_name) +
                      ' you already have records')

        conect_obj.commit()
    finally:
        conect_obj.close()
    

def generate_list_multivalue(obj_list, table_name, field_multi):
    list_multival = []
    new_list = []
    i = 0
    j = 0
    step = 0
    if table_name == 'movies_tmp':

        step = 6
        if field_multi == 'genres':
            # Index of field genres
            j = 4

        if field_multi == 'country':
            # Index of field country
            j = 5

    if table_name == 'series_tmp':

        step = 5
        if field_multi == 'listed_in':
            # Index of field listed_in
            j = 2

        if field_multi == 'country':
            # Index of field country
            j = 1

    while i < len(obj_list):
        list_multival.append(obj_list[i])
        list_multival.append(obj_list[j])
        i += step
        j += step

    k = 0
    title = ''
    multival = ''
    # Split the list of multivalues
    for element in list_multival:
        if k == 0:
            k += 1
            title = element
        elif k == 1:
            multival = ''.join(element).split(',')
            for word in multival:
                new_list.append((title, word))
                k = 0

    return new_list


def insert_temporal_to_list(obj_list):
    """Generate a list completed with values of the list of lists of temporal tables

    Args:
        obj_list (list): list obtained from data set of temporal table how a list of lists

    Returns:
        list: list converted with values in only list
    """

    list_catalogs = []

    for list_element in obj_list:
        for element in list_element:
            if type(element) == str:
                value_element = element
            elif type(element) == float:
                value_element = str(int(element))
            else:
                value_element = str(element)
            list_catalogs.append(value_element)

    return list_catalogs


def export_df(table_name):
    # Generate the conection to mySQL database.
    try:
        conection = database_connect(os.environ.get('DB_HOST'),
                                     os.environ.get('DB_USER'),
                                     os.environ.get('DB_PASS'),
                                     os.environ.get('DB_NAME'))

        # Create an empty dataframe
        df = pd.DataFrame()

        if table_name == 'movies_tmp':
            df = create_movies_set()
            cols = ['Title', 'Netflix', 'Prime', 'Disney', 'Genres', 'Country']
            query = 'Netflix == 1 | Prime == 1 | Disney == 1'
            # Convert to list the dataset
            catalog_list = df.query(query)[cols].values.tolist()
            # Convert in a unique list
            list_temporal = insert_temporal_to_list(catalog_list)
            sql_command = insert_fields_statement(table_name, list_temporal)
            execute_statement(sql_command, conection, table_name)

        if table_name == 'movie_genres_tmp':
            df = create_movies_set()
            cols = ['Title', 'Netflix', 'Prime', 'Disney', 'Genres', 'Country']
            query = 'Netflix == 1 | Prime == 1 | Disney == 1'
            # Convert to list the dataset
            catalog_list = df.query(query)[cols].values.tolist()
            # Convert in a unique list
            list_temporal = insert_temporal_to_list(catalog_list)
            # Generate a list with multivalues data for genres
            list_multi = generate_list_multivalue(list_temporal, 'movies_tmp', 'genres')
            execute_insert_two(table_name, 'title', 'genre', list_multi, conection)

        if table_name == 'movie_countries_tmp':
            df = create_movies_set()
            cols = ['Title', 'Netflix', 'Prime', 'Disney', 'Genres', 'Country']
            query = 'Netflix == 1 | Prime == 1 | Disney == 1'
            # Convert to list the dataset
            catalog_list = df.query(query)[cols].values.tolist()
            # Convert in a unique list
            list_temporal = insert_temporal_to_list(catalog_list)
            # Generate a list with multivalues data for country in movies
            list_multi = generate_list_multivalue(list_temporal, 'movies_tmp', 'country')
            execute_insert_two(table_name, 'title', 'country', list_multi, conection)
            

        if table_name == 'series_tmp':
            df = create_series_set()
            cols = ['title', 'country', 'listed_in', 'type', 'rating']
            query = "type == 'TV Show' & (rating == 'TV-MA' | rating == 'PG-13' | rating == 'PG' | \
                rating == 'TV-Y7' | rating == 'R' | rating == 'G' | rating == 'NC-17')"
            # Convert to list the dataset
            catalog_list = df.query(query)[cols].values.tolist()
            # Convert in a unique list of series for table temporal
            list_temporal = insert_temporal_to_list(catalog_list)
            sql_command = insert_fields_statement(table_name, list_temporal)
            execute_statement(sql_command, conection, table_name)

        if table_name == 'serie_genres_tmp':
            df = create_series_set()
            cols = ['title', 'country', 'listed_in', 'type', 'rating']
            query = "type == 'TV Show' & (rating == 'TV-MA' | rating == 'PG-13' | rating == 'PG' | \
                rating == 'TV-Y7' | rating == 'R' | rating == 'G' | rating == 'NC-17')"
            # Convert to list the dataset
            catalog_list = df.query(query)[cols].values.tolist()
            # Convert in a unique list
            list_temporal = insert_temporal_to_list(catalog_list)
            # Generate a list with multivalues data for listed_in in series
            list_multi = generate_list_multivalue(list_temporal, 'series_tmp', 'listed_in')
            execute_insert_two(table_name, 'title', 'listed_in', list_multi, conection)

        if table_name == 'serie_countries_tmp':
            df = create_series_set()
            cols = ['title', 'country', 'listed_in', 'type', 'rating']
            query = "type == 'TV Show' & (rating == 'TV-MA' | rating == 'PG-13' | rating == 'PG' | \
                rating == 'TV-Y7' | rating == 'R' | rating == 'G' | rating == 'NC-17')"
            # Convert to list the dataset
            catalog_list = df.query(query)[cols].values.tolist()
            # Convert in a unique list
            list_temporal = insert_temporal_to_list(catalog_list)
            # Generate a list with multivalues data for country in series
            list_multi = generate_list_multivalue(list_temporal, 'series_tmp', 'country')
            execute_insert_two(table_name, 'title', 'country', list_multi, conection)

    except (pymysql.err.OperationalError, pymysql.err.InternalError) as e:
        print("An error occurred while connecting: ", e)


def find_key(id_field, table_name, field, data_find):
    """Find the value of the foreign key of the tables

    Generating a command:
    SELECT id_field FROM table_name WHERE field = data_find

    Args:
        id_field (str): Field of foreign key
        table_name (str): name of the table with the foreign key
        field (str): Field of the value to find
        data_find (str): value to find

    Returns:
        int: The primary key of the table how parameter
    """
    sql_command = ''
    fk_data = 0
    conect_obj = database_connect(os.environ.get('DB_HOST'),
                                  os.environ.get('DB_USER'),
                                  os.environ.get('DB_PASS'),
                                  os.environ.get('DB_NAME'))

    try:
        with conect_obj.cursor(pymysql.cursors.DictCursor) as cursor:
            sql_command = "Select "
            sql_command += id_field + " from " + table_name + " Where " + \
                field + "='%s'"
            cursor.execute(sql_command % data_find)
            # Return the id from the table
            for row in cursor:
                fk_data = row[id_field]

        conect_obj.commit()
    finally:
        conect_obj.close()
    return fk_data


def map_fk(fk_value_find):
    """Dictionary of age ratings for map ratings from netflix.csv dataset

    Args:
        fk_value_find (int): Foreign key of netflix.csv dataset

    Returns:
        int: Id from table Age_ratings
    """
    dict_age_ratings = {
        'PG-13': 1,
        'TV-MA': 2,
        'PG': 4,
        'TV-Y7': 3,
        'R': 2,
        'G': 4,
        'NC-17': 5
    }

    # Search the key
    return dict_age_ratings.get(fk_value_find, 0)


def insert_catalogs_to_list(obj_list, table_name):
    """Generate a list completed with values of the list of lists of full catalogs

    Args:
        obj_list (list): list obtained from data set of full catalogs how a list of lists
        table_name (str): name of the table with the foreign key

    Returns:
        list: list converted with values of foreign keys
    """
    fk_value = 0
    list_catalogs = []

    # if table_name == 'movies':
    for list_element in obj_list:
        for element in list_element:
            if list_element.index(element) == len(list_element) - 1:
                if table_name == 'movies':
                    fk_value = find_key('id', 'age_ratings',
                                        'age_rating', element)
                if table_name == 'series':
                    #  Map the value of age_rating of the list with the value
                    # on tha table age_aratings
                    fk_value = map_fk(element)

                list_catalogs.append(str(fk_value))
            else:
                list_catalogs.append(element if type(element)
                                     == str else str(element))

    return list_catalogs


def obtain_data(obj_list, table_name):
    """Function for obtain data from full catalogs set for each table needed

    Args:
        obj_list (list): List obtained from full catalogs set in pure form
        table_name (str): Table by fill with data from full catalogs set

    Returns:
        list: List with the information required for fill the table
    """
    list_table = []
    sql_command = ''
    if table_name == 'movies':
        list_table = insert_catalogs_to_list(obj_list, 'movies')
    if table_name == 'series':
        list_table = insert_catalogs_to_list(obj_list, 'series')

    return list_table


def generate_catalogs(table_name):
    """Generate the list with information of full catalogs from data set movies.csv
    or netflix.csv

    Args:
        table_name (str): Name of the table of a full catalog how: movies, series, etc

    Returns:
        list: List with information of movies or series in pure form
    """
    catalog_list = []
    if table_name == 'movies':
        # Create the movies_set with movies of the dataset movies.csv
        movies_set = create_movies_set()

        # Filter the movies_set by Netflix or Amazon Prime or Disney+
        cols = ['Title', 'Runtime', 'Year', 'Age']
        query = 'Netflix == 1 | Prime == 1 | Disney == 1'
        # Convert to list the dataset
        movie_name_list = movies_set.query(query)[cols].values.tolist()
        # Create the string for insert data for the table movies
        catalog_list = obtain_data(movie_name_list, 'movies')

    if table_name == 'series':
        # Create the series set with series of the dataset netflix.csv
        series_set = create_series_set()
        # Define columns for table series
        cols = ['title', 'season', 'release_year', 'rating']
        # Convert to list the dataset
        series_name_list = series_set[cols].values.tolist()

        # Create the string for insert data for the table series
        catalog_list = obtain_data(series_name_list, 'series')

    return catalog_list


def create_series_set():
    """Obtain the series set with information of the file netflix.csv

    Returns:
        DataFrame: Dataframe of Pandas with the information of series from netflix.csv
    """
    # Conect to the dataframe of Serires with pandas.
    series_path = relative_path('netflix.csv')
    data_frame_series = dataframe_connect(series_path)

    # Delete records with nan values.
    data_frame_series = data_frame_series.dropna()

    # Create a new column season with the number of seasons
    data_frame_series['season'] = data_frame_series['duration'].str.slice(0, 1)

    # Filter the dataframe with series of Netfix and this age ratings
    string_sql = "type == 'TV Show' & (rating == 'TV-MA' | rating == 'PG-13' | rating == 'PG' | \
                rating == 'TV-Y7' | rating == 'R' | rating == 'G' | rating == 'NC-17')"
    df_series_filter = data_frame_series.query(string_sql)

    # Create a new dataframe with especifics columns.
    cols = ['show_id', 'type', 'title', 'country', 'release_year', 'rating',
            'season', 'listed_in']
    catalogs_set = df_series_filter[cols]

    return catalogs_set


def create_movies_set():
    """Obtain the movies set with information of the file movies.csv

    Returns:
        DataFrame: Dataframe of Pandas with the information of movies from movies.csv
    """
    # Conect to the dataframe of Movies with pandas.
    movies_path = relative_path('movies.csv')
    data_frame_movies = dataframe_connect(movies_path)

    # Rename the column's name Prime Video and Disney+.
    data_frame_movies = data_frame_movies.rename(
        columns={'Prime Video': 'Prime', 'Disney+': 'Disney'})

    # Delete records with nan values.
    data_frame_movies = data_frame_movies.dropna()

    # Filter the dataframe with movies of Netfix, Prime and Disney+.
    df_movies_filter = data_frame_movies.query(
        "Netflix == 1 | Prime == 1 | Disney == 1 ")

    # Create a new dataframe with especifics columns.
    cols = ['ID', 'Title', 'Year', 'Age', 'Netflix', 'Prime', 'Disney',
            'Genres', 'Country', 'Runtime']
    catalogs_set = df_movies_filter[cols]

    return catalogs_set


def full_catalogs(table_name):
    """Create of the full catalog how movies, series for database streaming

    Args:
        table_name (str): name of the table of the full catalog
    """
    # Generate the conection to mySQL database.
    try:
        conection = database_connect(os.environ.get('DB_HOST'),
                                     os.environ.get('DB_USER'),
                                     os.environ.get('DB_PASS'),
                                     os.environ.get('DB_NAME'))

        catalog_list = []
        sql_command = ''

        if table_name == 'movies':
            # List of movies with data for the schema
            catalog_list = generate_catalogs('movies')
            sql_command = insert_fields_statement('movies', catalog_list)
            execute_statement(sql_command, conection, 'movies')

        if table_name == 'series':
            # List of series with data for the schema
            catalog_list = generate_catalogs('series')
            sql_command = insert_fields_statement('series', catalog_list)
            execute_statement(sql_command, conection, 'series')

        print(sql_command)

    except (pymysql.err.OperationalError, pymysql.err.InternalError) as e:
        print("An error occurred while connecting: ", e)


def user_profile():
    """Function for generate random data with the package Faker for 100 users

    Returns:
        list: List with random data for the user profile
    """
    fake = Faker()
    Faker.seed(0)
    user_list = []

    for _ in range(100):
        user_list.extend(
            [fake.user_name()[0:9], fake.password(length=10), fake.name()])

    return user_list


def insert_fields_statement(table_name, list_obj):
    """Generate a string with the command INSERT INTO for the table table_name
    with values of the list

    Args:
        table_name (str): Name of the table for the command
        list_obj (list): List with the values to insert to the table

    Returns:
        _type_: _description_
    """
    sql_string = "INSERT INTO " + table_name
    sql_values = " VALUES"
    fields_list = []

    sql_string = sql_string + '('

    if table_name == 'users':
        fields_list = USERS_SCHEMA

    if table_name == 'movies':
        fields_list = MOVIES_SCHEMA

    if table_name == 'series':
        fields_list = SERIES_SCHEMA

    if table_name == 'movies_tmp':
        fields_list = MOVIES_TMP_SCHEMA

    if table_name == 'series_tmp':
        fields_list = SERIES_TMP_SCHEMA

    if table_name == 'serie_genres_tmp':
        fields_list = SERIE_GENRES_TMP_SCHEMA

    if table_name == 'serie_countries_tmp':
        fields_list = SERIE_COUNTRIES_TMP_SCHEMA

    if table_name == 'movie_genres_tmp':
        fields_list = MOVIE_GENRES_TMP_SCHEMA

    if table_name == 'movie_countries_tmp':
        fields_list = MOVIE_COUNTRIES_TMP_SCHEMA


    for field in fields_list:
        sql_string += field
        index_field = fields_list.index(field)

        if index_field == len(fields_list) - 1:
            character = ')'
        else:
            character = ','

        sql_string += character

    # Add values
    index_field = 0
    sql_string += sql_values
    for element in list_obj:
        index_element = list_obj.index(element)
        if index_field == 0:
            if index_element == 0:
                sql_string += '('
            else:
                sql_string += ',('
            sql_string += "'" + element + "'"
            index_field += 1
        elif index_field == len(fields_list) - 1:
            sql_string += ", '" + element + "'"
            sql_string += ')'
            index_field = 0
        else:
            sql_string += ', '
            sql_string += "'" + element + "'"
            index_field += 1

    return sql_string


def catalog_users():
    """Generation of the catalog users in the database streaming
    """
    try:
        conection = database_connect(os.environ.get('DB_HOST'),
                                     os.environ.get('DB_USER'),
                                     os.environ.get('DB_PASS'),
                                     os.environ.get('DB_NAME'))
        profile_list = []
        sql_command = ''

        profile_list = user_profile()
        sql_command = insert_fields_statement('users', profile_list)
        execute_statement(sql_command, conection, 'users')

    except (pymysql.err.OperationalError, pymysql.err.InternalError) as e:
        print("An error occurred while connecting: ", e)


def relative_path(file_name):
    """Generation of a relative path for read the datasets of files .csv 

    Args:
        file_name (str): name of the file .csv

    Returns:
        str: The relative path
    """
    current_path = os.path.dirname(os.path.abspath(__file__))
    return os.path.join(current_path, '..', 'data', file_name)


def dataframe_connect(data_frame):
    """Generation of the dataframe with Pandas module from files .csv

    Args:
        data_frame (str): path complete with the name of file .csv

    Returns:
        DataFrame: Dataframe of Pandas of the file .csv
    """
    df = pd.read_csv(data_frame)

    return df


def database_connect(host_name, user_name, passwd, db_name):
    """Connection to the database streaming with the package pyMySQL

    Args:
        host_name (str): Name of host MySQL
        user_name (str): User for the connection (root)
        passwd (str): Password of the user
        db_name (str): Name of the database

    Returns:
        connection: Connection to the database streaming
    """
    conection = pymysql.connect(host=host_name,
                                user=user_name,
                                password=passwd,
                                db=db_name)
    return conection


def find_iso(dict_obj, country_name):
    """Function to find iso codes of countries in dictionary

    Args:
        dict_obj (dict): Dictionary obtained from file paises.csv
        country_name (str): Name of the country to find iso code

    Returns:
        str: ISO code of the country
    """
    if country_name in dict_obj:
        # Return tne value of the key country_name.
        return dict_obj[country_name]
    else:
        return '000'


def message_success(message):
    """Message successful of the process
    """
    print(message)


def execute_statement(sql_command, conect_obj, table_name):
    """Function for execute a command of insertion to the database

    Args:
        sql_command (str): Command of insertion
        conect_obj (connection): Conection to the database streaming
        table_name (str): Name of the table to insert data
    """
    counter_command = ''
    try:
        with conect_obj.cursor() as cursor:
            counter_command = "Select count(*) from " + table_name
            cursor.execute(counter_command)
            # Return the count of registers.
            registers_count = cursor.fetchone()[0]

            # If the count is zero then excute the command.
            if registers_count == 0:
                cursor.execute(sql_command)
                message_success('the process of insertion was successful')
            else:
                print('The table {}'.format(table_name) +
                      ' you already have records')

        conect_obj.commit()
    finally:
        conect_obj.close()


def catalog_insert(table_name):
    """Funtion for generate litle catalogs of the database streaming

    Args:
        table_name (str): Name of the table of litle catalog how: age_ratings,
        film_genders,origin_countries and streaming_services
    """
    try:
        conection = database_connect(os.environ.get('DB_HOST'),
                                     os.environ.get('DB_USER'),
                                     os.environ.get('DB_PASS'),
                                     os.environ.get('DB_NAME'))
        movies_list = []
        countries_list = []

        movies_set = create_movies_set()

        # Conect to the dataframe of Netflix with pandas.
        # netflix_path = relative_path('netflix.csv')
        # data_frame_netflix = dataframe_connect(netflix_path)

        if table_name == 'age_ratings':
            age_ratings_list = (movies_set['Age'].unique()).tolist()

            sql_string = insert_statement('age_ratings', age_ratings_list)
            execute_statement(sql_string, conection, 'age_ratings')

        if table_name == 'film_genders':
            genders_list = (movies_set['Genres'].dropna().str.split(',').
                            explode().unique()).tolist()

            sql_string = insert_statement('film_genders', genders_list)
            execute_statement(sql_string, conection, 'film_genders')

        if table_name == 'origin_countries':
            countries_list = (movies_set['Country'].dropna().str.split(',').
                              explode().unique()).tolist()

            dict_iso_codes = country_iso_codes()

            sql_string = insert_statement('origin_countries', countries_list,
                                          dict_iso_codes)
            execute_statement(sql_string, conection, 'origin_countries')

        if table_name == 'streaming_services':
            streaming_list = ['Netfix', 'Disney Plus', 'Amazon Prime',
                              'HBO Max', 'Paramount Plus']
            sql_string = insert_statement('streaming_services',
                                          streaming_list)
            execute_statement(sql_string, conection, 'streaming_services')

    except (pymysql.err.OperationalError, pymysql.err.InternalError) as e:
        print("An error occurred while connecting: ", e)


def insert_statement(table_name, list_obj, dict_obj={}):
    """Generate the command INSERT INTO for litle catalogs

    Args:
        table_name (str): Name of the table of litle catalog
        list_obj (list): List with the values to insert
        dict_obj (dict, optional): Dictionary with ISO codes for the countries. Defaults to {}.

    Returns:
        str: String with the command INSERT INTO
    """

    sql_insert = "INSERT INTO " + table_name + "("
    field_count = 0  # Initialize the fields'count
    sql_values = " VALUES ("
    fields_list = []

    if table_name == 'age_ratings':
        fields_list = AGE_RATINGS_SCHEMA

    if table_name == 'film_genders':
        fields_list = FILM_GENDERS_SCHEMA

    if table_name == 'origin_countries':
        fields_list = ORIGIN_COUNTRIES_SCHEMA

    if table_name == 'streaming_services':
        fields_list = STREAMING_SERVICES_SCHEMA

    # Generate the string for command INSERT in the table.
    for field in fields_list:
        sql_insert += field
        field_count = fields_list.index(field)
        if field_count < len(fields_list) - 1:
            sql_insert += ', '
        else:
            sql_insert += ')'

    index_element = 0
    # Generate the statment INSERT for the table.
    sql_insert += sql_values
    for element in list_obj:
        index_element = list_obj.index(element)
        if table_name == 'origin_countries':
            iso_code = find_iso(dict_obj, element)
            if index_element == 0:
                sql_insert += "'" + element + "'" + ', ' + \
                    "'" + iso_code + \
                    "')"
            else:
                sql_insert += ", ('" + element + "'" + ', ' + \
                    "'" + iso_code + \
                    "')"
        else:
            if index_element == 0:
                sql_insert += "'" + element + "')"
            else:
                sql_insert += ", ('" + element + "')"

    sql_insert += ';'
    return sql_insert


def country_iso_codes():
    """Preparation of dataset for ISO Codes of the countries

    Returns:
        dict: Dictionary with data of the ISO Codes of the countries
    """

    # Conect to the dataframe of iso contries code with pandas.
    country_path = relative_path('paises.csv')
    data_frame_iso_codes = dataframe_connect(country_path)

    # Create a new dataframe with especifics columns.
    cols = [' name', ' iso3']
    countries_set = data_frame_iso_codes[cols]

    # Rename the columns without space.
    countries_set = countries_set.rename(
        columns={' name': 'name', ' iso3': 'iso3'})

    # Convert the columns in  lists.
    list_countries = countries_set['name'].tolist()
    list_iso_code = countries_set['iso3'].tolist()

    # Convert the list in a dictionary.
    dict_iso_codes = dict(zip(list_countries, list_iso_code))
    return dict_iso_codes


def run():

    # Create the menu for manage the database.
    option = 0

    menu = """
    Welcome to the administration program
    of playlist streaming database

    
    1  - Create Catalog Age_ratings
    2  - Create Catalog Film_genders
    3  - Create Catalog Origin_countries
    4  - Create Catalog Streaming_services
    5  - Create Catalog Users
    6  - Create Catalog Movies
    7  - Create Catalog Series
    8  - Create temporal table for movies
    9  - Create temporal table for series
    10 - Create temporal table for genres of movies
    11 - Create temporal table for countries of movies
    12 - Create temporal table for genres of series
    13 - Create temporal table for countries of series
    14 - Exit program

    Chose an option: """
    while option != 14:
        option = int(input(menu))

        if option == 1:
            catalog_insert('age_ratings')
        elif option == 2:
            catalog_insert('film_genders')
        elif option == 3:
            catalog_insert('origin_countries')
        elif option == 4:
            catalog_insert('streaming_services')
        elif option == 5:
            catalog_users()
        elif option == 6:
            full_catalogs('movies')
        elif option == 7:
            full_catalogs('series')
        elif option == 8:
            export_df('movies_tmp')
        elif option == 9:
            export_df('series_tmp')
        elif option == 10:
            export_df('movie_genres_tmp')
        elif option == 11:
            export_df('movie_countries_tmp')
        elif option == 12:
            export_df('serie_genres_tmp')
        elif option == 13:
            export_df('serie_countries_tmp')
        elif option == 14:
            break
        else:
            print("Please enter a correct option")
        time.sleep(5)
        os.system('clear')


if __name__ == '__main__':
    run()
