# 🎬 Analyse des Données Netflix avec SQL

## 📌 Présentation du projet
Ce projet consiste à **nettoyer, transformer et analyser** le dataset Netflix en utilisant **Microsoft SQL Server**.  
L’objectif est de construire une **table analytique fiable** à partir de données brutes et de répondre à des questions métiers concrètes à l’aide de requêtes SQL.

---

## 🛠 Outils & Technologies
- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- SQL (T-SQL)

---

## 📂 Description du Dataset
Le dataset contient des informations sur les films et séries disponibles sur Netflix, notamment :
- Identifiant du contenu
- Type (Film / Série TV)
- Titre
- Réalisateur
- Casting
- Pays de production
- Date d’ajout sur Netflix
- Année de sortie
- Classification (Rating)
- Durée
- Genre
- Description

---

## 🧱 Démarche et Workflow du Projet

### 1️⃣ Création de la base de données
- Création d’une base dédiée : `netflix_db`

### 2️⃣ Table de Staging (données brutes)
- Importation des données sources dans une table de staging
- Conservation des données sans transformation

### 3️⃣ Nettoyage des données
- Gestion des valeurs manquantes
- Conversion et normalisation des dates
- Transformation de la durée (valeur + unité)
- Standardisation des colonnes textuelles
- Suppression des enregistrements incohérents

### 4️⃣ Création de la table finale
- Schéma optimisé pour l’analyse
- Données propres et cohérentes
- Prête pour les requêtes analytiques

### 5️⃣ Audit de qualité des données
- Comptage des valeurs nulles
- Vérification de la cohérence des données
- Validation du nombre total de lignes

### 6️⃣ Analyse des données
Réponses à des questions analytiques clés :
- Répartition Films vs Séries TV
- Classification la plus fréquente par type de contenu
- Contenus par année de sortie
- Pays produisant le plus de contenus
- Films les plus longs
- Contenus ajoutés récemment
- Analyse par réalisateur et acteurs
- Genres les plus représentés
- Classification du contenu selon les mots-clés sensibles

---

## 📊 Exemples d’Insights
- Les films représentent la majorité du catalogue Netflix
- Les États-Unis et l’Inde sont les principaux pays producteurs
- La majorité des séries comptent moins de 5 saisons
- Les genres *Drama* et *International Movies* sont les plus fréquents

---

## 📁 Structure du Repository
```sql
netflix-sql-data-analysis/
│
├── data/
│   └── dataset.csv
│
├── sql/
│   ├── 01_database_staging_final_table.sql
│   ├── 03_data_cleaning.sql
│   └── 05_analysis_queries.sql
│
└── README.md

```


---

## 🎯 Objectifs du projet
- Mettre en pratique un workflow professionnel d’analyse de données
- Appliquer les bonnes pratiques SQL (staging, nettoyage, audit)
- Produire des analyses exploitables pour la prise de décision

---

## 🚀 Auteur
**Kodjo Georges AKAKPO**  
Data Analyst | SQL | Power BI | Python  

📫 N’hésitez pas à me contacter pour toute question ou collaboration.
