video_games_tb = "CREATE TABLE video_games(
id int, 
name varchar(50),
game_genre varchar(50),
game_developer varchar(50),
release_date date,
CONSTRAINT video_games PRIMARY KEY (id)
)";

game_developers_tb = "CREATE TABLE game_developers(
id int,
name varchar(50),
address varchar(50),
state varchar(50),
city varchar(50),
country varchar(50),
CONSTRAINT game_developers PRIMARY KEY (id)
)";

platforms_tb = "CREATE TABLE platforms(
id int,
name varchar(50),
company_id int,
company varchar(50),
release_date date,
original_price double,
CONSTRAINT platforms PRIMARY KEY (id)
)";

platforms_games_tb = "CREATE TABLE platforms_games(
game_id int,
platform_id int,
platform_name varchar(50),
CONSTRAINT platforms_games PRIMARY KEY (game_id, platform_id),
CONSTRAINT fk2 FOREIGN KEY (platform_id)
    REFERENCES platforms(id),
CONSTRAINT fk1 FOREIGN KEY (game_id)
    REFERENCES video_games(id)
)"

characters_tb = "CREATE TABLE characters(
id int,
name varchar(50),
birthday date,
gender varchar(20),
info varchar(200),
CONSTRAINT characters PRIMARY KEY (id)
)";

games_characters_tb = "CREATE TABLE games_characters(
character_id int,
character_name varchar(50),
game_id int,
CONSTRAINT games_characters PRIMARY KEY (character_id, game_id),
CONSTRAINT fk4 FOREIGN KEY (character_id)
    REFERENCES characters(id),
CONSTRAINT fk3 FOREIGN KEY (game_id)
    REFERENCES video_games(id)
)";

delete_rows = "DELETE FROM games_characters
WHERE character_id is NULL;"

alter_table_platforms = "UPDATE platforms 
SET release_date = DATE(); "

alter_table_characters = "UPDATE characters 
SET birthday = DATE();"

search_nathan = "SELECT *
FROM characters 
INNER JOIN games_characters ON id = character_id
INNER JOIN video_games vg ON game_id = id
WHERE name = 'Nathan Drake';"

how_many_people = "SELECT COUNT(*) AS total_characters
FROM characters c
INNER JOIN games_characters gc ON c.id = gc.character_id
INNER JOIN video_games vg ON gc.game_id = vg.id
WHERE info LIKE '%Nathan Drake%';"

find_location = "SELECT address, state, city, country
FROM video_games 
JOIN game_developers  ON game_developer = name
JOIN games_characters  ON id = game_id
JOIN characters  ON character_id = id
WHERE name = 'Nathan Drake';"

count_games_ca = "SELECT COUNT(*) AS california_games
FROM video_games
JOIN game_developers ON video_games.game_developer = game_developers.name
WHERE game_developers.state = 'California';"
address =  "SELECT game_developers.address, game_developers.city, game_developers.state, game_developers.country
FROM video_games
JOIN game_developers ON video_games.game_developer = game_developers.name
WHERE game_developers.state = (
    SELECT game_developers.state
    FROM video_games
    JOIN game_developers ON video_games.game_developer = game_developers.name
    WHERE game_developers.state IS NOT NULL
    GROUP BY game_developers.state
    ORDER BY COUNT(*) DESC
    LIMIT 1
)
ORDER BY video_games.release_date DESC
LIMIT 1;"