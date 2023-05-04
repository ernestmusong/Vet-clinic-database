/* Populate database with sample data. */

INSERT INTO animals (
id,
name,
date_of_birth,
escape_attempts,
neutered,
weight_kg
  ) VALUES (
1,
'Agumon',
'2020-02-03',
0,
true,
10.23
    );

INSERT INTO animals (
id,
name,
date_of_birth,
escape_attempts,
neutered,
weight_kg
  ) VALUES (
2,
'Gabumon',
'2018-11-15',
2,
true,
8.0
    );

INSERT INTO animals (
id,
name,
date_of_birth,
escape_attempts,
neutered,
weight_kg
  ) VALUES (
3,
'Pikachu',
'2021-01-07',
2,
false,
15.04
    );
    
INSERT INTO animals (
id,
name,
date_of_birth,
escape_attempts,
neutered,
weight_kg
  ) VALUES (
4,
'Devimon',
'2017-05-12',
5,
true,
11.0
    );

INSERT INTO animals (
id,
name,
date_of_birth,
escape_attempts,
neutered,
weight_kg
  ) VALUES (
5,
'Charmander',
'2020-02-08',
0,
false,
-11.0
    ),
 (
6,
'Plantmon',
'2021-11-15',
2,
true,
-5.7
    ),
 (
7,
'Squirtle',
'1993-04-02',
3,
false,
-12.13
    ),
 (
8,
'Angemon',
'2005-06-12',
1,
true,
-45
    ),
 (
9,
'Boarmon',
'2005-06-07',
7,
true,
-20.4
    ),
 (
10,
'Blossom',
'1998-10-13',
3,
true,
17
   ),
 (
11,
'Ditto',
'2022-05-14',
4,
true,
22
   );

  -- Insert data into owners table
INSERT INTO owners (full_name, age)
VALUES ('Sam Smith',34),
       ('Jennifer Orwell', 19),
       ('Bob', 45),
       ('Melody Pond', 77),
       ('Dean Winchester', 14),
       ('Jodie Whittaker', 38);

  -- Insert data into species table
INSERT INTO species (name)
VALUES ('Pokemon'),('Digimon');

-- update animals to include species_id
UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';

-- update animals to include onwers_id
UPDATE animals SET species_id = 1 WHERE name NOT LIKE '%mon';

 -- update animals to includes owner information
UPDATE animals set owners_id = 1 WHERE name LIKE 'Agumon';
UPDATE animals set owners_id = 2 WHERE name IN ('Gabumon','Pikachu');
UPDATE animals set owners_id = 3 WHERE name IN ('Davimon','Plantmon');
UPDATE animals set owners_id = 4 WHERE name IN  ('Chamandar',' Squirtle ','Blossom');
UPDATE animals set owners_id = 5 WHERE name IN ('Angemon','Boarmon');      
  
 