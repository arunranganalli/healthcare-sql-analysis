-- Our data is now clean! Let’s dive in and uncover meaningful insights from real-world healthcare data through SQL magic.
--1️⃣ Most common allergies: (top 10)
    SELECT description AS allergy, COUNT(*) AS total_cases
    FROM allergies_clean
    GROUP BY description
    ORDER BY total_cases DESC
    LIMIT 10;
 -- Result:
    | Allergy                        | Total Cases |
    |--------------------------------|-------------|
    | Allergy to mould               | 162         |
    | Dander (animal) allergy        | 154         |
    | Allergy to tree pollen         | 126         |
    | House dust mite allergy        | 122         |
    | Allergy to grass pollen        | 120         |
    | Shellfish allergy              | 82          |
    | Allergy to bee venom           | 66          |
    | Allergy to nut                 | 62          |
    | Allergy to fish                | 60          |
    | Allergy to peanuts             | 50          |
--2️⃣ Number of patients by city: (top 10)
    SELECT city, COUNT(*) AS patient_count
    FROM patients_clean
    GROUP BY city
    ORDER BY patient_count DESC
    LIMIT 10;
 -- Result:
    | City         | Patient Count |
    |--------------|---------------|
    | Boston       | 116           |
    | Worcester    | 31            |
    | Cambridge    | 27            |
    | Springfield  | 23            |
    | Quincy       | 20            |
    | Fall River   | 19            |
    | Lynn         | 18            |
    | Lowell       | 18            |
    | New Bedford  | 17            |
    | Waltham      | 16            |
--3️⃣ Average medication cost: (top 10)
    SELECT description AS medication,
       ROUND(AVG(totalcost), 2) AS avg_cost
    FROM medications_clean
    GROUP BY description
    ORDER BY avg_cost DESC
    LIMIT 10;
 -- Result:
    | Medication                                                        | Avg Cost   |
    |-------------------------------------------------------------------|------------|
    | Acetaminophen/Hydrocodone                                         | 176,274.81 |
    | 10 ML oxaliplatin 5 MG/ML Injection                               | 164,337.95 |
    | Sertraline 100 MG Oral Tablet                                     | 154,317.31 |
    | Tacrine 10 MG Oral Capsule                                        | 142,050.73 |
    | 24hr nicotine transdermal patch                                   | 112,472.59 |
    | Vitamin B 12 5 MG/ML Injectable Solution                          | 96,283.22  |
    | ferrous sulfate 325 MG Oral Tablet                                | 80,297.05  |
    | Acetaminophen 325 MG / oxyCODONE Hydrochloride 5 MG Oral Tablet   | 66,596.19  |
    | NDA020800 0.3 ML Epinephrine 1 MG/ML Auto-Injector                | 66,446.36  |
    | FLUoxetine 20 MG Oral Capsule                                     | 46,868.28  |
--4️⃣ Overall allergy distribution per city (top 10)
    SELECT 
        p.city,
        a.description AS allergy,
        COUNT(*) AS total_cases
    FROM allergies_clean AS a
    JOIN patients_clean AS p
        ON a.patient_ID = p.id
    GROUP BY p.city, a.description
    ORDER BY total_cases DESC
    LIMIT 10
 -- Result:
    | City      | Allergy                     | Total Cases |
    |-----------|-----------------------------|--------------|
    | Boston    | Dander (animal) allergy     | 18           |
    | Boston    | House dust mite allergy     | 18           |
    | Boston    | Allergy to mould            | 18           |
    | Boston    | Allergy to tree pollen      | 16           |
    | Boston    | Allergy to grass pollen     | 16           |
    | Boston    | Latex allergy               | 8            |
    | Boston    | Allergy to wheat            | 8            |
    | Quincy    | Shellfish allergy           | 6            |
    | Boston    | Allergy to bee venom        | 6            |
    | Boston    | Allergy to nut              | 6            |
--5️⃣Frequently used medications
    SELECT allergy, medication, times_prescribed
    FROM (SELECT
            a.description AS allergy,
            m.description AS medication,
            COUNT(*) AS times_prescribed,
            ROW_NUMBER() OVER (PARTITION BY a.description ORDER BY COUNT(*) DESC) AS rn
        FROM allergies_clean AS a
        JOIN medications_clean AS m
            ON a.patient_id = m.patient_id
        WHERE a.description IN (
            'Allergy to mould',
            'Dander (animal) allergy',
            'Allergy to tree pollen',
            'House dust mite allergy',
            'Allergy to grass pollen'
        )
        GROUP BY a.description, m.description) AS ranked
    WHERE rn = 1
    ORDER BY times_prescribed DESC;
 -- Result:
    | Allergy                     | Medication                                                                 | Times Prescribed |
    |----------------------------|---------------------------------------------------------------------------|-----------------|
    | Dander (animal) allergy    | 120 ACTUAT Fluticasone propionate 0.044 MG/ACTUAT Metered Dose Inhaler    | 1774            |
    | Allergy to mould           | NDA020503 200 ACTUAT Albuterol 0.09 MG/ACTUAT Metered Dose Inhaler        | 1766            |
    | Allergy to tree pollen     | NDA020503 200 ACTUAT Albuterol 0.09 MG/ACTUAT Metered Dose Inhaler        | 1458            |
    | Allergy to grass pollen    | NDA020503 200 ACTUAT Albuterol 0.09 MG/ACTUAT Metered Dose Inhaler        | 1396            |
    | House dust mite allergy    | NDA020503 200 ACTUAT Albuterol 0.09 MG/ACTUAT Metered Dose Inhaler        | 1334            |
--6️⃣Top 10 Medications by Average Cost
    SELECT 
        description AS medication,
        ROUND(AVG(totalcost), 2) AS avg_cost
    FROM medications_clean
    GROUP BY description
    ORDER BY avg_cost DESC
    LIMIT 10;
 -- Result:
    | S.No | Medication                                                           | Avg Cost    |
    |------|----------------------------------------------------------------------|-------------|
    | 1 | Sertraline 100 MG Oral Tablet                                          | 154,317.31  |
    | 2 | Tacrine 10 MG Oral Capsule                                             | 142,050.73  |
    | 3 | 24hr nicotine transdermal patch                                        | 112,472.59  |
    | 4 | Vitamin B 12 5 MG/ML Injectable Solution                               | 96,283.22   |
    | 5 | Ferrous sulfate 325 MG Oral Tablet                                     | 80,297.05   |
    | 6 | Acetaminophen 325 MG / oxyCODONE Hydrochloride 5 MG Oral Tablet        | 66,596.19   |
    | 7 | NDA020800 0.3 ML Epinephrine 1 MG/ML Auto-Injector                     | 66,446.36   |
    | 8 | FLUoxetine 20 MG Oral Capsule                                          | 46,868.28   |
