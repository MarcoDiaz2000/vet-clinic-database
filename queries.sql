/*Queries that provide answers to the questions from all projects.*/

/* Attached are images of the queries */

/* Query 1 */
vet_clinic=# SELECT * FROM animals WHERE name LIKE '%mon';
 id |  name   | date_of_birth | escape_attempts | neutered | weight_kg
----+---------+---------------+-----------------+----------+-----------
  1 | Agumon  | 2020-02-03    |               0 | t        |     10.23
  2 | Gabumon | 2018-11-15    |               2 | t        |      8.00
  4 | Devimon | 2017-05-12    |               5 | t        |     11.00
(3 filas)

/* Query 2 */
vet_clinic=# SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
  name
---------
 Gabumon
 Devimon
(2 filas)

/* Query 3 */
vet_clinic=# SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
  name
---------
 Agumon
 Gabumon
(2 filas)

/* Query 4 */
vet_clinic=# SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
 date_of_birth
---------------
 2020-02-03
 2021-01-07
(2 filas)

/* Query 5 */
vet_clinic=# SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
  name   | escape_attempts
---------+-----------------
 Pikachu |               1
 Devimon |               5
(2 filas)

/* Query 6 */
vet_clinic=# SELECT * FROM animals WHERE neutered = true;
 id |  name   | date_of_birth | escape_attempts | neutered | weight_kg
----+---------+---------------+-----------------+----------+-----------
  1 | Agumon  | 2020-02-03    |               0 | t        |     10.23
  2 | Gabumon | 2018-11-15    |               2 | t        |      8.00
  4 | Devimon | 2017-05-12    |               5 | t        |     11.00
(3 filas)


/* Query 7 */
vet_clinic=# SELECT * FROM animals WHERE name NOT IN ('Gabumon');
 id |  name   | date_of_birth | escape_attempts | neutered | weight_kg
----+---------+---------------+-----------------+----------+-----------
  1 | Agumon  | 2020-02-03    |               0 | t        |     10.23
  3 | Pikachu | 2021-01-07    |               1 | f        |     15.04
  4 | Devimon | 2017-05-12    |               5 | t        |     11.00
(3 filas)

/* Query 8 */
vet_clinic=# SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;
 id |  name   | date_of_birth | escape_attempts | neutered | weight_kg
----+---------+---------------+-----------------+----------+-----------
  3 | Pikachu | 2021-01-07    |               1 | f        |     15.04
  4 | Devimon | 2017-05-12    |               5 | t        |     11.00
(2 filas)
