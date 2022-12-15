--triggers:

DROP TABLE IF EXISTS logs;

CREATE TABLE logs (
	log_id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	username VARCHAR(50) NOT NULL,
	operation TEXT NOT NULL,
	tablename VARCHAR(50) NOT NULL,
	log_message TEXT NOT NULL,
	log_date DATE NOT NULL DEFAULT CURRENT_DATE,
	log_time TIME NOT NULL DEFAULT CURRENT_TIME
);


--LOGS:

--for client
CREATE OR REPLACE FUNCTION client_log_func() RETURNS TRIGGER AS $$
BEGIN
	IF (TG_OP = 'DELETE') THEN
		INSERT INTO logs
		(username, operation, tablename, log_message)
		VALUES
		((SELECT USER), TG_OP, TG_RELNAME, CONCAT_WS(' ', OLD.client_id, OLD.client_name, OLD.client_surname));
		RETURN OLD;
	ELSE 	
		INSERT INTO logs
		(username, operation, tablename, log_message)
		VALUES
		((SELECT USER), TG_OP, TG_RELNAME, CONCAT_WS(' ', NEW.client_id, NEW.client_name, NEW.client_surname));
		RETURN NEW;
	END IF;
END;
$$ LANGUAGE plpgsql;


DROP TRIGGER IF EXISTS client_log ON client;

CREATE TRIGGER client_log 
BEFORE INSERT OR DELETE OR UPDATE ON client
FOR EACH ROW 
EXECUTE PROCEDURE client_log_func();



--for animal
CREATE OR REPLACE FUNCTION animal_log_func() RETURNS TRIGGER AS $$
BEGIN
	IF (TG_OP = 'DELETE') THEN
		INSERT INTO logs
		(username, operation, tablename, log_message)
		VALUES
		((SELECT USER), TG_OP, TG_RELNAME, CONCAT_WS(' ', OLD.animal_id, OLD.animal_name, OLD.client_id));
		RETURN OLD;
	ELSE 	
		INSERT INTO logs
		(username, operation, tablename, log_message)
		VALUES
		((SELECT USER), TG_OP, TG_RELNAME, CONCAT_WS(' ', NEW.animal_id, NEW.animal_name, NEW.client_id));
		RETURN NEW;
	END IF;
END;
$$ LANGUAGE plpgsql;


DROP TRIGGER IF EXISTS animal_log ON animal;

CREATE TRIGGER animal_log 
BEFORE INSERT OR DELETE OR UPDATE ON animal
FOR EACH ROW 
EXECUTE PROCEDURE animal_log_func();



--PASSPORT DELETE
CREATE OR REPLACE FUNCTION delete_passport_func() RETURNS TRIGGER AS $$
BEGIN
	DELETE FROM passport
	WHERE passport_id = OLD.passport_id;
	RETURN OLD;
END;
$$ LANGUAGE plpgsql;


DROP TRIGGER IF EXISTS delete_passport ON client;

CREATE TRIGGER delete_passport
AFTER DELETE ON client
FOR EACH ROW
EXECUTE PROCEDURE delete_passport_func();



--ADDRESS DELETE
CREATE OR REPLACE FUNCTION delete_adress_func() RETURNS TRIGGER AS $$
BEGIN
	DELETE FROM adress
	WHERE adress_id = OLD.adress_id;
	RETURN OLD;
END;
$$ LANGUAGE plpgsql;


DROP TRIGGER IF EXISTS delete_adress ON passport;

CREATE TRIGGER delete_adress
AFTER DELETE ON passport
FOR EACH ROW
EXECUTE PROCEDURE delete_adress_func();





