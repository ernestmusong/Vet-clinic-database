/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name Like '%mon';
SELECT name from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
SELECT name from animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth from animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;
SELECT * from animals WHERE neutered = true;
SELECT * from animals WHERE name != 'Gabumon';
SELECT * from animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- TRANSACTIONS
-- set species column to unspecified, verify and roll back
BEGIN;
UPDATE animals
SET species='unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;
-- Set species column to digimon for all animals that have a name ending in mon
BEGIN;
UPDATE animals
SET species='digimon'
WHERE name LIKE '%mon';
-- Set species column to pokemon for all animals that don't have species already set, commit verify and.
UPDATE animals
SET species='pokemon'
WHERE name NOT LIKE '%mon';
COMMIT;
SELECT * FROM animals;
-- Delete all records, roll back and verify
BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;
/* Delete all animals born after Jan 1st, 2022, create a savepoint, 
update all animals weight, roll back to savepoint, update all animals
weight that are negative and commit transaction. */
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2020-01-01';
SAVEPOINT DeleteDitto;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO DeleteDitto;
UPDATE animals SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
COMMIT;

/* Write queries to answer the following questions */

-- How many animals are there?
SELECT COUNT(*) FROM animals;
-- How many animals have never tried to escape?
SELECT
COUNT(*)
FROM animals
WHERE
escape_attempts = 0;
-- What is the average weight of animals?
SELECT AVG(weight_kg)
FROM animals;

/* Who escapes the most, neutered or not neutered animals? */

-- 01) sum escape_attempts for neutered animals
SELECT
neutered,
SUM(escape_attempts)
FROM animals
GROUP BY neutered
HAVING neutered = true; -- 20
-- 02) sum escape_attempts for neutered animals
SELECT
neutered,
SUM(escape_attempts)
FROM animals
GROUP BY neutered
HAVING neutered = false; -- 5
-- answer = neutered

/* What is the minimum and maximum weight of each type of animal? */

SELECT species, MIN(weight_kg), MAX(weight_kg)
FROM animals
GROUP BY species;

/* What is the average number of escape attempts per animal type
 of those born between 1990 and 2000? */

SELECT
species, avg(escape_attempts)
FROM animals
WHERE  EXTRACT(YEAR FROM date_of_birth) BETWEEN 1990 AND 2000
GROUP BY species;

/* Write queries (using JOIN) to answer the following questions */

-- what animal belong to melody pond?
SELECT full_name, name FROM owners 
JOIN animals ON animals.owners_id = owners.id WHERE owners.full_name = 'Melody Pond';

-- List all animals that are pokemon
SELECT animals.*, species.name AS animal_Type FROM animals 
JOIN species ON animals.species_id = species.id 
WHERE species.name LIKE 'Pokemon';

-- List all owners and their animals.
SELECT * FROM owners left JOIN animals ON animals.owners_id = owners.id;

-- How many animals are there per species?
SELECT species.name, count(*) AS amount FROM species
JOIN animals ON animals.species_id = species.id 
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell. 
SELECT species.name AS species_name, animals.name AS animal_name, owners.full_name
FROM species
JOIN animals ON species.id = animals.species_id
JOIN owners ON owners.id = animals.owners_id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name LIKE 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT * FROM animals
JOIN owners ON animals.owners_id=owners.id
WHERE animals.escape_attempts<1 
AND owners.full_name LIKE 'Dean Winchester';

-- Who owns the most animals? 
SELECT owners.full_name AS full_name,count(*) AS count FROM animals
JOIN owners ON animals.owners_id=owners.id
GROUP BY owners.full_name
ORDER BY count DESC;
 