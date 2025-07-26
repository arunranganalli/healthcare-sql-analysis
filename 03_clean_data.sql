1-- Creating a clean table for patients with selected columns
    CREATE TABLE patients_clean AS
    SELECT
        id,
        birthdate,
        gender,
        city,
    state,
        healthcare_expenses,
        healthcare_coverage
    FROM patients;
2 --Replace NULL healthcare_coverage with 0
    UPDATE patients_clean
    SET healthcare_coverage = 0
    WHERE healthcare_coverage IS NULL;
3 --Cleaning allergies table:
    CREATE TABLE allergies_clean AS
    SELECT 
        start_date,
        stop_date,
        patient_id,
        allergy_code,
        description
    FROM allergies;
4--Cleaning medications table:
    CREATE TABLE medications_clean AS
    SELECT
        start_date,
        stop_date,
        patient AS patient_id,
        base_cost AS medication_cost,
        description,
        totalcost
    FROM medications;