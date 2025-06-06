USE healthcare;    -- connect to the healthcare database

SELECT * FROM health; -- select all table health

-- 1.	What are the most common age groups, genders, and blood types among patients? Are certain groups being admitted more often than others?
-- Common Age Group
SELECT 
    CASE 
        WHEN Age <= 19 THEN '10-19'
        WHEN Age <= 29 THEN '20-29'
        WHEN Age <=39 THEN '30-39'
        WHEN Age <= 49 THEN '40-49'
        WHEN Age <= 59 THEN '50-59'
        WHEN Age <= 69 THEN '60-69'
        WHEN Age <= 79 THEN '70-79'
		ELSE 'Above 80 '
    END AS Age_Group,
    COUNT(Patient_Id) AS Patient_Count
FROM health
GROUP BY Age_Group
ORDER BY Patient_Count desc;

-- Common Gender
SELECT 
	  Gender,
	COUNT(Patient_ID) AS Patient_Count
FROM health
GROUP BY Gender
ORDER BY Patient_Count;

-- Common Blood Group
SELECT Blood_Type, COUNT(Patient_Id) AS Patient_Count
FROM health
GROUP BY Blood_Type
ORDER BY Patient_Count DESC;


-- 2.	Which medical conditions are diagnosed the most, and do they affect certain groups of people more than others?
-- Medical Codition 
SELECT Medical_Condition, COUNT(Patient_Id) AS Patient_Count
FROM health
GROUP BY Medical_Condition
ORDER By Patient_Count DESC;

-- 3.	How long do patients typically stay in the hospital for different conditions? Does this vary depending on the hospital or type of admission (emergency, urgent, or planned)?
-- Average Lenght of Stay and Average Billing Cycle
SELECT 
    Hospital, 
    AVG(DATEDIFF(Date_of_Discharge, Date_of_Admission)) AS Length_of_Stay,
    ROUND(AVG(Billing_Amount),0) AS Billing_Cycle
FROM health 
GROUP BY  Hospital 
ORDER BY Length_of_Stay DESC 
LIMIT 1000;

-- Medical Condition
SELECT 
    Medical_Condition, 
    AVG(DATEDIFF(Date_of_Discharge, Date_of_Admission)) AS Length_of_Stay,
    ROUND(AVG(Billing_Amount),0) AS Billing_Cycle
FROM health 
GROUP BY  Medical_Condition 
ORDER BY Length_of_Stay DESC 
LIMIT 1000;

-- 4.	How much does treatment usually cost for each condition? Are there big differences in costs between hospitals or insurance providers?
SELECT 
    Insurance_Provider, 
    ROUND(AVG(Billing_Amount),0) AS Avg_Billing_Cycle
FROM health 
GROUP BY Insurance_Provider
ORDER BY Billing_Cycle DESC
LIMIT 1000;

-- Billing Amount Insured by Insurance Provider
SELECT 
    Insurance_Provider, 
    ROUND(SUM(Billing_Amount),0) AS Billing_Cycle
FROM health 
GROUP BY Insurance_Provider
ORDER BY Billing_Cycle DESC 
LIMIT 1000;

-- 5.	Which hospitals are treating the most patients, and how do they compare in terms of patient outcomes, like test results?
-- Hospital with the highest Patient treatment
SELECT Hospital, COUNT(Patient_ID) AS Patient_Count
FROM health
GROUP BY Hospital
ORDER BY Patient_Count DESC;

-- Test Result by Patient
SELECT Test_Result, COUNT(Patient_ID) AS Patient_Count
FROM health
GROUP BY Test_Result
ORDER BY Patient_Count DESC;

-- 6.	What medications are most often prescribed for each condition? Are they being used consistently across hospitals?
SELECT Medication, COUNT(Patient_ID) AS Patient_Count
FROM health
GROUP BY Medication
ORDER BY Patient_Count DESC;

-- 7.	How are patients admitted - mostly through emergency, urgent, or planned admissions - and how does that impact the length of stay or treatment costs?
SELECT 
    Admission_Type, 
    AVG(DATEDIFF(Date_of_Discharge, Date_of_Admission)) AS Length_of_Stay,
    COUNT(Patient_Id) AS Patient_Count
FROM health 
GROUP BY  Admission_Type 
ORDER BY Patient_Count DESC 
LIMIT 1000;

-- 8.	Which insurance companies are covering the most patients, and how does that relate to treatment costs and patient outcomes?
SELECT 
    Insurance_Provider, 
    COUNT(Patient_Id) AS Patient_Count,
    ROUND(SUM(Billing_Amount),0) AS Billing_Cycle
FROM health 
GROUP BY Insurance_Provider
ORDER BY Patient_Count DESC 
LIMIT 1000;