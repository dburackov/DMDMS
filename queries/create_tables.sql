DROP TABLE IF EXISTS kind, 
	breed, 
	adress, 
	passport, 
	client, 
	animal, 
	clinic, 
	client_clinic, 
	staff,
	visitor_log,
	service,
	medicines,
	service_rendered,
	medicines_used;

CREATE TABLE kind (
	kind_id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	kind_name VARCHAR(50) NOT NULL 
);

CREATE TABLE breed (
	breed_id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	breed_name VARCHAR(50) NOT NULL,
	kind_id INT NOT NULL,
	CONSTRAINT fk_kind_breed FOREIGN KEY (kind_id) REFERENCES kind (kind_id) ON DELETE CASCADE
);

CREATE TABLE adress (
	adress_id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	city VARCHAR(50) NOT NULL,
	street VARCHAR(50) NOT NULL,
	home VARCHAR(50) NOT NULL, 
	flat VARCHAR(50)
);

--CREATE TYPE SEX AS ENUM('M', 'F');
--CREATE TYPE IF NOT EXISTS STAFFROLE AS ENUM('Admin', 'Manager', 'Staff');


CREATE TABLE passport (
	passport_id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	adress_id INT NOT NULL,
	date_of_birth DATE NOT NULL,
	sex SEX NOT NULL,
	iin CHAR(6) NOT NULL,
	CONSTRAINT fk_adress_passport FOREIGN KEY (adress_id) REFERENCES adress (adress_id) ON DELETE NO ACTION
);

CREATE TABLE client (
	client_id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	passport_id INT NOT NULL,
	client_name VARCHAR(50) NOT NULL,
	client_surname VARCHAR(50) NOT NULL, 
	registration_date DATE NOT NULL DEFAULT CURRENT_DATE,
	phone_number VARCHAR(20) NOT NULL,
	email VARCHAR(50),
	CONSTRAINT fk_passport_client FOREIGN KEY (passport_id) REFERENCES passport (passport_id) ON DELETE NO ACTION
);

CREATE TABLE animal (
	animal_id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	breed_id INT DEFAULT NULL,
	client_id INT DEFAULT NULL,
	animal_name VARCHAR(50) NOT NULL,
	sex SEX NOT NULL,
	date_of_birth DATE NOT NULL,
	information VARCHAR(255),
	CONSTRAINT fk_breed_animal FOREIGN KEY (breed_id) REFERENCES breed (breed_id) ON DELETE SET DEFAULT,
	CONSTRAINT fk_client_animal FOREIGN KEY (client_id) REFERENCES client (client_id) ON DELETE SET DEFAULT
);

CREATE TABLE clinic (
	clinic_id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	adress_id INT DEFAULT NULL,
	phone_number VARCHAR(20) NOT NULL,
	CONSTRAINT fk_adress_clinic FOREIGN KEY (adress_id) REFERENCES adress (adress_id) ON DELETE SET DEFAULT
);

CREATE TABLE client_clinic (
	client_id INT NOT NULL REFERENCES client (client_id) ON DELETE CASCADE,
	clinic_id INT NOT NULL REFERENCES clinic (clinic_id) ON DELETE CASCADE,
	CONSTRAINT pk_client_clinic PRIMARY KEY (client_id, clinic_id)
);

CREATE TABLE staff (
	staff_id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	passport_id INT NOT NULL,
	clinic_id INT NOT NULL,
	staff_name VARCHAR(50) NOT NULL,
	staff_surname VARCHAR(50) NOT NULL,
	staff_role STAFFROLE NOT NULL,
	staff_position VARCHAR(50) NOT NULL,
	phone_number VARCHAR(20) NOT NULL,
	email VARCHAR(50),
	CONSTRAINT fk_passport_staff FOREIGN KEY (passport_id) REFERENCES passport (passport_id) ON DELETE NO ACTION,
	CONSTRAINT fk_clinic_staff FOREIGN KEY (clinic_id) REFERENCES clinic (clinic_id) ON DELETE CASCADE
);

CREATE TABLE visitor_log (	
	visitor_log_id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	animal_id INT NOT NULL,
	visit_date DATE DEFAULT CURRENT_DATE,
	visit_time TIME DEFAULT CURRENT_TIME,
	CONSTRAINT fk_animal_visit_log FOREIGN KEY (animal_id) REFERENCES animal (animal_id) ON DELETE CASCADE
);

CREATE TABLE service (
	service_id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	service_name VARCHAR(50) NOT NULL,
	price NUMERIC(2) NOT NULL
);

CREATE TABLE medicines (
	medicines_id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	medicines_name VARCHAR(50) NOT NULL,
	description VARCHAR(50) NOT NULL,
	price NUMERIC(2) NOT NULL
);

CREATE TABLE service_rendered (
	service_rendered_id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	staff_id INT REFERENCES staff (staff_id) ON DELETE SET NULL,--!!!,
	service_id INT REFERENCES service (service_id) ON DELETE CASCADE,
	visitor_log_id INT NOT NULL REFERENCES visitor_log (visitor_log_id) ON DELETE CASCADE,
	amount INT NOT NULL
	--CONSTRAINT fk_staff_service_rendered FOREIGN KEY (staff_id) REFERENCES staff (staff_id)
);

CREATE TABLE medicines_used (
	medicines_used_id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	visitor_log_id INT NOT NULL REFERENCES visitor_log (visitor_log_id) ON DELETE CASCADE,
	medicines_id INT NOT NULL REFERENCES medicines (medicines_id) ON DELETE CASCADE,
	amount INT NOT NULL
);
