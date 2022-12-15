--Procedures and functions

--оплата услуг за животное
CREATE OR REPLACE FUNCTION get_animal_service_payment(animalId INT) 
RETURNS NUMERIC(2)
LANGUAGE SQL
AS $$
	SELECT 
	sum(service_rendered.amount * (SELECT service.price
								   FROM service
								   WHERE service.service_id = service_rendered.service_id))
	FROM service_rendered 
	JOIN visitor_log ON visitor_log.visitor_log_id = service_rendered.visitor_log_id 
	WHERE visitor_log.animal_id = animalId;
$$;


--оплата медикаментов за животное
CREATE OR REPLACE FUNCTION get_animal_medicines_payment(animalId INT) 
RETURNS NUMERIC(2)
LANGUAGE SQL
AS $$
	SELECT 
	sum(medicines_used.amount * (SELECT medicines.price
								   FROM medicines
								   WHERE medicines.medicines_id = medicines_used.medicines_id))
	FROM medicines_used 
	JOIN visitor_log ON visitor_log.visitor_log_id = medicines_used.visitor_log_id 
	WHERE visitor_log.animal_id = animalId;
$$;

--сумммарная оплата по животному
CREATE OR REPLACE FUNCTION get_animal_payment(animalId INT) 
RETURNS NUMERIC(2)
LANGUAGE SQL
AS $$
	SELECT 
	sum(get_animal_medicines_payment(animal_id) + get_animal_service_payment(animalId))
	FROM animal 
	WHERE animal_id = animalId
$$;


--затраты клиент по каждому животному
CREATE OR REPLACE FUNCTION get_client_animal_payment(clientId INT) 
RETURNS TABLE(client_id INT, client_surname VARCHAR(50), animal_id INT, animal_name VARCHAR(50), result_sum NUMERIC(2))
LANGUAGE SQL
AS $$
	SELECT 
	client.client_id,
	client.client_surname,
	animal.animal_id,
	animal.animal_name,
	get_animal_payment(animal.animal_id)
	FROM client
	JOIN animal ON client.client_id = animal.client_id AND client.client_id = clientId
	GROUP BY client.client_id, animal.animal_id;
$$;




--общие затраты одного клиентa
CREATE OR REPLACE FUNCTION get_client_payment(clientId INT) 
RETURNS TABLE(client_id INT, client_surname VARCHAR(50), result_sum NUMERIC(2))
LANGUAGE SQL
AS $$
	SELECT 
	client.client_id,
	client.client_surname,
	sum(get_animal_payment(animal.animal_id))
	FROM client
	JOIN animal ON client.client_id = animal.client_id AND client.client_id = clientId
	GROUP BY client.client_id;
$$;


--общая выручка клиники
CREATE OR REPLACE FUNCTION get_total_profit() 
RETURNS NUMERIC(2)
LANGUAGE SQL
AS $$
	SELECT 
	sum(get_animal_payment(animal.animal_id))
	FROM animal
$$;


--журнал посещения по каждому животному в отсуртированном порядке
CREATE OR REPLACE FUNCTION get_animal_visitor_log(animalId INT) 
RETURNS TABLE(visitor_log_id INT, visit_date DATE, visit_time TIME)
LANGUAGE SQL
AS $$
	SELECT 
	visitor_log_id,
	visit_date,
	visit_time
	FROM visitor_log
	WHERE visitor_log.animal_id = animalId
	ORDER BY visit_date, visit_time;
$$;

--журнал посещения по каждому животному в указанный период
CREATE OR REPLACE FUNCTION get_animal_visitor_log_by_date(animalId INT, startDate DATE) 
RETURNS TABLE(visitor_log_id INT, visit_date DATE, visit_time TIME)
LANGUAGE SQL
AS $$
	SELECT 
	visitor_log_id,
	visit_date,
	visit_time
	FROM visitor_log
	WHERE visitor_log.animal_id = animalId AND visit_date >= startDate
	ORDER BY visit_date, visit_time;
$$;

--список клиентов определенной клиники

CREATE OR REPLACE FUNCTION get_client_by_clinic(clinicId INT)
RETURNS TABLE(client_id INT, client_name VARCHAR(50), client_surname VARCHAR(50), registration_date DATE)
LANGUAGE SQL
AS $$
	SELECT 
	client.client_id,
	client.client_name,
	client.client_surname,
	client.registration_date
	FROM client
	JOIN client_clinic ON client.client_id = client_clinic.client_id
	WHERE client_clinic.clinic_id = clinicId;
$$;

--список сотрудников определнной клиники

SELECT * FROM get_animal_service_payment(29);
SELECT * FROM get_animal_medicines_payment(29);
SELECT * FROM get_animal_payment(29);
select * from get_client_animal_payment(11);
select * from get_total_profit();
select * from get_animal_visitor_log(11);
select * from get_animal_visitor_log_by_date(11, '2002-1-1');
select * from get_client_by_clinic(1);