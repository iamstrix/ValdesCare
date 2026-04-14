-- ==========================================
-- ValdesCare: Reset and Seed Mock Data
-- 10 Patients, Each with 50 Consultations
-- Range: March 2025 - March 2026
-- ==========================================

SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM consultation;
DELETE FROM patient;
DELETE FROM household;
SET FOREIGN_KEY_CHECKS = 1;

DELIMITER //

CREATE PROCEDURE seed_reset_data()
BEGIN
    DECLARE p_idx INT DEFAULT 1;
    DECLARE c_idx INT DEFAULT 1;
    DECLARE current_patient_id INT;
    DECLARE random_hh_id INT;
    DECLARE random_physician_id INT;
    DECLARE random_category_id INT;
    DECLARE random_date DATE;
    DECLARE random_time TIME;
    DECLARE start_date DATE DEFAULT '2025-03-01';
    DECLARE end_date DATE DEFAULT '2026-03-31';
    DECLARE days_diff INT;
    
    SET days_diff = DATEDIFF(end_date, start_date);

    -- Ensure we have physicians and categories
    IF (SELECT COUNT(*) FROM physician) = 0 THEN
        INSERT INTO physician (first_name, last_name, specialty) VALUES ('John', 'Doe', 'General Medicine');
    END IF;
    
    IF (SELECT COUNT(*) FROM category) = 0 THEN
        INSERT INTO category (name) VALUES ('General');
    END IF;

    -- Generate 10 Patients
    WHILE p_idx <= 10 DO
        -- Create a household for each or some patients
        INSERT INTO household (barangay, street_address, municipality) 
        VALUES (
            ELT(FLOOR(1 + RAND() * 3), 'Barangay A', 'Barangay B', 'Barangay C'),
            CONCAT(FLOOR(1 + RAND() * 999), ' Main St'),
            'Valdes City'
        );
        SET random_hh_id = LAST_INSERT_ID();

        INSERT INTO patient (household_id, first_name, last_name, dob, sex, school_status)
        VALUES (
            random_hh_id,
            ELT(FLOOR(1 + RAND() * 10), 'James', 'Mary', 'Robert', 'Patricia', 'John', 'Jennifer', 'Michael', 'Linda', 'William', 'Elizabeth'),
            ELT(FLOOR(1 + RAND() * 10), 'Smith', 'Johnson', 'Williams', 'Brown', 'Jones', 'Garcia', 'Miller', 'Davis', 'Rodriguez', 'Martinez'),
            DATE_ADD('1970-01-01', INTERVAL FLOOR(RAND() * 18250) DAY), -- Random age
            ELT(FLOOR(1 + RAND() * 2), 'Male', 'Female'),
            'Not Applicable'
        );
        SET current_patient_id = LAST_INSERT_ID();

        -- Generate 50 Consultations for THIS patient
        SET c_idx = 1;
        WHILE c_idx <= 50 DO
            SET random_date = DATE_ADD(start_date, INTERVAL FLOOR(RAND() * days_diff) DAY);
            SET random_time = SEC_TO_TIME(FLOOR(28800 + RAND() * 32400)); -- 8 AM to 5 PM
            
            SELECT physician_id INTO random_physician_id FROM physician ORDER BY RAND() LIMIT 1;
            SELECT category_id INTO random_category_id FROM category ORDER BY RAND() LIMIT 1;

            INSERT INTO consultation (
                patient_id, physician_id, category_id, visit_date, visit_time,
                chief_complaint, diagnosis, weight_kg, height_cm, bp_systolic, bp_diastolic,
                temperature_c, pulse_rate, respiratory_rate, oxygen_sat
            ) VALUES (
                current_patient_id,
                random_physician_id,
                random_category_id,
                random_date,
                random_time,
                'Routine check-up / Follow-up observation.',
                ELT(FLOOR(1 + RAND() * 5), 'Healthy', 'Mild Fever', 'Cough', 'Seasonal Allergy', 'Hypertension'),
                FLOOR(50 + RAND() * 50),
                FLOOR(150 + RAND() * 40),
                FLOOR(110 + RAND() * 30),
                FLOOR(70 + RAND() * 20),
                36.5 + (RAND() * 1.5),
                FLOOR(60 + RAND() * 40),
                FLOOR(12 + RAND() * 8),
                FLOOR(95 + RAND() * 5)
            );
            SET c_idx = c_idx + 1;
        END WHILE;

        SET p_idx = p_idx + 1;
    END WHILE;
END //

DELIMITER ;

CALL seed_reset_data();
DROP PROCEDURE seed_reset_data;
