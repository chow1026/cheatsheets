-- access logs
SELECT
	datname,
	usename,
	ssl,
	client_addr
FROM
	pg_stat_ssl
INNER JOIN pg_stat_activity ON
	pg_stat_ssl.pid = pg_stat_activity.pid
WHERE
	ssl IS TRUE
	AND usename <> 'rdsadmin';

-- get all usernames that has had activities before
SELECT
	DISTINCT usename
FROM
	pg_stat_ssl
INNER JOIN pg_stat_activity ON
	pg_stat_ssl.pid = pg_stat_activity.pid;

-- get all usernames and privileges
SELECT
	*
FROM
	pg_catalog.pg_user;
	
-- get all roles
SELECT
	*
FROM
	pg_roles;

-- get roles and privilege attributes
SELECT
	u.usename AS "Role name",
	CASE
		WHEN u.usesuper
		AND u.usecreatedb THEN CAST('superuser, create
database' AS pg_catalog.text)
		WHEN u.usesuper THEN CAST('superuser' AS pg_catalog.text)
		WHEN u.usecreatedb THEN CAST('create database' AS pg_catalog.text)
		ELSE CAST('' AS pg_catalog.text)
	END AS "Attributes"
FROM
	pg_catalog.pg_user u
ORDER BY
	1;
	

-- show role heirarchy 
SELECT
	r.rolname,
	ARRAY(
		SELECT
			b.rolname
		FROM
			pg_catalog.pg_auth_members m
		JOIN pg_catalog.pg_roles b ON
			(
				m.roleid = b.oid
			)
		WHERE
			m.member = r.oid
	) AS memberof
FROM
	pg_catalog.pg_roles r
--WHERE
--	r.rolname NOT IN (
--		'pg_signal_backend', 'rds_iam', 'rds_replication', 'rds_superuser', 'rdsadmin', 'rdsrepladmin'
--	)
ORDER BY
	1;


-- create role/user
CREATE ROLE yoongshin WITH PASSWORD 'xxxxxx' login;
-- change user password (if needed)
ALTER ROLE yoongshin WITH PASSWORD 'yyyyyyyyy';
-- grant role(s) to user
GRANT rds_superuser TO yoongshin;
GRANT postgres TO yoongshin;

-- grant privileges of a database to user
GRANT ALL PRIVILEGES ON
DATABASE postgres TO yoongshin;
GRANT ALL PRIVILEGES ON
DATABASE openstreetmap TO yoongshin;
GRANT ALL PRIVILEGES ON
DATABASE openstreetmap TO postgres;


-- grant privileges of within schema(s) to user
GRANT ALL PRIVILEGES ON
ALL TABLES IN SCHEMA public TO postgres;
GRANT ALL PRIVILEGES ON
ALL TABLES IN SCHEMA pg_catalog TO postgres;

-- grant privileges of within schema(s) to user
GRANT ALL PRIVILEGES ON
ALL TABLES IN SCHEMA public TO yoongshin;
GRANT ALL PRIVILEGES ON
ALL TABLES IN SCHEMA pg_catalog TO yoongshin;

-- create database openstreetmap
CREATE DATABASE openstreetmap;

-- check created database
SELECT
	datname
FROM
	pg_database;

-- login as yoongshin and switch to openstreetmap database before continuing