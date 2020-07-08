# osm2pgsql planet to PostGIS on AWS RDS

## pre-requisites and notes:
- since no direct ssh allowed to AWS RDS, I need an EC2 instance to download the planet.osm.pbf
- the EC2 instance needs to be on the same VPC as the RDS
- the EC2 instance needs to be allowed to connect to the PostGIS RDS via psql
- the Bastion host was a natural choice for this
- the Bastion host was upgraded to m5.8xlarge
- the volume has to be expanded to at least 500GB as well (note: volume can only be adjusted once every 24 hours)
- remember to use screen sessions for long processes

## download planet.osm.pbf

Download OSM latest planet from osm or AWS S3:
`wget https://planet.osm.org/pbf/planet-latest.osm.pbf`

Or copy from aws s3 (need to figure out the latest filename): 
`aws s3 cp s3://osm-pds/2020/planet-200629.osm.pbf .`

## Test connection to RDS to make sure the database is reachable
First test the connection to RDS via psql, key in password when prompted
`psql -h postgis.cwfu5zygh6d4.ap-southeast-1.rds.amazonaws.com -p 5432 -U postgres -W` 
or 
`psql -h postgis.cwfu5zygh6d4.ap-southeast-1.rds.amazonaws.com -p 5432 -d {database} -U {username} -W`

## load OSM planet tiles to PostGIS Server
Then, load osm to PostGIS using the verified credentials
`time osm2pgsql --create --slim --cache 50000 --keep-coastlines --flat-nodes tmp-osm --hstore --extra-attributes --host postgis.cwfu5zygh6d4.ap-southeast-1.rds.amazonaws.com --port 5432 --username postgres --password --database openstreetmap planet-latest.osm.pbf`
