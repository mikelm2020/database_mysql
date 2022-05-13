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


def find_key(id_field, table_name, field, data_find):
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


def insert_movies_to_list(obj_list):
    fk_value = 0
    list_movies = []

    for list_element in obj_list:
        for element in list_element:
            if list_element.index(element) == len(list_element) - 1:
                fk_value = find_key('id', 'age_ratings', 'age_rating', element)
                list_movies.append(str(fk_value))
            else:
                list_movies.append(element if type(element) == str else str(element)) 

    return list_movies


def insert_series(obj_list):
    pass


def obtain_data(obj_list, table_name):
    list_table = []
    sql_command = ''
    if table_name == 'movies':
        list_table = insert_movies_to_list(obj_list)
    if table_name == 'series':
        insert_series(obj_list)
    return list_table


def generate_movies():
    # Create the movies_set with movies of the dataset movies.csv
    movies_set = create_movies_set()

    # Filter the movies_set by Netflix or Amazon Prime or Disney+
    cols = ['Title', 'Runtime', 'Year', 'Age']
    query = 'Netflix == 1 | Prime == 1 | Disney == 1'
    movie_name_list = movies_set.query(query)[cols].values.tolist()
    # Create the string for insert data for the table movies
    movies_list = obtain_data(movie_name_list, 'movies')
    return movies_list



# def execute_query(sql_command, conect_obj):

#     try:
#         with conect_obj.cursor() as cursor:
#                 cursor.execute(sql_command)

#                 columns = [column[0] for column in cursor.description]
#                 results = []
#                 for row in cursor.fetchall():
#                     results.append(dict(zip(columns, row)))

#         conect_obj.commit()
#     finally:
#         conect_obj.close()
#     return results

def create_movies_set():
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
    movies_set = df_movies_filter[cols]
    movies_set['Country'].dropna().str.split(',').explode().unique()

    return movies_set


def catalog_movies():
    # Generate the conection to mySQL database.
    try:
        conection = database_connect(os.environ.get('DB_HOST'),
                                     os.environ.get('DB_USER'),
                                     os.environ.get('DB_PASS'),
                                     os.environ.get('DB_NAME'))

        # List of movies with data for the schema
        movies_list = []
        sql_command = ''

        movies_list = generate_movies()
        sql_command = insert_fields_statement('movies', movies_list)
        execute_statment(sql_command, conection, 'movies')


    except (pymysql.err.OperationalError, pymysql.err.InternalError) as e:
        print("An error occurred while connecting: ", e)


def dataframe_from_table(table_name, conect_obj):
    return pd.read_sql_table(table_name, con=conect_obj)


def user_profile():
    fake = Faker()
    Faker.seed(0)
    user_list = []

    for _ in range(100):
        user_list.extend(
            [fake.user_name()[0:9], fake.password(length=10), fake.name()])

    return user_list


def insert_fields_statement(table_name, list_obj):
    sql_string = "INSERT INTO " + table_name
    sql_values = " VALUES"
    fields_list = []

    sql_string = sql_string + '('

    if table_name == 'users':
        fields_list = USERS_SCHEMA

    if table_name == 'movies':
        fields_list = MOVIES_SCHEMA

    for field in fields_list:
        sql_string = sql_string + field
        index_field = fields_list.index(field)

        if index_field == len(fields_list) - 1:
            character = ')'
        else:
            character = ','

        sql_string = sql_string + character

    # Add values
    index_field = 0
    sql_string = sql_string + sql_values
    for element in list_obj:
        index_element = list_obj.index(element)
        if index_field == 0:
            if index_element == 0:
                sql_string = sql_string + '('
            else:
                sql_string = sql_string + ',('
            sql_string = sql_string + "'" + element + "'"
            index_field += 1
        elif index_field == len(fields_list) - 1:
            sql_string = sql_string + ", '" + element + "'"
            sql_string = sql_string + ')'
            index_field = 0
        else:
            sql_string = sql_string + ', '
            sql_string = sql_string + "'" + element + "'"
            index_field += 1

    return sql_string


def catalog_users():
    try:
        conection = database_connect(os.environ.get('DB_HOST'),
                                     os.environ.get('DB_USER'),
                                     os.environ.get('DB_PASS'),
                                     os.environ.get('DB_NAME'))
        profile_list = []
        sql_command = ''

        profile_list = user_profile()
        sql_command = insert_fields_statement('users', profile_list)
        execute_statment(sql_command, conection, 'users')

    except (pymysql.err.OperationalError, pymysql.err.InternalError) as e:
        print("An error occurred while connecting: ", e)


def relative_path(file_name):
    current_path = os.path.dirname(os.path.abspath(__file__))
    return os.path.join(current_path, '..', 'data', file_name)


def dataframe_connect(data_frame):
    df = pd.read_csv(data_frame)

    return df


def database_connect(host_name, user_name, passwd, db_name):
    conection = pymysql.connect(host=host_name,
                                user=user_name,
                                password=passwd,
                                db=db_name)
    return conection


def find_iso(dict_obj, country_name):
    if country_name in dict_obj:
        # Return tne value of the key country_name.
        return dict_obj[country_name]
    else:
        return '000'


def message_success():
    print('the process of insertion was successful')


def execute_statment(sql_command, conect_obj, table_name):
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
                message_success()
            else:
                print('The table {}'.format(table_name) +
                      ' you already have records')

        conect_obj.commit()
    finally:
        conect_obj.close()


def catalog_insert(table_name):
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

            sql_string = insert_statment('age_ratings', age_ratings_list)
            execute_statment(sql_string, conection, 'age_ratings')

        if table_name == 'film_genders':
            genders_list = (movies_set['Genres'].dropna().str.split(',').
                            explode().unique()).tolist()

            sql_string = insert_statment('film_genders', genders_list)
            execute_statment(sql_string, conection, 'film_genders')

        if table_name == 'origin_countries':
            countries_list = (movies_set['Country'].dropna().str.split(',').
                              explode().unique()).tolist()

            dict_iso_codes = country_iso_codes()

            sql_string = insert_statment('origin_countries', countries_list,
                                         dict_iso_codes)
            execute_statment(sql_string, conection, 'origin_countries')

        if table_name == 'streaming_services':
            streaming_list = ['Netfix', 'Disney Plus', 'Amazon Prime',
                              'HBO Max', 'Paramount Plus']
            sql_string = insert_statment('streaming_services',
                                         streaming_list)
            execute_statment(sql_string, conection, 'streaming_services')

    except (pymysql.err.OperationalError, pymysql.err.InternalError) as e:
        print("An error occurred while connecting: ", e)


def insert_statment(table_name, list_obj, dict_obj={}):

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
        sql_insert = sql_insert + field
        field_count = fields_list.index(field)
        if field_count < len(fields_list) - 1:
            sql_insert = sql_insert + ', '
        else:
            sql_insert = sql_insert + ')'

    index_element = 0
    # Generate the statment INSERT for the table.
    sql_insert = sql_insert + sql_values
    for element in list_obj:
        index_element = list_obj.index(element)
        if table_name == 'origin_countries':
            iso_code = find_iso(dict_obj, element)
            if index_element == 0:
                sql_insert = sql_insert + "'" + element + "'" + ', ' + \
                    "'" + iso_code + \
                    "')"
            else:
                sql_insert = sql_insert + ", ('" + element + "'" + ', ' + \
                    "'" + iso_code + \
                    "')"
        else:
            if index_element == 0:
                sql_insert = sql_insert + "'" + element + "')"
            else:
                sql_insert = sql_insert + ", ('" + element + "')"

    sql_insert = sql_insert + ';'
    return sql_insert


def country_iso_codes():

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

    
    1 - Create Catalog Age_ratings
    2 - Create Catalog Film_genders
    3 - Create Catalog Origin_countries
    4 - Create Catalog Streaming_services
    5 - Create Catalog Users
    6 - Create Catalog Movies
    7 - Exit program

    Chose an option: """
    while option != 7:
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
            catalog_movies()
        elif option == 7:
            break
        else:
            print("Please enter a correct option")
        time.sleep(60)
        os.system('clear')


if __name__ == '__main__':
    run()
