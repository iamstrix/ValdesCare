-- ==========================================
-- ValdesCare: Add 20 consultations per patient
-- Range: April 2026
-- ==========================================

DELIMITER //

CREATE PROCEDURE seed_april_2026_data()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE p_id INT;
    DECLARE c_idx INT;
    DECLARE random_physician_id INT;
    DECLARE random_category_id INT;
    DECLARE random_date DATE;
    DECLARE random_time TIME;
    DECLARE start_date DATE DEFAULT '2026-04-01';
    DECLARE days_diff INT DEFAULT 29; -- 30 days in April
    
    -- Cursor to iterate through all patients
    DECLARE cur1 CURSOR FOR SELECT patient_id FROM patient;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur1;

    read_loop: LOOP
        FETCH cur1 INTO p_id;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Generate 20 Consultations for THIS patient
        SET c_idx = 1;
        WHILE c_idx <= 20 DO
            SET random_date = DATE_ADD(start_date, INTERVAL FLOOR(RAND() * days_diff) DAY);
            SET random_time = SEC_TO_TIME(FLOOR(28800 + RAND() * 32400)); -- 8 AM to 5 PM
            
            SELECT physician_id INTO random_physician_id FROM physician ORDER BY RAND() LIMIT 1;
            SELECT category_id INTO random_category_id FROM category ORDER BY RAND() LIMIT 1;

            INSERT INTO consultation (
                patient_id, physician_id, category_id, visit_date, visit_time,
                chief_complaint, symptoms, diagnosis, weight_kg, height_cm, bp_systolic, bp_diastolic,
                temperature_c, pulse_rate, respiratory_rate, oxygen_sat
            ) VALUES (
                p_id,
                random_physician_id,
                random_category_id,
                random_date,
                random_time,
                'Follow-up visit for April clinical check-up.',
                'General observation of symptoms.',
                ELT(FLOOR(1 + RAND() * 6), 'Healthy', 'Flu', 'Allergy', 'Gastroenteritis', 'Hypertension', 'Diabetes Check'),
                FLOOR(45 + RAND() * 60),
                FLOOR(140 + RAND() * 50),
                FLOOR(100 + RAND() * 50),
                FLOOR(60 + RAND() * 40),
                36.0 + (RAND() * 1.8),
                FLOOR(55 + RAND() * 50),
                FLOOR(10 + RAND() * 15),
                FLOOR(92 + RAND() * 8)
            );
            SET c_idx = c_idx + 1;
        END WHILE;

    END LOOP;

    CLOSE cur1;
END //

DELIMITER ;

CALL seed_april_2026_data();
DROP PROCEDURE seed_april_2026_data;
