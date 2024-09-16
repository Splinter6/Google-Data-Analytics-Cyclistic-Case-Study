SELECT 
    COUNT(ride_id) AS total_rides,
    SUM(CASE 
            WHEN TIMESTAMP_DIFF(ended_at, started_at, HOUR) > 12 
            THEN 1 
            ELSE 0 
        END) AS rides_over_12_hours,
    ROUND(100 * SUM(CASE 
                      WHEN TIMESTAMP_DIFF(ended_at, started_at, HOUR) > 12 
                      THEN 1 
                      ELSE 0 
                   END) / COUNT(ride_id), 2) AS percentage_over_12_hours
FROM 
    `cyclistic-data-strategy.555.ALL`;
