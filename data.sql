/* Populate database with sample data. */

-- Insert Data INTO animals Table
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Agumon', '2020-02-03', 0, true, 10.23),
       ('Gabumon', '2018-11-15', 2, true, 8),
       ('Pikachu', '2021-01-07', 1, false, 15.04),
       ('Devimon', '2017-05-12', 5, true, 11);

-- Day2 : Insert data
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES('Charmander', '2020-02-08', 0, false, -11.0, '');
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES('Plantmon', '2021-11-15', 2, true, -5.7, '');
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES('Squirtle', '1993-04-02', 3, false, -12.13, '');
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES('Angemon', '2005-06-12', 1, true, -45.0, '');
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES('Boarmon', '2005-06-07', 7, true, 20.4, '');
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES('Blossom', '1998-10-13', 3, true, 17.0, '');
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES('Ditto', '2022-05-14', 4, true, 22.0, '');




/* Day 3 query multiple tables*/

INSERT INTO owners(full_name, age)
VALUES
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

INSERT INTO species(name)
VALUES
('Pokemon'),
('Digimon');

UPDATE animals
SET species_id = CASE
    WHEN name LIKE '%mon' THEN 2
    ELSE 1
END;


-- Sam smith owns agumon (owner_id=1)
UPDATE animals SET owner_id = 1 
WHERE name = 'Agumon';

-- Jennifer owns gabumon (owner_id=2)
UPDATE animals SET owner_id = 2 
WHERE name IN ('Gabumon', 'Pikachu');

-- Bob owns Devimon and Plantmon (owner_id=3)
UPDATE animals SET owner_id = 3 
WHERE name IN ('Devimon', 'Plantmon');

-- Melody owns Charmander, Squirtle, and Blossom (owner_id=4)
UPDATE animals SET owner_id = 4 
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

-- Dean owns Angemon and Boarmon (owner_id=5)
UPDATE animals SET owner_id = 5 
WHERE name IN ('Angemon', 'Boarmon');



/* Day4 : add "join table" for visits */

-- Add data for vets:
INSERT INTO vets (name, age, date_of_graduation) 
VALUES 
('William Tatcher', 45, '2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2008-06-08');

-- Add data for specializations:
INSERT INTO specializations (species_id, vet_id) 
VALUES (1, 1), (1, 3), (2, 3), (2, 4);

-- Add data for visits:
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES
((SELECT id FROM animals WHERE name = 'Agumon'),(SELECT id FROM vets WHERE name = 'William Tatcher' ),'2020-05-24'), 
((SELECT id FROM animals WHERE name = 'Agumon'),(SELECT id FROM vets WHERE name = 'Stephanie Mendez' ),'2020-07-22'), 
((SELECT id FROM animals WHERE name = 'Gabumon'),(SELECT id FROM vets WHERE name = 'Jack Harkness' ),'2021-02-02'),
((SELECT id FROM animals WHERE name = 'Pikachu'),(SELECT id FROM vets WHERE name = 'Maisy Smith' ),'2020-01-05'),
((SELECT id FROM animals WHERE name = 'Pikachu'),(SELECT id FROM vets WHERE name = 'Maisy Smith' ),'2020-03-08'),
((SELECT id FROM animals WHERE name = 'Pikachu'),(SELECT id FROM vets WHERE name = 'Maisy Smith' ),'2020-05-14'),
((SELECT id FROM animals WHERE name = 'Devimon'),(SELECT id FROM vets WHERE name = 'Stephanie Mendez' ),'2021-05-04'),
((SELECT id FROM animals WHERE name = 'Charmander'),(SELECT id FROM vets WHERE name = 'Jack Harkness' ),'2021-02-24'),
((SELECT id FROM animals WHERE name ='Plantmon'),(SELECT id FROM vets WHERE name = 'Maisy Smith'),'2019-12-21'),
((SELECT id FROM animals WHERE name ='Plantmon'),(SELECT id FROM vets WHERE name = 'William Tatcher'),'2020-08-10'),
((SELECT id FROM animals WHERE name ='Plantmon'),(SELECT id FROM vets WHERE name = 'Maisy Smith'),'2021-04-07'),
((SELECT id FROM animals WHERE name ='Squirtle'),(SELECT id FROM vets WHERE name = 'Stephanie Mendez'),'2019-09-29'),
((SELECT id FROM animals WHERE name ='Angemon'),(SELECT id FROM vets WHERE name = 'Jack Harkness'),'2020-10-03'),
((SELECT id FROM animals WHERE name ='Angemon'),(SELECT id FROM vets WHERE name = 'Jack Harkness'),'2020-11-04'),
((SELECT id FROM animals WHERE name ='Boarmon'),(SELECT id FROM vets WHERE name = 'Maisy Smith'),'2019-01-24'),
((SELECT id FROM animals WHERE name ='Boarmon'),(SELECT id FROM vets WHERE name = 'Maisy Smith'),'2019-05-15'),
((SELECT id FROM animals WHERE name ='Boarmon'),(SELECT id FROM vets WHERE name = 'Maisy Smith'),'2020-02-27'),
((SELECT id FROM animals WHERE name ='Boarmon'),(SELECT id FROM vets WHERE name = 'Maisy Smith'),'2020-08-03'),
((SELECT id FROM animals WHERE name ='Blossom'),(SELECT id FROM vets WHERE name = 'Stephanie Mendez'),'2020-05-24'),
((SELECT id FROM animals WHERE name ='Blossom'),(SELECT id FROM vets WHERE name = 'William Tatcher'),'2021-01-11'); 


-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.) *** three times
INSERT INTO visits (animal_id, vet_id, visit_date) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;
INSERT INTO visits (animal_id, vet_id, visit_date) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;
INSERT INTO visits (animal_id, vet_id, visit_date) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.) *** three times
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';

