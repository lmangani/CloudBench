SELECT chdb();
SELECT count(*) FROM url('https://shell.duckdb.org/data/tpch/0_01/parquet/lineitem.parquet');
SELECT toYYYYMMDD(tpep_pickup_datetime) as day, uniqHLL12(PULocationID) as locations, count(*) as trips, sum(fare_amount) + sum(mta_tax) + sum(tolls_amount) + sum(tip_amount) as revenue FROM url('https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2023-01.parquet') WHERE trip_distance > 5 GROUP BY toYYYYMMDD(tpep_pickup_datetime) ORDER BY day;
