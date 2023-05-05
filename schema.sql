/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id int,
    name varchar(100),
    date_of_birth date,
    escape_attempts int,
    neutered boolean,
    weight_kg decimal,
    species varchar(100),
);

ALTER TABLE animals
ADD species VARCHAR(255);

CREATE TABLE owners (
    id int GENERATED ALWAYS as identity primary key,
    full_name varchar(100) not null,
    age int not null
);
CREATE TABLE species (
    id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name varchar(100) NOT NULL
);

/* MODIFY ANIMALS TABLE*/

ALTER TABLE animals
ADD PRIMARY KEY (id);
ALTER TABLE animals ALTER column id SET NOT NULL;
ALTER TABLE animals ALTER column id ADD GENERATED ALWAYS AS IDENTITY;

ALTER TABLE animals DROP column species;

ALTER TABLE animals ADD column species_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id);

ALTER TABLE animals ADD column owners_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_owners FOREIGN KEY(owners_id) REFERENCES owners(id);

/* VET CLINIC DATABASE: Add "join table" for visits */

-- Create vets table
CREATE TABLE vets (
    id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name varchar(100) NOT NULL,
    age int NOT NULL,
    date_of_graduation date NOT NULL
);
-- Create "join table"
CREATE TABLE specializations (
species_id int,
vets_id int
);
-- Add primary key to specializations and reference foreign keys
ALTER TABLE specializations ADD PRIMARY KEY (species_id, vets_id);
ALTER TABLE specializations ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species (id);
ALTER TABLE specializations ADD CONSTRAINT fk_vets FOREIGN KEY (vets_id) REFERENCES vets (id);
-- Create "join table"
 CREATE TABLE visits (
animals_id int,
vets_id int,
date_of_visit date NOT NULL
 );
 -- Add primary key to visits and reference foreign keys
ALTER TABLE visits ADD PRIMARY KEY (animals_id, vets_id, date_of_visit);
ALTER TABLE visits ADD CONSTRAINT fk_animals FOREIGN KEY (animals_id) REFERENCES animals (id);
ALTER TABLE visits ADD CONSTRAINT fk_vets FOREIGN KEY (vets_id) REFERENCES vets (id);