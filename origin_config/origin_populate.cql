--- insert sample rows into origin

USE my_application_ks;

INSERT INTO user_status (user, when, status) VALUES ('eva', '2022-10-10 12:00:00', 'Online');
INSERT INTO user_status (user, when, status) VALUES ('eva', '2022-10-10 13:00:00', 'Away');
INSERT INTO user_status (user, when, status) VALUES ('eva', '2022-10-10 14:00:00', 'Offline');
INSERT INTO user_status (user, when, status) VALUES ('marco', '2022-10-10 13:30:00', 'Sleeping');

