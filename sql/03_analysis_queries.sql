--analyses métier

/* =====================================================
   05 - ANALYTICAL QUERIES
   ===================================================== */

USE netflix_db;
GO

-- Q1 : Films vs Séries TV
SELECT content_type, COUNT(*) AS total
FROM netflix
GROUP BY content_type;

-- Q2 : Rating le plus fréquent par type
SELECT content_type, rating
FROM (
    SELECT
        content_type,
        rating,
        COUNT(*) AS total,
        RANK() OVER(PARTITION BY content_type ORDER BY COUNT(*) DESC) AS rnk
    FROM netflix
    GROUP BY content_type, rating
) t
WHERE rnk = 1;

-- Q3 : Films sortis en 2020
SELECT *
FROM netflix
WHERE release_year = 2020;

-- Q4 : Top 5 pays producteurs
SELECT
    TRIM(value) AS country,
    COUNT(*) AS total
FROM netflix
CROSS APPLY STRING_SPLIT(country, ',')
GROUP BY TRIM(value)
ORDER BY total DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

-- Q5 : Film le plus long
SELECT MAX(duration_value) AS longest_movie
FROM netflix
WHERE duration_unit = 'min';

-- Q6 : Contenus ajoutés ces 5 dernières années
SELECT title, date_added
FROM netflix
WHERE DATEDIFF(YEAR, date_added, GETDATE()) <= 5;

-- Q7 : Contenus de Rajiv Chilaka
SELECT *
FROM netflix
WHERE director LIKE '%Rajiv Chilaka%';

-- Q8 : Séries avec plus de 5 saisons
SELECT *
FROM netflix
WHERE duration_unit = 'season'
  AND duration_value > 5;

-- Q9 : Nombre de contenus par genre
SELECT genre, COUNT(DISTINCT show_id) AS total
FROM (
    SELECT show_id, TRIM(value) AS genre
    FROM netflix
    CROSS APPLY STRING_SPLIT(listed_in, ',')
) g
GROUP BY genre
ORDER BY total DESC;

-- Q10 : Documentaires
SELECT *
FROM netflix
WHERE listed_in LIKE '%Documentaries%';

-- Q11 : Contenus sans réalisateur
SELECT *
FROM netflix
WHERE director = 'Unknown';

-- Q12 : Films avec Salman Khan (10 dernières années)
SELECT *
FROM netflix
WHERE cast LIKE '%Salman Khan%'
  AND DATEDIFF(YEAR, date_added, GETDATE()) <= 10;

-- Q13 : Top 10 acteurs en Inde
SELECT TOP 10
    TRIM(value) AS actor,
    COUNT(*) AS total_movies
FROM netflix
CROSS APPLY STRING_SPLIT(cast, ',')
WHERE country LIKE '%India%'
GROUP BY TRIM(value)
ORDER BY total_movies DESC;

-- Q14 : Contenus sensibles
SELECT
    CASE
        WHEN description LIKE '%kill%' OR description LIKE '%violence%'
        THEN 'Bad'
        ELSE 'Good'
    END AS category,
    COUNT(*) AS total
FROM netflix
GROUP BY
    CASE
        WHEN description LIKE '%kill%' OR description LIKE '%violence%'
        THEN 'Bad'
        ELSE 'Good'
    END;
