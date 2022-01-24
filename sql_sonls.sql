-- Rides started on 1.15
SELECT count(*) 
FROM yellow_taxi_trips 
WHERE DATE_PART('day', tpep_pickup_datetime) = 15;

-- Day with the biggest tip in January
SELECT DATE_PART('day', tpep_pickup_datetime), max(tip_amount) as tip
FROM yellow_taxi_trips 
GROUP BY DATE_PART('day', tpep_pickup_datetime)
ORDER BY tip DESC;

-- Most common drop off location from Central Park
SELECT zone."Zone", b."trips"
FROM (
    SELECT a."DOLocationID",  count(*) as trips
    FROM (
    SELECT *
    FROM yellow_taxi_trips as trips
    LEFT JOIN zone_data as zone
        ON trips."PULocationID" = zone."LocationID"
    WHERE DATE_PART('day', tpep_pickup_datetime) = 14) as a
    GROUP BY a."DOLocationID") b
LEFT JOIN zone_data as zone 
   ON b."DOLocationID" = zone."LocationID"
ORDER BY b."trips" DESC;

-- Most expensive trip
 
SELECT zone_A."Zone", zone_B."Zone", AVG(trips."total_amount") as avg_fare
FROM yellow_taxi_trips as trips
LEFT JOIN zone_data as zone_A
    ON trips."PULocationID" = zone_A."LocationID"
LEFT JOIN zone_data as zone_B
    ON trips."DOLocationID" = zone_B."LocationID" 
GROUP BY zone_A."Zone", zone_B."Zone"
ORDER BY avg_fare DESC
LIMIT 1;