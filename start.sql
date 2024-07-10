CREATE OR REPLACE TABLE cyclistic-data-strategy.555.ALL_DURATION_MDHMS AS
SELECT
  *,
  EXTRACT(YEAR FROM started_at) AS Y,
    EXTRACT(MONTH FROM started_at) AS M,
    EXTRACT(DAY FROM started_at) AS D,
    EXTRACT(HOUR FROM started_at) AS h,
    EXTRACT(MINUTE FROM started_at) AS m,
    EXTRACT(SECOND FROM started_at) AS s,
  TIMESTAMP_DIFF(ended_at, started_at, second) AS dur_s,
  TIMESTAMP_DIFF(ended_at, started_at, minute) AS dur_m,
  TIMESTAMP_DIFF(ended_at, started_at, hour) AS dur_h,
CAST(started_at AS DATE) AS ymd,
FROM
  `cyclistic-data-strategy.555.ALL`
WHERE TIMESTAMP_DIFF(ended_at, started_at, second) > -9000000
AND TIMESTAMP_DIFF(ended_at, started_at, second) <= 389652  --topside of duration minutes
AND start_station_name IS NOT NULL
ORDER BY dur_s DESC;
FROM
  `cyclistic-data-strategy.555.ALL`
WHERE TIMESTAMP_DIFF(ended_at, started_at, second) >= -999391 -- -16656m, -277h --bottomside. change these to tighten results. document how many removed.
AND TIMESTAMP_DIFF(ended_at, started_at, second) <= 389652  --6494m, 108h --topside
AND start_station_name IS NOT NULL
ORDER BY dur_s DESC;
## (((((!)))))  4,830,203 results of (5,707,168 in ALL)
## ((((((1)))))) Creates table from selecting all columns, adds another column which is the result of subtracting column 3 minus column 2.

CREATE OR REPLACE TABLE cyclistic-data-strategy.555.ALL_DURATION_MDHMS AS
SELECT
  *,
  EXTRACT(YEAR FROM started_at) AS year,
    EXTRACT(MONTH FROM started_at) AS month,
    EXTRACT(DAY FROM started_at) AS day,
    EXTRACT(HOUR FROM started_at) AS hour,
    EXTRACT(MINUTE FROM started_at) AS minute,
    EXTRACT(SECOND FROM started_at) AS second,
    TIMESTAMP_DIFF(ended_at, started_at, second) AS duration_seconds
FROM
  `cyclistic-data-strategy.555.ALL`
WHERE TIMESTAMP_DIFF(ended_at, started_at, second) > 0 
AND TIMESTAMP_DIFF(ended_at, started_at, second) < 43200
ORDER BY duration_seconds DESC;
## ((((((2)))))) Creates table from selecting all columns, adds another column which is the result of subtracting column 3 minus column 2. 12 hours in s = 43200

CREATE OR REPLACE TABLE cyclistic-data-strategy.555.ALL_DURATION_MDHMS AS
SELECT
  *,
  EXTRACT(YEAR FROM started_at) AS year,
    EXTRACT(MONTH FROM started_at) AS month,
    EXTRACT(DAY FROM started_at) AS day,
    EXTRACT(HOUR FROM started_at) AS hour,
    EXTRACT(MINUTE FROM started_at) AS minute,
    EXTRACT(SECOND FROM started_at) AS second,
    TIMESTAMP_DIFF(ended_at, started_at, second) AS duration_seconds
FROM
  `cyclistic-data-strategy.555.ALL`
WHERE TIMESTAMP_DIFF(ended_at, started_at, second) > 0 
AND TIMESTAMP_DIFF(ended_at, started_at, second) < 43200
AND start_station_name IS NOT NULL
ORDER BY duration_seconds DESC;
## ((((((3)))))) SAME BUT NO NULL start_station

CREATE OR REPLACE TABLE cyclistic-data-strategy.555.ALL_DURATION_MDHMS AS
SELECT
  *,
  EXTRACT(YEAR FROM started_at) AS year,
    EXTRACT(MONTH FROM started_at) AS month,
    EXTRACT(DAY FROM started_at) AS day,
    EXTRACT(HOUR FROM started_at) AS hour,
    EXTRACT(MINUTE FROM started_at) AS minute,
    EXTRACT(SECOND FROM started_at) AS second,
    TIMESTAMP_DIFF(ended_at, started_at, second) AS duration_seconds
FROM
  `cyclistic-data-strategy.555.ALL`
WHERE TIMESTAMP_DIFF(ended_at, started_at, second) > 0 
AND TIMESTAMP_DIFF(ended_at, started_at, second) < 43200
AND start_station_name IS NOT NULL
ORDER BY duration_seconds DESC;

UPDATE cyclistic-data-strategy.555.ALL_DURATION_MDHMS
SET start_station_name = REPLACE(NULL, "demo")
WHERE start_lat = 42.01
AND start_lng = -87.67;
## ((((((4)))))) SAME BUT updates/replaces

SELECT
  fart_1,
  COUNT(*) AS entry_count,
  COUNT(CASE member_casual WHEN 'member' THEN 1 END) AS membercount,
  COUNT(CASE member_casual WHEN 'casual' THEN 1 END) AS membercas
FROM
  `cyclistic-data-strategy.555.x`
GROUP BY
  fart_1
ORDER BY
  entry_count DESC;
## ((((((5)))))) 2024-01-15 M# =670 C#=61. Ice storm -10 temps. Members still used bikes by far over casual on extreme weather days. While there are some outliars to identify and remove, the scatter seems to be telling me casual users decline significantly in winter, holidays, and extreme weather events. Starting in april casual rider #'s picked back up. Find more insights here.

SELECT 
DISTINCT rideable_type AS distinct_id
FROM
`cyclistic-data-strategy.555.ALL`
## ((((((6))))))



SELECT
  *,
  EXTRACT(YEAR FROM started_at) AS year,
    EXTRACT(MONTH FROM started_at) AS month,
    EXTRACT(DAY FROM started_at) AS day,
    EXTRACT(HOUR FROM started_at) AS hour,
    EXTRACT(MINUTE FROM started_at) AS minute,
    EXTRACT(SECOND FROM started_at) AS second,
    EXTRACT(WEEK FROM started_at) AS FART,
    TIMESTAMP_DIFF(ended_at, started_at, second) AS duration_seconds,
    CAST(started_at AS DATE) AS fart
FROM
  `cyclistic-data-strategy.555.ALL`;
## 

/* SELECT
  *,
  CASE 
    WHEN EXTRACT(DAYOFWEEK FROM started_at) = 1 THEN 'Monday'
    WHEN EXTRACT(DAYOFWEEK FROM started_at) = 2 THEN 'Tuesday'
    WHEN EXTRACT(DAYOFWEEK FROM started_at) = 3 THEN 'Wednesday'
    WHEN EXTRACT(DAYOFWEEK FROM started_at) = 4 THEN 'Thursday'
    WHEN EXTRACT(DAYOFWEEK FROM started_at) = 5 THEN 'Friday'
    WHEN EXTRACT(DAYOFWEEK FROM started_at) = 6 THEN 'Saturday'
    WHEN EXTRACT(DAYOFWEEK FROM started_at) = 7 THEN 'Sunday'
    ELSE CAST(EXTRACT(DAYOFWEEK FROM started_at) AS STRING)
  END AS day_of_week
FROM
`cyclistic-data-strategy.555.ALL`;
## ((((((0)))))) Day of the week ride happened.






/*
             ?????????????????



SELECT
  *,
  ended_at - started_at AS fartduration
  CONCAT(year," ",month," ",day) AS ymd
FROM
  `cyclistic-data-strategy.555.ALLCLEAN`
## selects all columns and adds another column in which it is the result of subtracting column 3 minus column 2


*/
