/*Queries that provide answers to the questions from all projects.*/

/* Query 1 */
SELECT * FROM animals WHERE name LIKE '%mon';

/* Query 2 */
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

/* Query 3 */
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;

/* Query 4 */
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

/* Query 5 */
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

/* Query 6 */
SELECT * FROM animals WHERE neutered = TRUE;

/* Query 7 */
SELECT * FROM animals WHERE name NOT IN ('Gabumon');

/* Query 8 */
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

