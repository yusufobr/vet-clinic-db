/* Database schema to keep the structure of entire database. */

-- Create vet_clinic Database
CREATE DATABASE vet_clinic;

-- Connect to vet_clinic Database
\c vet_clinic;

-- Create animals Table
CREATE TABLE animals (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  date_of_birth DATE,
  escape_attempts INTEGER,
  neutered BOOLEAN,
  weight_kg DECIMAL
);

-- Day2 : Add column species of type string to animals table
ALTER TABLE animals
ADD COLUMN species VARCHAR(50);



/* Day3 : query multiple tables*/

CREATE TABLE owners(
    id BIGSERIAL PRIMARY KEY,
    full_name VARCHAR(255),
    age INTEGER
);

CREATE TABLE species(
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255)
);

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD COLUMN species_id INTEGER REFERENCES species(id),
ADD COLUMN owner_id INTEGER REFERENCES owners(id);



/* Day4 : add "join table" for visits */

CREATE TABLE vets(
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    age INTEGER,
    date_of_graduation DATE
);

CREATE TABLE specializations(
    id BIGSERIAL PRIMARY KEY,
    vet_id INTEGER REFERENCES vets(id),
    species_id INTEGER REFERENCES species(id),
    UNIQUE (vet_id, species_id)
);

CREATE TABLE visits (
    id BIGSERIAL PRIMARY KEY,
    vet_id INTEGER REFERENCES vets(id),
    animal_id INTEGER REFERENCES animals(id),
    visit_date DATE,
    UNIQUE (vet_id, animal_id, visit_date)
);


-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- Drop the UNIQUE constraint from visits table
ALTER TABLE visits
DROP CONSTRAINT visits_vet_id_animal_id_visit_date_key;

-- Create indexes to improve perforomance
CREATE INDEX index_animal_id ON visits (animal_id);
CREATE INDEX index_vet_id ON visits (vet_id);
CREATE INDEX index_email_owners ON owners (email);

-- Sort the data in the table
CLUSTER visits USING index_vet_id;