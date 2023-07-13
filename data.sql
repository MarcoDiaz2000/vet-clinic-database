/* Populate database with sample data. */

---------------------------------- fourth part  ----------------------------------
INSERT INTO vets (name, age, date_of_graduation) VALUES
('William Tatcher', 45, '2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations (vet_id, species_id) VALUES
(1, 1), 
(3, 2), 
(3, 1), 
(4, 2);

INSERT INTO visits (animal_id, vet_id, visit_date) VALUES
(1, 1, '2020-05-24'), 
(1, 3, '2020-07-22'), 
(2, 4, '2021-02-02'), 
(3, 2, '2020-01-05'), 
(3, 2, '2020-03-08'), 
(3, 2, '2020-05-14'), 
(4, 3, '2021-05-04'), 
(5, 4, '2021-02-24'), 
(6, 2, '2019-12-21'), 
(6, 1, '2020-08-10'), 
(6, 2, '2021-04-07'), 
(7, 3, '2019-09-29'), 
(8, 4, '2020-10-03'), 
(8, 4, '2020-11-04'), 
(9, 2, '2019-01-24'), 
(9, 2, '2019-05-15'), 
(9, 2, '2020-02-27'), 
(9, 2, '2020-08-03'), 
(10, 3, '2020-05-24'), 
(10, 1, '2021-01-11');

---------------------------------- third part  ----------------------------------

vet_clinic=# SELECT * FROM animals;
 id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species_id | owner_id
----+------------+---------------+-----------------+----------+-----------+------------+----------
  1 | Agumon     | 2020-02-03    |               0 | t        |     10.23 |          2 |        1
  2 | Gabumon    | 2018-11-15    |               2 | t        |      8.00 |          2 |        2
  3 | Pikachu    | 2021-01-07    |               1 | f        |     15.04 |          1 |        2
  4 | Devimon    | 2017-05-12    |               5 | t        |     11.00 |          2 |        3
  6 | Plantmon   | 2021-11-15    |               2 | t        |      5.70 |          2 |        3
  5 | Charmander | 2020-02-08    |               0 | f        |     11.00 |          1 |        4
  7 | Squirtle   | 1993-04-02    |               3 | f        |     12.13 |          1 |        4
 10 | Blossom    | 1998-10-13    |               3 | t        |     17.00 |          1 |        4
  8 | Angemon    | 2005-06-12    |               1 | t        |     45.00 |          2 |        5
  9 | Boarmon    | 2005-06-07    |               7 | t        |     20.40 |          2 |        5
(10 filas)

-- Insert the following data into the owners table:
 vet_clinic=*# INSERT INTO owners (full_name, age) VALUES
vet_clinic-*# ('Sam Smith', 34),
vet_clinic-*# ('Jennifer Orwell', 19),
vet_clinic-*# ('Bob', 45),
vet_clinic-*# ('Melody Pond', 77),
vet_clinic-*# ('Dean Winchester', 14),
vet_clinic-*# ('Jodie Whittaker', 38);
INSERT 0 6

-- Insert the following data into the species table:
vet_clinic=*# INSERT INTO species (name) VALUES
vet_clinic-*# ('Pokemon'),
vet_clinic-*# ('Digimon');
INSERT 0 2

-- Modify your inserted animals so it includes the species_id value:
vet_clinic=# UPDATE animals
vet_clinic-# SET species_id = 2
vet_clinic-# WHERE name LIKE '%mon';
UPDATE 6
vet_clinic=# UPDATE animals
vet_clinic-# SET species_id = 1
vet_clinic-# WHERE species_id IS NULL;
UPDATE 5

-- Modify your inserted animals to include owner information (owner_id):
vet_clinic=# UPDATE animals
vet_clinic-# SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
vet_clinic-# WHERE name = 'Agumon';
UPDATE 1
vet_clinic=# UPDATE animals
vet_clinic-# SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
vet_clinic-# WHERE name IN ('Gabumon', 'Pikachu');
UPDATE 2
vet_clinic=# UPDATE animals
vet_clinic-# SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
vet_clinic-# WHERE name IN ('Devimon', 'Plantmon');
UPDATE 2
vet_clinic=# UPDATE animals
vet_clinic-# SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
vet_clinic-# WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE 3
vet_clinic=# UPDATE animals
vet_clinic-# SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
vet_clinic-# WHERE name IN ('Angemon', 'Boarmon');
UPDATE 2


--------------------------------------------------------------------------------- 

INSERT INTO animals (id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES
(1, 'Agumon', '2020-02-03', 10.23, true, 0),
(2, 'Gabumon', '2018-11-15', 8.0, true, 2),
(3, 'Pikachu', '2021-01-07', 15.04, false, 1),
(4, 'Devimon', '2017-05-12', 11.0, true, 5),
(5, 'Charmander', '2020-02-08', -11, false, 0),
(6, 'Plantmon', '2021-11-15', -5.7, true, 2),
(7, 'Squirtle', '1993-04-02', -12.13, false, 3),
(8, 'Angemon', '2005-06-12', -45, true, 1),
(9, 'Boarmon', '2005-06-07', 20.4, true, 7),
(10, 'Blossom', '1998-10-13', 17, true, 3),
(11, 'Ditto', '2022-05-14', 22, true, 4);
