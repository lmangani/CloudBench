SELECT version()
SELECT count(*) FROM "https://shell.duckdb.org/data/tpch/0_01/parquet/lineitem.parquet";
SELECT cast(tpep_pickup_datetime as date) as day, approx_count_distinct(PULocationID) as locations, count(*) as trips, sum(fare_amount) + sum(mta_tax) + sum(tolls_amount) + sum(tip_amount) as revenue FROM 'https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2023-01.parquet' WHERE trip_distance > 5 GROUP BY cast(tpep_pickup_datetime as date) ORDER BY day;
