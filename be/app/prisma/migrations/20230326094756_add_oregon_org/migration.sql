CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

INSERT INTO organization(
	id, name, lat, "long", city, state, country, zipcode, status, email_domain)
	VALUES (uuid_generate_v4(), 'University of Oregon', 44.0448, -123.075736, 'Eugene', 'OR', 'United State', '97403', 'Active', 'uoregon.edu');
