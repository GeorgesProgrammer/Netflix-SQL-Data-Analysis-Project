/* =====================================================
   02 - DATA CLEANING & DATA QUALITY
   ===================================================== */

USE netflix_db;
GO

-- Audit global
SELECT COUNT(*) AS total_rows FROM netflix;

-- Valeurs manquantes par colonne
SELECT
    COUNT(*) - COUNT(director)      AS director_nulls,
    COUNT(*) - COUNT(cast)          AS cast_nulls,
    COUNT(*) - COUNT(country)       AS country_nulls,
    COUNT(*) - COUNT(date_added)    AS date_added_nulls,
    COUNT(*) - COUNT(rating)        AS rating_nulls,
    COUNT(*) - COUNT(duration_unit) AS duration_unit_nulls
FROM netflix;

-- Remplacements standardisés
UPDATE netflix SET director = 'Unknown' WHERE director IS NULL;
UPDATE netflix SET cast = 'Unknown' WHERE cast IS NULL;
UPDATE netflix SET country = 'Unknown' WHERE country IS NULL;
UPDATE netflix SET rating = 'Not Rated' WHERE rating IS NULL;

-- Suppression des données incohérentes
DELETE FROM netflix WHERE release_year IS NULL;
DELETE FROM netflix WHERE duration_value IS NULL;

-- Vérification finale
SELECT * FROM netflix;
