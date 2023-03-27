CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

INSERT INTO incidence_type(
    id,name, description, category)
	VALUES (uuid_generate_v4(),'Car Theft', '', 'Theft'),
	(uuid_generate_v4(),'Home Break-in', '', 'Theft'),
	(uuid_generate_v4(),'Pickpocket', '', 'Theft'),
	(uuid_generate_v4(),'Stolen Item', '', 'Theft'),
	(uuid_generate_v4(),'Fight', '', 'Violence'),
	(uuid_generate_v4(),'Gun Pulled', '', 'Violence'),
	(uuid_generate_v4(),'Knife Pulled', '', 'Violence'),
	(uuid_generate_v4(),'Weaponized Object', '', 'Violence'),
	(uuid_generate_v4(),'Stalking', '', 'ThreateningPerson'),
	(uuid_generate_v4(),'Lingering', '', 'ThreateningPerson'),
	(uuid_generate_v4(),'Harassment', '', 'ThreateningPerson'),
	(uuid_generate_v4(),'Yelling', '', 'SuspiciousActivity'),
	(uuid_generate_v4(),'Loud Noise', '', 'SuspiciousActivity'),
	(uuid_generate_v4(),'Argument', '', 'SuspiciousActivity'),
	(uuid_generate_v4(),'Fire', '', 'Hazard'),
	(uuid_generate_v4(),'Powerline', '', 'Hazard'),	     
	(uuid_generate_v4(),'Flood', '', 'Hazard'),	     
	(uuid_generate_v4(),'Car Crash', '', 'Hazard'),	     
	(uuid_generate_v4(),'General', '', 'GeneralIncident'),
	(uuid_generate_v4(),'Emergency Responder', '', 'EmergencyResponder');	
