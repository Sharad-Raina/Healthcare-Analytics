
/* Operations & Patient Care
Q1. What percentage of encounters result in readmissions within 30 days, 
and which type of encounter class have the highest readmission rates? */

-- Percentage Re-Admission within 30 days
WITH re AS (
    SELECT 
        PATIENT, 
        ENCOUNTERCLASS, 
        [START], 
        LAG([START]) OVER (PARTITION BY PATIENT ORDER BY [START]) AS previous_admission_date,
        DATEDIFF(DAY, LAG([START]) OVER (PARTITION BY PATIENT ORDER BY [START]), [START]) AS diff
    FROM dbo.encounters
)
SELECT 
    round((COUNT(distinct(PATIENT)) * 100) / (select COUNT(*) from dbo.encounters),2) as Percentage_readmission_rate
FROM re
WHERE diff > 0 AND diff <= 30;


-- Perentage Re-admission within 30 days by encounter class
WITH re AS (
    SELECT 
        PATIENT, 
        ENCOUNTERCLASS, 
        [START], 
        LAG([START]) OVER (PARTITION BY PATIENT ORDER BY [START]) AS previous_admission_date,
        DATEDIFF(DAY, LAG([START]) OVER (PARTITION BY PATIENT ORDER BY [START]), [START]) AS diff
    FROM dbo.encounters
)
SELECT 
   ENCOUNTERCLASS  , round((COUNT(distinct(PATIENT)) * 100) / (select COUNT(*) from dbo.encounters),1 ) as Percentage_readmission_rate_Encounter_class
FROM re

WHERE diff > 0 AND diff <= 30
group by ENCOUNTERCLASS;



/* 
Q2. How does average length of stay (calculated from Start and Stop timestamps) vary by encounter class (e.g., emergency vs. wellness)?
 */


select ENCOUNTERCLASS , avg(diff_mins) as Avg_length_of_stay_mins
from 
(
select PATIENT , ENCOUNTERCLASS,[START] , STOP  , abs(DATEDIFF(MINUTE , STOP,[START])) as diff_mins

from dbo.encounters 


) x GROUP by ENCOUNTERCLASS order by Avg_length_of_stay_mins DESC


/* 
Q3. Which organizations/locations have the highest patient throughput (encounters per day) and longest wait times?
 */

-- Updated encounters table to get the Payer names
UPDATE e
SET ORGANIZATION = p.NAME

from dbo.encounters e
join dbo.payers p 
on e.PAYER = p.Id ; 


SELECT 
  ORGANIZATION,
  COUNT(*) AS Total_Encounters,
  COUNT(DISTINCT CAST([START] AS DATE)) AS Total_Days,
  FLOOR(COUNT(*) * 1.0 / COUNT(DISTINCT CAST([START] AS DATE))) AS Encounters_Per_Day, 
  AVG(DATEDIFF(MINUTE, [START], STOP)) AS wait_time_mins
FROM dbo.encounters
WHERE STOP >= [START] 
GROUP BY ORGANIZATION
ORDER BY 
  Encounters_Per_Day DESC,  
  wait_time_mins DESC;      



/* 
Q4. What is the net revenue loss per encounter (Total_Claim_Cost - Payer_Coverage) by payer?
 */

select ORGANIZATION,  round(avg(TOTAL_CLAIM_COST - PAYER_COVERAGE),2) as Net_Revenue_Loss 
from dbo.encounters 
group by ORGANIZATION
order by Net_Revenue_Loss DESC


/* 
Q5. Which procedures (Procedures.Description) have the highest average Base_Cost, and how often are they performed?
 */

SELECT 
  p.DESCRIPTION AS Procedure_Name,  
  COUNT(*) AS Procedure_Performed, 
  ROUND(AVG(BASE_COST), 2) AS Avg_Cost 
FROM dbo.procedures p
GROUP BY p.DESCRIPTION
ORDER BY Avg_Cost DESC;


/* 
Q6. What demographic segments (age/gender/race) have the highest encounter frequency for urgent care vs. wellness visits? 
(Use BirthDate for age calculation)
 */

SELECT 
  p.Gender,
  p.Race,
  SUM(CASE WHEN e.EncounterClass = 'urgentcare' THEN 1 ELSE 0 END) AS Urgent_Care_Visits,
  SUM(CASE WHEN e.EncounterClass = 'wellness' THEN 1 ELSE 0 END) AS Wellness_Visits
FROM 
  dbo.encounters e
JOIN 
  dbo.patients p ON e.Patient = p.Id
WHERE 
  e.EncounterClass IN ('urgentcare', 'wellness')
GROUP BY 
  p.Gender, p.Race
ORDER BY 
  Urgent_Care_Visits DESC, Wellness_Visits DESC;


/* 
Q7. Which counties/states (from Patients.County/State) have the highest mortality rates post-encounter?
 */

WITH LastEncounter AS (
    SELECT 
        p.COUNTY,
        p.Id AS PatientID,
        MAX(e.STOP) AS LastEncounterDate,
        p.DEATHDATE
    FROM dbo.patients p
    LEFT JOIN dbo.encounters e
    ON p.Id = e.PATIENT
    WHERE p.DEATHDATE IS NOT NULL 
    GROUP BY p.COUNTY,  p.Id, p.DEATHDATE
),
MortalityRates AS (
    SELECT 
        COUNTY,
        COUNT(*) AS TotalPatients,
        SUM(CASE WHEN DEATHDATE > LastEncounterDate THEN 1 ELSE 0 END) AS DeceasedPatients
    FROM LastEncounter
    GROUP BY COUNTY
)
SELECT 
    COUNTY,
    TotalPatients,
    DeceasedPatients,
    (DeceasedPatients * 100) / TotalPatients AS MortalityRate
FROM MortalityRates
ORDER BY MortalityRate DESC;



---------------------------------------------------------------------------------------------------------------------
-- Percentage Re-Admission within 30 days
WITH re AS (
    SELECT 
        PATIENT, 
        ENCOUNTERCLASS, 
        [START], 
        LAG([START]) OVER (PARTITION BY PATIENT ORDER BY [START]) AS previous_admission_date,
        DATEDIFF(DAY, LAG([START]) OVER (PARTITION BY PATIENT ORDER BY [START]), [START]) AS diff
    FROM dbo.encounters
)
SELECT 
    COUNT(distinct(PATIENT) ) as Re_Admission_within_30_days
FROM re
WHERE diff > 0 AND diff <= 30;


-- Perentage Re-admission within 30 days by encounter class
WITH re AS (
    SELECT 
        PATIENT, 
        ENCOUNTERCLASS, 
        [START], 
        LAG([START]) OVER (PARTITION BY PATIENT ORDER BY [START]) AS previous_admission_date,
        DATEDIFF(DAY, LAG([START]) OVER (PARTITION BY PATIENT ORDER BY [START]), [START]) AS diff
    FROM dbo.encounters
)
SELECT 
   ENCOUNTERCLASS  , COUNT(distinct(PATIENT)) as Re_Admission_within_30_days_Encounter_class
FROM re

WHERE diff > 0 AND diff <= 30
group by ENCOUNTERCLASS;









