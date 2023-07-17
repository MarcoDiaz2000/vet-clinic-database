/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT PRIMARY KEY,
    name TEXT,
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

ALTER TABLE animals ADD COLUMN species TEXT;

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(255),
    age INT,
    PRIMARY KEY(id)
);

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    PRIMARY KEY(id)
);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INT;

ALTER TABLE animals ADD FOREIGN KEY (species_id) REFERENCES species(id);

ALTER TABLE animals ADD COLUMN owner_id INT;

ALTER TABLE animals ADD FOREIGN KEY (owner_id) REFERENCES owners(id);

CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY(id)
);

CREATE TABLE specializations (
    vet_id INT,
    species_id INT,
    PRIMARY KEY (vet_id, species_id),
    FOREIGN KEY (vet_id) REFERENCES vets (id),
    FOREIGN KEY (species_id) REFERENCES species (id)
);

CREATE TABLE visits (
    vet_id INT,
    animal_id INT,
    visit_date DATE,
    PRIMARY KEY (vet_id, animal_id, visit_date),
    FOREIGN KEY (vet_id) REFERENCES vets (id),
    FOREIGN KEY (animal_id) REFERENCES animals (id)
);

CREATE INDEX animal_id_asc ON visits (animal_id ASC);
CREATE INDEX vet_id_asc ON visits (vet_id ASC);
CREATE INDEX owner_email_asc ON owners (email ASC);