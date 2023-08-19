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