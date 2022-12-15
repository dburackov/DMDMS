SELECT animal_name, client_id, date_of_birth
FROM animal
WHERE date_of_birth BETWEEN '2002-1-1' AND '2006-1-1' AND animal_name LIKE '_____'
ORDER BY client_id, date_of_birth;

SELECT client_id, client_surname
FROM client
WHERE client_id IN (
	SELECT client_id 
	FROM animal
	WHERE animal_name = 'Rey');

SELECT client.client_id, client.client_surname, COUNT(*)
FROM client 
INNER JOIN animal ON client.client_id = animal.client_id
GROUP BY client.client_id;

SELECT *
FROM client
WHERE NOT EXISTS (
	SELECT * 
	FROM animal
	WHERE animal.animal_id = client.client_id);

--затраты на каждого животного
SELECT 
client.client_id,
client.client_name,
animal.client_id,
animal.animal_name,
SUM(service_rendered.amount * (SELECT service.price 
							  FROM service
							  WHERE service.service_id = service_rendered.service_id))
FROM service_rendered
JOIN visitor_log ON visitor_log.visitor_log_id = service_rendered.visitor_log_id
JOIN animal ON animal.animal_id = visitor_log.animal_id
JOIN client ON client.client_id = animal.client_id
GROUP BY client.client_id, animal.animal_id;
		
SELECT client.client_id, client.client_surname, animal.animal_id, animal.animal_name 
FROM client 
INNER JOIN animal ON client.client_id = animal.client_id
ORDER BY client_id, animal_id;

SELECT client.client_id, client.client_surname, animal.animal_id, animal.animal_name 
FROM client 
LEFT OUTER JOIN animal ON client.client_id = animal.client_id
ORDER BY client_id, animal_id;

SELECT client.client_id, client.client_surname, animal.animal_id, animal.animal_name 
FROM client 
RIGHT OUTER JOIN animal ON client.client_id = animal.client_id
ORDER BY client_id, animal_id;

SELECT client.client_id, client.client_surname, animal.animal_id, animal.animal_name 
FROM client 
FULL JOIN animal ON client.client_id = animal.client_id
ORDER BY client_id, animal_id;

SELECT client.client_id, client.client_surname, animal.animal_id, animal.animal_name 
FROM client 
CROSS JOIN animal 
ORDER BY client_id, animal_id;

SELECT client_id, client_surname 
FROM client 
UNION 
SELECT animal_id, animal_name 
FROM animal;

