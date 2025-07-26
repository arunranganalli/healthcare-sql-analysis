1-- Import data into patients table
    copy patients(id, birthdate, gender, city, state, healthcare_expenses, healthcare_coverage)
    FROM '"C:\csv_import\patients.csv"'
    DELIMITER ','
    CSV HEADER;
2-- Import data into allergies table
    copy allergies(start_date, stop_date, patient_id, encounter_id, allergy_code, description)
    FROM 'C:/csv_import/allergies.csv'
    DELIMITER ','
    CSV HEADER;
3-- Import data into medications table
    copy medications(start_date, stop_date, patient_id, encounter_id, medication_code, description, totalcost)
    FROM 'C:/csv_import/medications.csv'
    DELIMITER ','
    CSV HEADER;