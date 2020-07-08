I've gotten 3 different certs for connecting to AWS RDS
- rds-combined-ca-bundle.pem
- rds-ca-2019-root.pem
- rds-ca-2019-ap-southeast-1.pem

Usage is as such:
- `psql "host=postgis.cwfu5zygh6d4.ap-southeast-1.rds.amazonaws.com port=5432 sslmode=verify-full sslrootcert={path-to-cert} user={username} password={password}"`
- `psql "host=aurora-postgis-cluster.cluster-cwfu5zygh6d4.ap-southeast-1.rds.amazonaws.com port=5432 sslmode=verify-full sslrootcert={path-to-cert}  user={username} password={password}"`

Somehow only the `rds-combined-ca-bundle.pem` and `rds-ca-2019-root.pem` worked for me. 