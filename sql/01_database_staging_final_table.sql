--Objectif : créer la base, la table de staging et la table finale
/* =====================================================
   01 - DATABASE + STAGING + FINAL TABLE
   ===================================================== */

-- Création de la base de données
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'netflix_db')
BEGIN
    CREATE DATABASE netflix_db;
END;
GO

USE netflix_db;
GO

/* =====================================================
   TABLE DE STAGING (DONNÉES BRUTES)
   ===================================================== */

DROP TABLE IF EXISTS dbo.stagging_netflix;
GO

CREATE TABLE dbo.stagging_netflix (
    show_id       NVARCHAR(10)  NOT NULL,
    type          NVARCHAR(50)  NOT NULL,
    title         NVARCHAR(255) NOT NULL,
    director      NVARCHAR(255) NULL,
    cast          NVARCHAR(1500) NULL,
    country       NVARCHAR(200) NULL,
    date_added    NVARCHAR(50)  NULL,
    release_year  INT           NULL,
    rating        NVARCHAR(15)  NULL,
    duration      NVARCHAR(20)  NULL,
    listed_in     NVARCHAR(300) NULL,
    description   NVARCHAR(MAX) NULL
);

-- Import des données brutes
INSERT INTO dbo.stagging_netflix
SELECT *
FROM dbo.netflix_titles;

/* =====================================================
   TABLE FINALE NETFLIX (DONNÉES NETTOYÉES)
   ===================================================== */

DROP TABLE IF EXISTS dbo.netflix;
GO

CREATE TABLE dbo.netflix (
    show_id        NVARCHAR(10)   NOT NULL PRIMARY KEY,
    content_type   NVARCHAR(20)   NOT NULL,
    title          NVARCHAR(255)  NOT NULL,
    director       NVARCHAR(255)  NULL,
    cast           NVARCHAR(1500) NULL,
    country        NVARCHAR(200)  NULL,
    date_added     DATE           NULL,
    release_year   INT            NOT NULL,
    rating         NVARCHAR(15)   NULL,
    duration_value INT            NULL,
    duration_unit  NVARCHAR(10)   NULL,
    listed_in      NVARCHAR(300)  NULL,
    description    NVARCHAR(MAX)  NULL
);

/* =====================================================
   INSERT + TRANSFORMATIONS
   ===================================================== */

INSERT INTO dbo.netflix (
    show_id,
    content_type,
    title,
    director,
    cast,
    country,
    date_added,
    release_year,
    rating,
    duration_value,
    duration_unit,
    listed_in,
    description
)
SELECT
    show_id,
    type,
    title,
    director,
    cast,
    country,
    TRY_CONVERT(DATE, date_added, 106),
    release_year,
    rating,
    TRY_CAST(LEFT(duration, CHARINDEX(' ', duration) - 1) AS INT),
    CASE
        WHEN duration LIKE '%min%' THEN 'min'
        WHEN duration LIKE '%Season%' THEN 'season'
        ELSE NULL
    END,
    listed_in,
    description
FROM dbo.stagging_netflix;
GO
