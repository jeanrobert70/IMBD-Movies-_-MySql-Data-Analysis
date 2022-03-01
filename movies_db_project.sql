/*
Movie Industry Data Exploration

Skills used: Joins, Update, Grop By, Cast, Aggregate Functions, Creating Views, Coverting Data Types

*/

USE sql_project;

SELECT *
FROM highest_grossers
WHERE genres IS NOT NULL
ORDER BY year;

-- Descriptive Statistuc to understand normal ranges of inflation adjust gross earnings
SELECT MIN(total_in_2019_dollars) AS min_gross,
	round(AVG(total_in_2019_dollars)) AS avg_gross,
    MAX(total_in_2019_dollars) AS max_gross
FROM highest_grossers;

-- Select Data the we are going to be starting with

SELECT year, movie, genres, distributor, concat('$',total_in_2019_dollars) AS year_gross, tickets_sold
FROM highest_grossers
WHERE genres IS NOT NULL
ORDER BY year;

-- Select distributor with the most box office hits. 
SELECT distributor, count(distributor) as count
FROM highest_grossers
GROUP BY distributor
ORDER BY count DESC
LIMIT 1;     -- Output is Walt Disney.

-- Top 2 Genres based on tickets sold
SELECT genres, SUM(tickets_sold) as tickets_sold
FROM highest_grossers
WHERE genres IS NOT NULL
GROUP by genres
ORDER BY tickets_sold DESC
LIMIT 2;      -- Output is Adventure and Action respectively.

-- Top 2 Genres based on market_share
SELECT DISTINCT genres, movies, average_gross
FROM top_genres
GROUP BY genres
HAVING AVG(market_share) > .2;

-- Movie count grouped by genre sorted by gross sales
SELECT genres, count(*) AS movie, round(AVG(CAST(total_in_2019_dollars AS DECIMAL)),2) AS avg_gross
FROM highest_grossers
WHERE genres IS NOT NULL
GROUP BY genres
ORDER BY 3 DESC
LIMIT 5;

-- Change mispelled row name 'Aventure' to 'Adventure' to group both rows 'Adventure' and 'Aventure'
UPDATE highest_grossers
SET genres = 'Adventure'
WHERE year = 2021;

CREATE VIEW Adventure AS 
SELECT hg.genres, market_share, average_gross
FROM highest_grossers hg
LEFT JOIN top_genres tg
ON hg.genres = tg.genres
WHERE hg.genres = 'Adventure';


					