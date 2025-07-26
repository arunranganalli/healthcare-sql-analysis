1 --creating tables for patients
    CREATE TABLE allergies (
    start_date DATE,
    stop_date DATE,
    patient_id TEXT,
    encounter_id TEXT,
    allergy_code TEXT,
    description TEXT);
2 --creating table for allergies
    CREATE TABLE patients (
    id TEXT,
    birthdate DATE,
    gender TEXT,
    city TEXT,
    state TEXT,
    healthcare_expenses NUMERIC,
    healthcare_coverage NUMERIC);
3 --creating table for medications
    CREATE TABLE medications (
    start_date DATE,
    stop_date DATE,
    patient_id TEXT,
    encounter_id TEXT,
    medication_code TEXT,
    description TEXT,
    totalcost NUMERIC);