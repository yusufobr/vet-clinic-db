/*Queries that provide answers to the questions from all projects.*/

-- All animals whose name ends in "mon"
SELECT * FROM animals WHERE name LIKE '%mon';

-- Name of all animals born between 2016 and 2019
SELECT * FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-12-31';

-- Name of all animals that are neutered and have less than 3 escape attempts
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

-- Date of birth of all animals named either "Agumon" or "Pikachu"
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

-- Name and Escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- All animals that are neutered
SELECT * FROM animals WHERE neutered = true;

-- All animals not named Gabumon
SELECT * FROM animals WHERE name <> 'Gabumon';

-- all animals with a weight between 10.4kg and 17.3kg
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;



/* Day2 : query and update animals table : */

-- 1st
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- 2nd
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species = '';
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

-- 3rd
BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- 4th
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT sp1;
UPDATE animals SET weight_kg = -1 * weight_kg;
ROLLBACK TO SAVEPOINT sp1;
UPDATE animals SET weight_kg = -1 * weight_kg WHERE weight_kg < 0;
SELECT * FROM animals;
COMMIT;



-- Queries to answer the following questions:

-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) as average FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-31-12' GROUP BY species;



/* Day3 : query and update animals table : */

-- Animals who belong to Melody Pond
SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id 
WHERE owners.full_name = 'Melody Pond';

-- All the animals that are pokemon
SELECT animals.name FROM animals JOIN species ON animals.species_id = species.id 
WHERE species.name = 'Pokemon';

-- All owners and their animals,including those that don't own any animal
SELECT owners.full_name, animals.name FROM owners LEFT JOIN animals ON owners.id = animals.owner_id;

-- Animals per species
SELECT species.name, COUNT(*) FROM species JOIN animals ON species.id = animals.species_id 
GROUP BY species.name;

-- All digimon owned by jennifer
SELECT animals.name FROM animals 
JOIN species ON animals.species_id = species.id 
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

-- All the animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

-- The one who owns the most animals
SELECT owners.full_name, COUNT(animals.id) AS number_of_animals
FROM owners JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY number_of_animals DESC LIMIT 1;
