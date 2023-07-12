/*Queries that provide answers to the questions from all projects.*/

---------------------------------- fourth part  ----------------------------------

--1 Who was the last animal seen by William Tatcher?
SELECT animals.name FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.visit_date DESC
LIMIT 1;
  name
---------
 Blossom
(1 fila)

--2 How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT animals.id) FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez';
 count
-------
     4
(1 fila)

--3 List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name AS specialty FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON species.id = specializations.species_id;
       name       | specialty
------------------+-----------
 William Tatcher  | Pokemon
 Stephanie Mendez | Digimon
 Stephanie Mendez | Pokemon
 Jack Harkness    | Digimon
 Maisy Smith      |
(5 filas)

--4 List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez' AND
visits.visit_date BETWEEN '2020-04-01' AND '2020-08-30';
  name
---------
 Agumon
 Blossom
(2 filas)

--5 What animal has the most visits to vets?
SELECT animals.name FROM visits
JOIN animals ON animals.id = visits.animal_id
GROUP BY animals.name
ORDER BY COUNT(*) DESC
LIMIT 1;
  name
---------
 Boarmon
(1 fila)

--6 Who was Maisy Smith's first visit?
SELECT animals.name FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.visit_date
LIMIT 1;
  name
---------
 Boarmon
(1 fila)

--7 Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name AS animal_name, vets.name AS vet_name, visits.visit_date FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
ORDER BY visits.visit_date DESC
LIMIT 1;
 animal_name |     vet_name     | visit_date
-------------+------------------+------------
 Devimon     | Stephanie Mendez | 2021-05-04
(1 fila)

--8 How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) FROM (
SELECT visits.animal_id, visits.vet_id, animals.species_id FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
LEFT JOIN specializations ON vets.id = specializations.vet_id AND animals.species_id = specializations.species_id
WHERE specializations.species_id IS NULL
) AS non_matching_visits;
 count
-------
    12
(1 fila)

--9 What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN species ON species.id = animals.species_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY COUNT(*) DESC
LIMIT 1;
  name
---------
 Digimon
(1 fila)


---------------------------------- third part  ----------------------------------

-- What animals belong to Melody Pond?
SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';
    name
------------
 Charmander
 Squirtle
 Blossom
(3 filas)

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';
    name
------------
 Pikachu
 Charmander
 Squirtle
 Blossom
(4 filas)

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.full_name, animals.name
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;
    full_name    |    name
-----------------+------------
 Sam Smith       | Agumon
 Jennifer Orwell | Gabumon
 Jennifer Orwell | Pikachu
 Bob             | Devimon
 Bob             | Plantmon
 Melody Pond     | Charmander
 Melody Pond     | Squirtle
 Melody Pond     | Blossom
 Dean Winchester | Angemon
 Dean Winchester | Boarmon
 Jodie Whittaker |
(11 filas)

-- How many animals are there per species?
SELECT species.name, COUNT(animals.id)
FROM animals
JOIN species ON animals.species_id = species.id
GROUP BY species.name;
  name   | count
---------+-------
 Pokemon |     4
 Digimon |     6
(2 filas)

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
JOIN species ON animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';
  name
---------
 Gabumon
(1 fila)

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;
 name
------
(0 filas)

-- Who owns the most animals?
SELECT owners.full_name, COUNT(animals.id)
FROM animals
JOIN owners ON animals.owner_id = owners.id
GROUP BY owners.full_name
ORDER BY COUNT(animals.id) DESC
LIMIT 1;
  full_name  | count
-------------+-------
 Melody Pond |     3
(1 fila)

---------------------------------- Second part  ----------------------------------

vet_clinic=# BEGIN;
BEGIN
vet_clinic=*# UPDATE animals SET species = 'unspecified';
UPDATE 11
vet_clinic=*# SELECT * FROM animals;
 id |    name    | date_of_birth | escape_attempts | neutered | weight_kg |   species
----+------------+---------------+-----------------+----------+-----------+-------------
  1 | Agumon     | 2020-02-03    |               0 | t        |     10.23 | unspecified
  2 | Gabumon    | 2018-11-15    |               2 | t        |      8.00 | unspecified
  3 | Pikachu    | 2021-01-07    |               1 | f        |     15.04 | unspecified
  4 | Devimon    | 2017-05-12    |               5 | t        |     11.00 | unspecified
  5 | Charmander | 2020-02-08    |               0 | f        |       -11 | unspecified
  6 | Plantmon   | 2021-11-15    |               2 | t        |      -5.7 | unspecified
  7 | Squirtle   | 1993-04-02    |               3 | f        |    -12.13 | unspecified
  8 | Angemon    | 2005-06-12    |               1 | t        |       -45 | unspecified
  9 | Boarmon    | 2005-06-07    |               7 | t        |      20.4 | unspecified
 10 | Blossom    | 1998-10-13    |               3 | t        |        17 | unspecified
 11 | Ditto      | 2022-05-14    |               4 | t        |        22 | unspecified
(11 filas)


vet_clinic=*# ROLLBACK;
ROLLBACK
vet_clinic=# SELECT * FROM animals;
 id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species
----+------------+---------------+-----------------+----------+-----------+---------
  1 | Agumon     | 2020-02-03    |               0 | t        |     10.23 |
  2 | Gabumon    | 2018-11-15    |               2 | t        |      8.00 |
  3 | Pikachu    | 2021-01-07    |               1 | f        |     15.04 |
  4 | Devimon    | 2017-05-12    |               5 | t        |     11.00 |
  5 | Charmander | 2020-02-08    |               0 | f        |       -11 |
  6 | Plantmon   | 2021-11-15    |               2 | t        |      -5.7 |
  7 | Squirtle   | 1993-04-02    |               3 | f        |    -12.13 |
  8 | Angemon    | 2005-06-12    |               1 | t        |       -45 |
  9 | Boarmon    | 2005-06-07    |               7 | t        |      20.4 |
 10 | Blossom    | 1998-10-13    |               3 | t        |        17 |
 11 | Ditto      | 2022-05-14    |               4 | t        |        22 |
(11 filas)


vet_clinic=# BEGIN;
BEGIN
vet_clinic=*# UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE 6
vet_clinic=*# UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
UPDATE 5
vet_clinic=*# SELECT * FROM animals;
 id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species
----+------------+---------------+-----------------+----------+-----------+---------
  1 | Agumon     | 2020-02-03    |               0 | t        |     10.23 | digimon
  2 | Gabumon    | 2018-11-15    |               2 | t        |      8.00 | digimon
  4 | Devimon    | 2017-05-12    |               5 | t        |     11.00 | digimon
  6 | Plantmon   | 2021-11-15    |               2 | t        |      -5.7 | digimon
  8 | Angemon    | 2005-06-12    |               1 | t        |       -45 | digimon
  9 | Boarmon    | 2005-06-07    |               7 | t        |      20.4 | digimon
  3 | Pikachu    | 2021-01-07    |               1 | f        |     15.04 | pokemon
  5 | Charmander | 2020-02-08    |               0 | f        |       -11 | pokemon
  7 | Squirtle   | 1993-04-02    |               3 | f        |    -12.13 | pokemon
 10 | Blossom    | 1998-10-13    |               3 | t        |        17 | pokemon
 11 | Ditto      | 2022-05-14    |               4 | t        |        22 | pokemon
(11 filas)


vet_clinic=*# COMMIT;
COMMIT
vet_clinic=# SELECT * FROM animals;
 id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species
----+------------+---------------+-----------------+----------+-----------+---------
  1 | Agumon     | 2020-02-03    |               0 | t        |     10.23 | digimon
  2 | Gabumon    | 2018-11-15    |               2 | t        |      8.00 | digimon
  4 | Devimon    | 2017-05-12    |               5 | t        |     11.00 | digimon
  6 | Plantmon   | 2021-11-15    |               2 | t        |      -5.7 | digimon
  8 | Angemon    | 2005-06-12    |               1 | t        |       -45 | digimon
  9 | Boarmon    | 2005-06-07    |               7 | t        |      20.4 | digimon
  3 | Pikachu    | 2021-01-07    |               1 | f        |     15.04 | pokemon
  5 | Charmander | 2020-02-08    |               0 | f        |       -11 | pokemon
  7 | Squirtle   | 1993-04-02    |               3 | f        |    -12.13 | pokemon
 10 | Blossom    | 1998-10-13    |               3 | t        |        17 | pokemon
 11 | Ditto      | 2022-05-14    |               4 | t        |        22 | pokemon
(11 filas)


vet_clinic=# BEGIN;
BEGIN
vet_clinic=*# DELETE FROM animals;
DELETE 11
vet_clinic=*# SELECT * FROM animals;
 id | name | date_of_birth | escape_attempts | neutered | weight_kg | species
----+------+---------------+-----------------+----------+-----------+---------
(0 filas)


vet_clinic=*# ROLLBACK;
ROLLBACK
vet_clinic=# SELECT * FROM animals;
 id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species
----+------------+---------------+-----------------+----------+-----------+---------
  1 | Agumon     | 2020-02-03    |               0 | t        |     10.23 | digimon
  2 | Gabumon    | 2018-11-15    |               2 | t        |      8.00 | digimon
  4 | Devimon    | 2017-05-12    |               5 | t        |     11.00 | digimon
  6 | Plantmon   | 2021-11-15    |               2 | t        |      -5.7 | digimon
  8 | Angemon    | 2005-06-12    |               1 | t        |       -45 | digimon
  9 | Boarmon    | 2005-06-07    |               7 | t        |      20.4 | digimon
  3 | Pikachu    | 2021-01-07    |               1 | f        |     15.04 | pokemon
  5 | Charmander | 2020-02-08    |               0 | f        |       -11 | pokemon
  7 | Squirtle   | 1993-04-02    |               3 | f        |    -12.13 | pokemon
 10 | Blossom    | 1998-10-13    |               3 | t        |        17 | pokemon
 11 | Ditto      | 2022-05-14    |               4 | t        |        22 | pokemon
(11 filas)


vet_clinic=# BEGIN;
BEGIN
vet_clinic=*# DELETE FROM animals WHERE date_of_birth > '2022-01-01';
DELETE 1
vet_clinic=*# SAVEPOINT sp1;
SAVEPOINT
vet_clinic=*# UPDATE animals SET weight_kg = weight_kg * -1;
UPDATE 10
vet_clinic=*# ROLLBACK TO SAVEPOINT sp1;
ROLLBACK
vet_clinic=*# UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
UPDATE 4
vet_clinic=*# COMMIT;
COMMIT
vet_clinic=# SELECT * FROM animals;
 id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species
----+------------+---------------+-----------------+----------+-----------+---------
  1 | Agumon     | 2020-02-03    |               0 | t        |     10.23 | digimon
  2 | Gabumon    | 2018-11-15    |               2 | t        |      8.00 | digimon
  4 | Devimon    | 2017-05-12    |               5 | t        |     11.00 | digimon
  9 | Boarmon    | 2005-06-07    |               7 | t        |      20.4 | digimon
  3 | Pikachu    | 2021-01-07    |               1 | f        |     15.04 | pokemon
 10 | Blossom    | 1998-10-13    |               3 | t        |        17 | pokemon
  6 | Plantmon   | 2021-11-15    |               2 | t        |       5.7 | digimon
  8 | Angemon    | 2005-06-12    |               1 | t        |        45 | digimon
  5 | Charmander | 2020-02-08    |               0 | f        |        11 | pokemon
  7 | Squirtle   | 1993-04-02    |               3 | f        |     12.13 | pokemon
(10 filas)


vet_clinic=# SELECT COUNT(*) FROM animals;
 count
-------
    10
(1 fila)


vet_clinic=# SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
 count
-------
     2
(1 fila)


vet_clinic=# SELECT AVG(weight_kg) FROM animals;
         avg
---------------------
 15.5500000000000000
(1 fila)


vet_clinic=# SELECT neutered, SUM(escape_attempts) as total_attempts FROM animals GROUP BY neutered ORDER BY total_attempts DESC LIMIT 1;
 neutered | total_attempts
----------+----------------
 t        |             20
(1 fila)


vet_clinic=# SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
 species | min | max
---------+-----+-----
 pokemon |  11 |  17
 digimon | 5.7 |  45
(2 filas)


vet_clinic=# SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;
 species |        avg
---------+--------------------
 pokemon | 3.0000000000000000
(1 fila)


--------------------------------- First part  ----------------------------------

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

