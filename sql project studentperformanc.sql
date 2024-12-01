CREATE DATABASE performance;
use performance;
show tables;

SELECT * FROM studentperformancefactors;

-- Average exam score by study hours and extracurricular activities
SELECT 
    CASE 
        WHEN sleep_hours < 5 THEN 'Less than 5 hours'
        WHEN sleep_hours BETWEEN 5 AND 7 THEN '5-7 hours'
        WHEN sleep_hours BETWEEN 8 AND 10 THEN '8-10 hours'
        ELSE 'More than 10 hours'
    END AS sleep_hours_range,
    extracurricular_activities,
    AVG(exam_score) AS avg_exam_score
FROM studentperformancefactors
GROUP BY sleep_hours_range, extracurricular_activities
ORDER BY sleep_hours_range, extracurricular_activities;

-- Average exam score by hours studied range
WITH StudyHoursRanges AS (
    SELECT 
        CASE 
            WHEN Hours_Studied BETWEEN 0 AND 10 THEN '0-10'
            WHEN Hours_Studied BETWEEN 11 AND 20 THEN '11-20'
            WHEN Hours_Studied BETWEEN 21 AND 30 THEN '21-30'
            WHEN Hours_Studied BETWEEN 31 AND 40 THEN '31-40'
            WHEN Hours_Studied BETWEEN 41 AND 50 THEN '41-50'
        END AS Study_Hours_Range,
        Exam_Score
    FROM studentperformancefactors
)
SELECT 
    Study_Hours_Range,
    AVG(Exam_Score) AS Average_Exam_Score
FROM StudyHoursRanges
GROUP BY Study_Hours_Range
ORDER BY Study_Hours_Range;

-- Ranking students by exam score
SELECT 
    RANK() OVER (ORDER BY Exam_Score DESC) AS `Rank`,
    Exam_Score,
    Hours_Studied,
    Attendance,
    Extracurricular_Activities,
    Sleep_Hours,
    Tutoring_Sessions,
    Teacher_Quality
FROM studentperformancefactors
ORDER BY `Rank`;
