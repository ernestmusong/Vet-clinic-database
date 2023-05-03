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

