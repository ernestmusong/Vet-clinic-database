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