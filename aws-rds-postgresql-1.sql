-- login as yoongshin and switch to openstreetmap database before continuing

-- create extensions
CREATE EXTENSION postgis;
CREATE EXTENSION hstore;
CREATE EXTENSION fuzzystrmatch;
CREATE EXTENSION postgis_tiger_geocoder;
CREATE EXTENSION postgis_topology;

-- change owner (optional)
ALTER SCHEMA tiger OWNER TO yoongshin;
ALTER SCHEMA tiger_data OWNER TO yoongshin;
ALTER SCHEMA topology OWNER TO yoongshin;


-- test POSTGIS installation and version
SELECT
	PostGIS_full_version();

-- list other installed pg_extension
SELECT *
FROM
pg_extension;

-- create functions
CREATE FUNCTION EXEC(TEXT) RETURNS TEXT LANGUAGE plpgsql VOLATILE AS $f$ BEGIN EXECUTE $1;

RETURN $1;
END;

$f$;

-- call EXEC function to test 
SELECT
	EXEC(
		'ALTER TABLE ' || quote_ident(s.nspname) || '.' || quote_ident(s.relname) || ' OWNER TO yoongshin;'
	)
FROM
	(
		SELECT
			nspname, relname
		FROM
			pg_class c
		JOIN pg_namespace n ON
			(
				c.relnamespace = n.oid
			)
		WHERE
			nspname IN (
				'tiger', 'topology'
			)
			AND relkind IN (
				'r', 'S', 'v'
			)
		ORDER BY
			relkind = 'S'
	) s;


-- set schema(s) search path
SET
search_path = public,
tiger;

-- test PostGIS function
SELECT
	na.address,
	na.streetname,
	na.streettypeabbrev,
	na.zip
FROM
	normalize_address('1 Devonshire Place, Boston, MA 02109') AS na;

-- set schema(s) search path
SET
search_path = public,
topology;

-- test topology function
SELECT
	topology.createtopology(
		'my_new_topo', 26986, 0.5
	);
