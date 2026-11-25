-- PostgreSQL: Smart Home Management System
BEGIN;
CREATE TABLE roles (role_id INTEGER PRIMARY KEY, role_name VARCHAR(50) NOT NULL UNIQUE);
CREATE TABLE users (user_id INTEGER PRIMARY KEY, role_id INTEGER NOT NULL REFERENCES roles(role_id), login VARCHAR(50) NOT NULL UNIQUE, password_hash VARCHAR(255) NOT NULL);
CREATE TABLE rooms (room_id INTEGER PRIMARY KEY, room_name VARCHAR(80) NOT NULL UNIQUE);
CREATE TABLE devices (device_id INTEGER PRIMARY KEY, room_id INTEGER NOT NULL REFERENCES rooms(room_id), device_name VARCHAR(80) NOT NULL, is_on BOOLEAN NOT NULL DEFAULT FALSE, UNIQUE(room_id, device_name));
CREATE TABLE permissions (user_id INTEGER NOT NULL REFERENCES users(user_id), device_id INTEGER NOT NULL REFERENCES devices(device_id), can_control BOOLEAN NOT NULL, PRIMARY KEY(user_id,device_id));
CREATE TABLE command_logs (log_id INTEGER PRIMARY KEY, user_id INTEGER NOT NULL REFERENCES users(user_id), device_id INTEGER NOT NULL REFERENCES devices(device_id), requested_on BOOLEAN NOT NULL, status VARCHAR(20) NOT NULL CHECK(status IN ('success','denied','offline')), created_at TIMESTAMP NOT NULL);
INSERT INTO roles VALUES (1,'Үй иесі'),(2,'Отбасы мүшесі'),(3,'Әкімші');
-- Demo hashes only; not real credentials.
INSERT INTO users VALUES (1,1,'owner','demo_hash_1'),(2,2,'family','demo_hash_2'),(3,3,'admin','demo_hash_3');
INSERT INTO rooms VALUES (1,'Қонақ бөлме'),(2,'Ас үй'),(3,'Жатын бөлме');
INSERT INTO devices VALUES (1,1,'Жарық 1',TRUE),(2,2,'Жарық 2',FALSE),(3,3,'Жарық 3',FALSE);
INSERT INTO permissions VALUES (1,1,TRUE),(1,2,TRUE),(1,3,TRUE),(2,1,TRUE),(2,2,FALSE);
INSERT INTO command_logs VALUES (1,1,1,TRUE,'success','2026-11-24 10:00:00'),(2,1,2,FALSE,'success','2026-11-24 10:05:00'),(3,2,2,TRUE,'denied','2026-11-24 10:10:00'),(4,2,1,FALSE,'offline','2026-11-24 10:15:00');
COMMIT;

-- Query 1: JOIN
SELECT u.login, r.room_name, d.device_name, p.can_control
FROM permissions p JOIN users u ON p.user_id=u.user_id
JOIN devices d ON p.device_id=d.device_id
JOIN rooms r ON d.room_id=r.room_id
ORDER BY u.user_id,d.device_id;

-- Query 2: GROUP BY
SELECT d.device_name, COUNT(l.log_id) AS total_commands,
SUM(CASE WHEN l.status='success' THEN 1 ELSE 0 END) AS successful
FROM devices d LEFT JOIN command_logs l ON d.device_id=l.device_id
GROUP BY d.device_id,d.device_name ORDER BY d.device_id;
