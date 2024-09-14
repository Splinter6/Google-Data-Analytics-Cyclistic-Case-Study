1. User Demographics
        Member vs. Casual Users: Analysis of usage patterns between registered members and casual (non-member) users.
        Total Ride Numbers

2. Trip Details
        Trip Duration: Average, median, and distribution of trip durations.
            avg
            med
            
        Trip Distance: Average, median, and distribution of trip distances.
        Start and End Times: Peak hours, peak days of the week, seasonal variations.
        Start and End Locations: Popular starting and ending stations or locations.

3. Temporal Patterns
        Time of Day: Analyzing trips by hours (morning, afternoon, evening, night).
        Day of the Week: Usage patterns on weekdays vs. weekends.
        Monthly and Seasonal Trends: Monthly usage patterns and seasonal variations.

4. Geographical Patterns
        Popular Routes: Commonly used routes between specific stations.
        Heat Maps: Visualization of start and end locations.
        Distance Analysis: Distribution of trip distances.


1. User Demographic

-- Query 1: Count/Calculate the total trips made by members and casual riders
--Should I keep the totalridenumber in this?

WITH TotalCounts AS (
    SELECT COUNT(*) AS TotalRideNumber
    FROM `cyclistic-data-strategy.555.ALLCLEAN`
)
SELECT
    member_casual,
    rideable_type,
    COUNT(*) AS TotalTrips,
    ROUND((COUNT(*) / TotalCounts.TotalRideNumber) * 100, 1) AS PercentageOfTotal,
    TotalCounts.TotalRideNumber
FROM
    `cyclistic-data-strategy.555.ALLCLEAN`,
    TotalCounts
GROUP BY
    member_casual,
    rideable_type,
    TotalRideNumber
ORDER BY
    TotalTrips DESC;

-- Query 2: Day of week most rides happen for M C
-- Looking at which days have the highest number of rides
-- Mode, day of week with ride count

SELECT
    member_casual, 
    dayofweek AS mode,
    ride_count
FROM 
    (
    SELECT
        member_casual, 
        dayofweek, 
        COUNT(dayofweek) AS ride_count,
        RANK() OVER (PARTITION BY member_casual ORDER BY COUNT(dayofweek) DESC) AS rnk
    FROM
        `cyclistic-data-strategy.555.ALLCLEAN`
    GROUP BY
        member_casual, dayofweek
    )
WHERE
    rnk <= 3
ORDER BY
    member_casual DESC, rnk ASC;





--B. DISTANCE(LENGTH)

-- Query 2: avg ride distance(ft) of members vs casual riders

SELECT
    member_casual,
    ROUND(AVG(distance_ft),2) AS TotalDistance_ft
FROM
    `cyclistic-data-strategy.555.ALLCLEAN`
GROUP BY
    member_casual
ORDER BY
    TotalDistance_ft DESC;

-- Query 3: Median ride distance(ft)

SELECT
    DISTINCT member_casual,
    median_ride_length_ft
FROM 
        (
        SELECT 
                ride_id,
                member_casual,
                distance_ft,
                ROUND(PERCENTILE_DISC(distance_ft, 0.5 IGNORE NULLS) OVER(PARTITION BY member_casual),2) AS  median_ride_length_ft
        FROM 
                `cyclistic-data-strategy.555.ALLCLEAN`
        )
GROUP BY
    member_casual,
    median_ride_length_ft
ORDER BY 
        median_ride_length_ft DESC;



-- C) DURATION
--

-- Query 4: avg ride duration

SELECT
member_casual AS user_type,
AVG(dur_m)AS avg_ride_length
From `cyclistic-data-strategy.555.ALLCLEAN`
WHERE dur_m > 0 AND dur_m < 240
Group BY member_casual;


-- #5 avg ride duration of both M & C

SELECT
    member_casual,
    ROUND(AVG(dur_m), 2) AS avg_ride_duration_min
FROM 
    `cyclistic-data-strategy.555.ALLCLEAN`
GROUP BY
    member_casual
ORDER BY 
    avg_ride_duration_min DESC;


-- #5 median ride duration

/*
SELECT
        DISTINCT median_ride_length,
        member_casual
FROM 
        (
        SELECT 
                member_casual,
                dur_m,
                PERCENTILE_DISC(dur_m, 0.5 IGNORE NULLS) OVER(PARTITION BY member_casual) AS  median_ride_length
        FROM 
                `cyclistic-data-strategy.555.ALLCLEAN`
        WHERE
            member_casual = 'member'
        OR 
            member_casual = 'casual'
        )
ORDER BY 
        median_ride_length DESC LIMIT 2; */



-- Query 7: all riders duration 

WITH ride_times AS (
 SELECT
   dur_m,
   COUNT(*) AS ride_count,
   100 * COUNT(*) / SUM(COUNT(*)) OVER () AS ride_percent
 FROM
   `cyclistic-data-strategy.555.ALLCLEAN`
 GROUP BY
   dur_m
)
SELECT
 dur_m AS ride_time_minutes,
 ride_count,
 ROUND(ride_percent, 2) AS ride_percent
FROM
 ride_times
WHERE
 dur_m > 0 and dur_m <= 60
ORDER BY
 dur_m;



-- Query 8 member ride duration
WITH ride_times AS (
 SELECT
   dur_m,
   COUNT(*) AS ride_count,
   100 * COUNT(*) / SUM(COUNT(*)) OVER () AS ride_percent
 FROM
   `cyclistic-data-strategy.555.ALLCLEAN`
  WHERE
 member_casual = 'member'
 GROUP BY
   dur_m
)
SELECT
 dur_m AS ride_time_minutes,
 ride_count,
 ROUND(ride_percent, 2) AS ride_percent
FROM
 ride_times
WHERE
 dur_m > 0 and dur_m <= 60
ORDER BY
 dur_m;

-- Query 9 casual rider duration
WITH ride_times AS (
 SELECT
   dur_m,
   COUNT(*) AS ride_count,
   100 * COUNT(*) / SUM(COUNT(*)) OVER () AS ride_percent
 FROM
   `cyclistic-data-strategy.555.ALLCLEAN`
  WHERE
 member_casual = 'casual'
 GROUP BY
   dur_m
)
SELECT
 dur_m AS ride_time_minutes,
 ride_count,
 ROUND(ride_percent, 2) AS ride_percent
FROM
 ride_times
WHERE
 dur_m > 0 and dur_m <= 60
ORDER BY
 dur_m;

-- COUNTS

-- Day of WEEK COUNT
SELECT
    dayofweek,
    member_casual,
    COUNT(*) AS ride_count
FROM 
    `cyclistic-data-strategy.555.ALLCLEAN`
GROUP BY 
    dayofweek,
    DATE(started_at),
    member_casual
ORDER BY 
    member_casual;
