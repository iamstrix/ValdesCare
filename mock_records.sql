-- ValdesCare Mock Data Generator
-- Generated for Period: Dec 14, 2025 to April 14, 2026

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE consultation;
TRUNCATE TABLE patient;
TRUNCATE TABLE physician;
SET FOREIGN_KEY_CHECKS = 1;

-- Seed Mock Physicians
INSERT INTO physician (first_name, last_name, specialty, is_active) VALUES 
('Emiliano', 'Valdes', 'Internal Medicine', 1),
('Fe', 'Mundo', 'Pediatrics', 1),
('Jose', 'Perez', 'General Medicine', 1);

INSERT INTO patient (household_no, patient_name, dob, age_group, sex, address, mobile_no, relationship_to_head, is_ip, nhts_status, is_philhealth_member, philhealth_no, philhealth_category, school_status) VALUES ('HH-098', 'Juan Dela Cruz', '1972-04-14', 'Adult', 'Male', '123 Rizal St., Brgy. San Jose, Valdes City', '09641666004', 'Head', 'No', 'NON-NHTS', 'Yes', '7956631093', 'Indigent', 'Not in School');
INSERT INTO patient (household_no, patient_name, dob, age_group, sex, address, mobile_no, relationship_to_head, is_ip, nhts_status, is_philhealth_member, philhealth_no, philhealth_category, school_status) VALUES ('HH-061', 'Maria Clara', '1970-04-14', 'Adult', 'Female', '789 Mabini St., Brgy. San Nicolas, Valdes City', '09968260347', 'Head', 'No', 'NON-NHTS', 'Yes', '1297315273', 'Indigent', 'Not in School');
INSERT INTO patient (household_no, patient_name, dob, age_group, sex, address, mobile_no, relationship_to_head, is_ip, nhts_status, is_philhealth_member, philhealth_no, philhealth_category, school_status) VALUES ('HH-005', 'Jose Rizal Santos', '1984-04-14', 'Adult', 'Female', '456 Bonifacio Ave., Brgy. Sto. Rosario, Valdes City', '09295144963', 'Head', 'No', 'NON-NHTS', 'No', '', NULL, 'Not in School');
INSERT INTO patient (household_no, patient_name, dob, age_group, sex, address, mobile_no, relationship_to_head, is_ip, nhts_status, is_philhealth_member, philhealth_no, philhealth_category, school_status) VALUES ('HH-080', 'Andres Bonifacio', '2007-04-14', 'Adult', 'Male', '123 Rizal St., Brgy. San Jose, Valdes City', '09168562538', 'Head', 'Yes', 'NON-NHTS', 'No', '', NULL, 'Not in School');
INSERT INTO patient (household_no, patient_name, dob, age_group, sex, address, mobile_no, relationship_to_head, is_ip, nhts_status, is_philhealth_member, philhealth_no, philhealth_category, school_status) VALUES ('HH-036', 'Emilio Aguinaldo', '1992-04-14', 'Adult', 'Female', '789 Mabini St., Brgy. San Nicolas, Valdes City', '09244861381', 'Head', 'No', 'NHTS', 'Yes', '9738029323', 'Indigent', 'Not in School');
INSERT INTO patient (household_no, patient_name, dob, age_group, sex, address, mobile_no, relationship_to_head, is_ip, nhts_status, is_philhealth_member, philhealth_no, philhealth_category, school_status) VALUES ('HH-003', 'Apolinario Mabini', '1985-04-14', 'Adult', 'Female', '456 Bonifacio Ave., Brgy. Sto. Rosario, Valdes City', '09357421779', 'Head', 'No', 'NON-NHTS', 'Yes', '4270296681', 'Indigent', 'Not in School');
INSERT INTO patient (household_no, patient_name, dob, age_group, sex, address, mobile_no, relationship_to_head, is_ip, nhts_status, is_philhealth_member, philhealth_no, philhealth_category, school_status) VALUES ('HH-080', 'Gabriela Silang', '1995-04-14', 'Adult', 'Male', '101 Luna St., Brgy. Cutcut, Valdes City', '09960984593', 'Head', 'No', 'NON-NHTS', 'Yes', '9440864922', 'Indigent', 'Not in School');
INSERT INTO patient (household_no, patient_name, dob, age_group, sex, address, mobile_no, relationship_to_head, is_ip, nhts_status, is_philhealth_member, philhealth_no, philhealth_category, school_status) VALUES ('HH-012', 'Melchora Aquino', '1967-04-14', 'Adult', 'Female', '456 Bonifacio Ave., Brgy. Sto. Rosario, Valdes City', '09909324136', 'Head', 'Yes', 'NON-NHTS', 'Yes', '5326608883', 'Indigent', 'Not in School');
INSERT INTO patient (household_no, patient_name, dob, age_group, sex, address, mobile_no, relationship_to_head, is_ip, nhts_status, is_philhealth_member, philhealth_no, philhealth_category, school_status) VALUES ('HH-036', 'Marcelo H. Del Pilar', '1956-04-14', 'Geriatric', 'Female', '101 Luna St., Brgy. Cutcut, Valdes City', '09671303071', 'Head', 'No', 'NHTS', 'Yes', '5348107789', 'Indigent', 'Not in School');
INSERT INTO patient (household_no, patient_name, dob, age_group, sex, address, mobile_no, relationship_to_head, is_ip, nhts_status, is_philhealth_member, philhealth_no, philhealth_category, school_status) VALUES ('HH-038', 'Gregorio Del Pilar', '1991-04-14', 'Adult', 'Female', '456 Bonifacio Ave., Brgy. Sto. Rosario, Valdes City', '09991327088', 'Head', 'Yes', 'NON-NHTS', 'No', '', NULL, 'Not in School');
INSERT INTO patient (household_no, patient_name, dob, age_group, sex, address, mobile_no, relationship_to_head, is_ip, nhts_status, is_philhealth_member, philhealth_no, philhealth_category, school_status) VALUES ('HH-089', 'Emilio Jacinto', '1969-04-14', 'Adult', 'Male', '789 Mabini St., Brgy. San Nicolas, Valdes City', '09804052784', 'Head', 'No', 'NHTS', 'No', '', NULL, 'Not in School');
INSERT INTO patient (household_no, patient_name, dob, age_group, sex, address, mobile_no, relationship_to_head, is_ip, nhts_status, is_philhealth_member, philhealth_no, philhealth_category, school_status) VALUES ('HH-012', 'Antonio Luna', '1997-04-14', 'Adult', 'Male', '123 Rizal St., Brgy. San Jose, Valdes City', '09389535613', 'Head', 'No', 'NHTS', 'Yes', '5166024643', 'Indigent', 'Not in School');
INSERT INTO patient (household_no, patient_name, dob, age_group, sex, address, mobile_no, relationship_to_head, is_ip, nhts_status, is_philhealth_member, philhealth_no, philhealth_category, school_status) VALUES ('HH-043', 'Juan Luna', '1970-04-14', 'Adult', 'Male', '789 Mabini St., Brgy. San Nicolas, Valdes City', '09349909620', 'Head', 'No', 'NHTS', 'Yes', '7863766090', 'Indigent', 'Not in School');
INSERT INTO patient (household_no, patient_name, dob, age_group, sex, address, mobile_no, relationship_to_head, is_ip, nhts_status, is_philhealth_member, philhealth_no, philhealth_category, school_status) VALUES ('HH-045', 'Lapu-Lapu', '1956-04-14', 'Geriatric', 'Male', '456 Bonifacio Ave., Brgy. Sto. Rosario, Valdes City', '09433569965', 'Head', 'No', 'NHTS', 'Yes', '9809575739', 'Indigent', 'Not in School');
INSERT INTO patient (household_no, patient_name, dob, age_group, sex, address, mobile_no, relationship_to_head, is_ip, nhts_status, is_philhealth_member, philhealth_no, philhealth_category, school_status) VALUES ('HH-040', 'Diego Silang', '1993-04-14', 'Adult', 'Male', '456 Bonifacio Ave., Brgy. Sto. Rosario, Valdes City', '09445753593', 'Head', 'No', 'NON-NHTS', 'Yes', '1293136280', 'Indigent', 'Not in School');
INSERT INTO patient (household_no, patient_name, dob, age_group, sex, address, mobile_no, relationship_to_head, is_ip, nhts_status, is_philhealth_member, philhealth_no, philhealth_category, school_status) VALUES ('HH-045', 'Miguel Malvar', '1988-04-14', 'Adult', 'Female', '456 Bonifacio Ave., Brgy. Sto. Rosario, Valdes City', '09505111590', 'Head', 'No', 'NHTS', 'Yes', '2909671030', 'Indigent', 'Not in School');
INSERT INTO patient (household_no, patient_name, dob, age_group, sex, address, mobile_no, relationship_to_head, is_ip, nhts_status, is_philhealth_member, philhealth_no, philhealth_category, school_status) VALUES ('HH-021', 'Macario Sakay', '1969-04-14', 'Adult', 'Male', '123 Rizal St., Brgy. San Jose, Valdes City', '09936498582', 'Head', 'Yes', 'NHTS', 'Yes', '3838256467', 'Indigent', 'Not in School');
INSERT INTO patient (household_no, patient_name, dob, age_group, sex, address, mobile_no, relationship_to_head, is_ip, nhts_status, is_philhealth_member, philhealth_no, philhealth_category, school_status) VALUES ('HH-054', 'Teresa Magbanua', '2006-04-14', 'Adult', 'Female', '101 Luna St., Brgy. Cutcut, Valdes City', '09836590561', 'Head', 'No', 'NON-NHTS', 'No', '', NULL, 'Not in School');
INSERT INTO patient (household_no, patient_name, dob, age_group, sex, address, mobile_no, relationship_to_head, is_ip, nhts_status, is_philhealth_member, philhealth_no, philhealth_category, school_status) VALUES ('HH-026', 'Josefa Llanes Escoda', '1995-04-14', 'Adult', 'Male', '101 Luna St., Brgy. Cutcut, Valdes City', '09209402311', 'Head', 'No', 'NON-NHTS', 'Yes', '8560165115', 'Indigent', 'Not in School');
INSERT INTO patient (household_no, patient_name, dob, age_group, sex, address, mobile_no, relationship_to_head, is_ip, nhts_status, is_philhealth_member, philhealth_no, philhealth_category, school_status) VALUES ('HH-048', 'Vicente Lim', '1953-04-14', 'Geriatric', 'Female', '456 Bonifacio Ave., Brgy. Sto. Rosario, Valdes City', '09763797724', 'Head', 'No', 'NON-NHTS', 'Yes', '4155741758', 'Indigent', 'Not in School');
INSERT INTO patient (household_no, patient_name, dob, age_group, sex, address, mobile_no, relationship_to_head, is_ip, nhts_status, is_philhealth_member, philhealth_no, philhealth_category, school_status) VALUES ('HH-080', 'Ramon Magsaysay', '2014-04-14', 'Pediatric', 'Male', '123 Rizal St., Brgy. San Jose, Valdes City', '09427283232', 'Head', 'No', 'NON-NHTS', 'No', '', NULL, 'Not in School');
INSERT INTO patient (household_no, patient_name, dob, age_group, sex, address, mobile_no, relationship_to_head, is_ip, nhts_status, is_philhealth_member, philhealth_no, philhealth_category, school_status) VALUES ('HH-084', 'Ferdinand Marcos', '2016-04-14', 'Pediatric', 'Male', '123 Rizal St., Brgy. San Jose, Valdes City', '09649244544', 'Head', 'No', 'NON-NHTS', 'No', '', NULL, 'Not in School');
INSERT INTO patient (household_no, patient_name, dob, age_group, sex, address, mobile_no, relationship_to_head, is_ip, nhts_status, is_philhealth_member, philhealth_no, philhealth_category, school_status) VALUES ('HH-021', 'Corazon Aquino', '1996-04-14', 'Adult', 'Male', '456 Bonifacio Ave., Brgy. Sto. Rosario, Valdes City', '09746777354', 'Head', 'Yes', 'NHTS', 'No', '', NULL, 'Not in School');
INSERT INTO patient (household_no, patient_name, dob, age_group, sex, address, mobile_no, relationship_to_head, is_ip, nhts_status, is_philhealth_member, philhealth_no, philhealth_category, school_status) VALUES ('HH-044', 'Fidel Ramos', '1969-04-14', 'Adult', 'Female', '123 Rizal St., Brgy. San Jose, Valdes City', '09211834514', 'Head', 'No', 'NON-NHTS', 'Yes', '5703322504', 'Indigent', 'Not in School');
INSERT INTO patient (household_no, patient_name, dob, age_group, sex, address, mobile_no, relationship_to_head, is_ip, nhts_status, is_philhealth_member, philhealth_no, philhealth_category, school_status) VALUES ('HH-032', 'Joseph Estrada', '1997-04-14', 'Adult', 'Female', '101 Luna St., Brgy. Cutcut, Valdes City', '09597435719', 'Head', 'No', 'NHTS', 'Yes', '8831269630', 'Indigent', 'Not in School');
INSERT INTO patient (household_no, patient_name, dob, age_group, sex, address, mobile_no, relationship_to_head, is_ip, nhts_status, is_philhealth_member, philhealth_no, philhealth_category, school_status) VALUES ('HH-014', 'Gloria Macapagal-Arroyo', '2005-04-14', 'Adult', 'Female', '789 Mabini St., Brgy. San Nicolas, Valdes City', '09240106359', 'Head', 'No', 'NON-NHTS', 'Yes', '3613464951', 'Indigent', 'Not in School');
INSERT INTO patient (household_no, patient_name, dob, age_group, sex, address, mobile_no, relationship_to_head, is_ip, nhts_status, is_philhealth_member, philhealth_no, philhealth_category, school_status) VALUES ('HH-001', 'Benigno Aquino III', '1962-04-14', 'Geriatric', 'Female', '789 Mabini St., Brgy. San Nicolas, Valdes City', '09518958869', 'Head', 'Yes', 'NHTS', 'Yes', '3734693925', 'Indigent', 'Not in School');
INSERT INTO patient (household_no, patient_name, dob, age_group, sex, address, mobile_no, relationship_to_head, is_ip, nhts_status, is_philhealth_member, philhealth_no, philhealth_category, school_status) VALUES ('HH-004', 'Rodrigo Duterte', '1998-04-14', 'Adult', 'Female', '101 Luna St., Brgy. Cutcut, Valdes City', '09934388157', 'Head', 'No', 'NON-NHTS', 'No', '', NULL, 'Not in School');
INSERT INTO patient (household_no, patient_name, dob, age_group, sex, address, mobile_no, relationship_to_head, is_ip, nhts_status, is_philhealth_member, philhealth_no, philhealth_category, school_status) VALUES ('HH-049', 'Leni Robredo', '1998-04-14', 'Adult', 'Male', '456 Bonifacio Ave., Brgy. Sto. Rosario, Valdes City', '09237382289', 'Head', 'No', 'NON-NHTS', 'No', '', NULL, 'Not in School');
INSERT INTO patient (household_no, patient_name, dob, age_group, sex, address, mobile_no, relationship_to_head, is_ip, nhts_status, is_philhealth_member, philhealth_no, philhealth_category, school_status) VALUES ('HH-049', 'Manny Pacquiao', '1953-04-14', 'Geriatric', 'Male', '456 Bonifacio Ave., Brgy. Sto. Rosario, Valdes City', '09703548586', 'Head', 'No', 'NON-NHTS', 'Yes', '5222905043', 'Indigent', 'Not in School');

-- Generating progression records...
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(1, '2025-12-15', 'Sneezing, runny nose, mild throat itchiness', 'Prescribed Cetirizine 10mg OD. Vitamin C 500mg. Drink plenty of water.', 'Likely viral upper respiratory infection. Rest advised.', 3),
(1, '2025-12-19', 'Follow-up visit. Sneezing, runny nose, mild throat itchiness', 'Prescribed Cetirizine 10mg OD. Vitamin C 500mg. Drink plenty of water.', 'Continuous tracking. Likely viral upper respiratory infection. Rest advised.', 3),
(1, '2025-12-22', 'Sneezing, runny nose, mild throat itchiness', 'Prescribed Cetirizine 10mg OD. Vitamin C 500mg. Drink plenty of water.', 'Likely viral upper respiratory infection. Rest advised.', 2),
(1, '2026-01-01', 'Follow-up visit. Sneezing, runny nose, mild throat itchiness', 'Prescribed Cetirizine 10mg OD. Vitamin C 500mg. Drink plenty of water.', 'Continuous tracking. Likely viral upper respiratory infection. Rest advised.', 3),
(1, '2026-01-02', 'Slight dry cough, no fever', 'Continue Vitamin C. Added Ambroxol 30mg TID for cough.', 'Patient feels slightly better.', 2),
(1, '2026-01-13', 'Follow-up visit. Slight dry cough, no fever', 'Continue Vitamin C. Added Ambroxol 30mg TID for cough.', 'Continuous tracking. Patient feels slightly better.', 1),
(1, '2026-01-16', 'Slight dry cough, no fever', 'Continue Vitamin C. Added Ambroxol 30mg TID for cough.', 'Patient feels slightly better.', 1),
(1, '2026-01-17', 'Follow-up visit. No symptoms. Routine vitamin refill', 'Refilled Multivitamins.', 'Continuous tracking. Recovery complete.', 3),
(1, '2026-01-19', 'No symptoms. Routine vitamin refill', 'Refilled Multivitamins.', 'Recovery complete.', 1),
(1, '2026-01-30', 'Follow-up visit. No symptoms. Routine vitamin refill', 'Refilled Multivitamins.', 'Continuous tracking. Recovery complete.', 1);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(1, '2026-02-03', 'Recurrence of symptoms after rainy travel: Feverish, sore throat', 'Paracetamol 500mg PRN. Gargle with warm salt water.', 'New episode of viral flu.', 2),
(1, '2026-02-06', 'Follow-up visit. Recurrence of symptoms after rainy travel: Feverish, sore throat', 'Paracetamol 500mg PRN. Gargle with warm salt water.', 'Continuous tracking. New episode of viral flu.', 2),
(1, '2026-02-13', 'Recurrence of symptoms after rainy travel: Feverish, sore throat', 'Paracetamol 500mg PRN. Gargle with warm salt water.', 'New episode of viral flu.', 2),
(1, '2026-02-24', 'Follow-up visit. Recurrence of symptoms after rainy travel: Feverish, sore throat', 'Paracetamol 500mg PRN. Gargle with warm salt water.', 'Continuous tracking. New episode of viral flu.', 2),
(1, '2026-02-26', 'Productive cough, yellowish phlegm', 'Amoxicillin 500mg TID for 7 days. Continue hydration.', 'Suspected mild secondary bacterial infection.', 2),
(1, '2026-02-27', 'Follow-up visit. Productive cough, yellowish phlegm', 'Amoxicillin 500mg TID for 7 days. Continue hydration.', 'Continuous tracking. Suspected mild secondary bacterial infection.', 3),
(1, '2026-03-03', 'Productive cough, yellowish phlegm', 'Amoxicillin 500mg TID for 7 days. Continue hydration.', 'Suspected mild secondary bacterial infection.', 3),
(1, '2026-03-03', 'Follow-up visit. Cough improving, still feels weak', 'Continue Antibiotics. Rest.', 'Continuous tracking. Compliance is good.', 1),
(1, '2026-03-04', 'Cough improving, still feels weak', 'Continue Antibiotics. Rest.', 'Compliance is good.', 3),
(1, '2026-03-04', 'Follow-up visit. Cough improving, still feels weak', 'Continue Antibiotics. Rest.', 'Continuous tracking. Compliance is good.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(1, '2026-03-08', 'Resolved. Throat clear.', 'Vitamins only.', 'Back to healthy baseline.', 3),
(1, '2026-03-17', 'Follow-up visit. Resolved. Throat clear.', 'Vitamins only.', 'Continuous tracking. Back to healthy baseline.', 2),
(1, '2026-03-18', 'Resolved. Throat clear.', 'Vitamins only.', 'Back to healthy baseline.', 1),
(1, '2026-03-18', 'Follow-up visit. Resolved. Throat clear.', 'Vitamins only.', 'Continuous tracking. Back to healthy baseline.', 2),
(1, '2026-03-22', 'Minor nasal congestion due to allergens', 'Loratadine 10mg OD.', 'Seasonal allergy management.', 1),
(1, '2026-04-01', 'Follow-up visit. Minor nasal congestion due to allergens', 'Loratadine 10mg OD.', 'Continuous tracking. Seasonal allergy management.', 2),
(1, '2026-04-03', 'Minor nasal congestion due to allergens', 'Loratadine 10mg OD.', 'Seasonal allergy management.', 2),
(1, '2026-04-06', 'Follow-up visit. Stable. Feeling well.', 'None.', 'Continuous tracking. Fully asymptomatic.', 2),
(1, '2026-04-06', 'Stable. Feeling well.', 'None.', 'Fully asymptomatic.', 2),
(1, '2026-04-09', 'Follow-up visit. Stable. Feeling well.', 'None.', 'Continuous tracking. Fully asymptomatic.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(1, '2026-04-10', 'Routine visit. Clean bill of health.', 'Stay hydrated.', 'Patient educated on flu prevention.', 3),
(1, '2026-04-11', 'Follow-up visit. Routine visit. Clean bill of health.', 'Stay hydrated.', 'Continuous tracking. Patient educated on flu prevention.', 3),
(1, '2026-04-13', 'Routine visit. Clean bill of health.', 'Stay hydrated.', 'Patient educated on flu prevention.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(2, '2025-12-24', 'BP 150/90. Occasional nape pain after salty meals.', 'Amlodipine 5mg OD. Advised low-salt, low-fat diet.', 'Stage 1 Hypertension. OPD monitoring.', 1),
(2, '2025-12-24', 'Follow-up visit. BP 150/90. Occasional nape pain after salty meals.', 'Amlodipine 5mg OD. Advised low-salt, low-fat diet.', 'Continuous tracking. Stage 1 Hypertension. OPD monitoring.', 3),
(2, '2025-12-26', 'BP 150/90. Occasional nape pain after salty meals.', 'Amlodipine 5mg OD. Advised low-salt, low-fat diet.', 'Stage 1 Hypertension. OPD monitoring.', 2),
(2, '2025-12-28', 'Follow-up visit. BP 150/90. Occasional nape pain after salty meals.', 'Amlodipine 5mg OD. Advised low-salt, low-fat diet.', 'Continuous tracking. Stage 1 Hypertension. OPD monitoring.', 3),
(2, '2026-01-01', 'BP 150/90. Occasional nape pain after salty meals.', 'Amlodipine 5mg OD. Advised low-salt, low-fat diet.', 'Stage 1 Hypertension. OPD monitoring.', 2),
(2, '2026-01-07', 'Follow-up visit. BP 140/85. Nape pain reduced.', 'Continue Amlodipine. Provided diet chart.', 'Continuous tracking. Stabilizing. Patient compliant.', 1),
(2, '2026-01-08', 'BP 140/85. Nape pain reduced.', 'Continue Amlodipine. Provided diet chart.', 'Stabilizing. Patient compliant.', 2),
(2, '2026-01-16', 'Follow-up visit. BP 140/85. Nape pain reduced.', 'Continue Amlodipine. Provided diet chart.', 'Continuous tracking. Stabilizing. Patient compliant.', 2),
(2, '2026-01-17', 'BP 140/85. Nape pain reduced.', 'Continue Amlodipine. Provided diet chart.', 'Stabilizing. Patient compliant.', 2),
(2, '2026-01-20', 'Follow-up visit. BP 130/80. No complaints.', 'Maintain current meds.', 'Continuous tracking. Excellent BP control.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(2, '2026-01-22', 'BP 130/80. No complaints.', 'Maintain current meds.', 'Excellent BP control.', 3),
(2, '2026-01-27', 'Follow-up visit. BP 130/80. No complaints.', 'Maintain current meds.', 'Continuous tracking. Excellent BP control.', 1),
(2, '2026-01-29', 'BP 130/80. No complaints.', 'Maintain current meds.', 'Excellent BP control.', 1),
(2, '2026-01-30', 'Follow-up visit. BP 145/90. Reported eating at a fiesta.', 'Counseling on diet during holidays. Maintain meds.', 'Continuous tracking. Lifestyle-induced BP spike.', 3),
(2, '2026-02-01', 'BP 145/90. Reported eating at a fiesta.', 'Counseling on diet during holidays. Maintain meds.', 'Lifestyle-induced BP spike.', 3),
(2, '2026-02-07', 'Follow-up visit. BP 145/90. Reported eating at a fiesta.', 'Counseling on diet during holidays. Maintain meds.', 'Continuous tracking. Lifestyle-induced BP spike.', 1),
(2, '2026-02-08', 'BP 145/90. Reported eating at a fiesta.', 'Counseling on diet during holidays. Maintain meds.', 'Lifestyle-induced BP spike.', 1),
(2, '2026-02-08', 'Follow-up visit. BP 135/85. Feeling better.', 'Continue Amlodipine.', 'Continuous tracking. Return to baseline.', 3),
(2, '2026-02-19', 'BP 135/85. Feeling better.', 'Continue Amlodipine.', 'Return to baseline.', 3),
(2, '2026-02-21', 'Follow-up visit. BP 135/85. Feeling better.', 'Continue Amlodipine.', 'Continuous tracking. Return to baseline.', 1);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(2, '2026-02-22', 'BP 135/85. Feeling better.', 'Continue Amlodipine.', 'Return to baseline.', 3),
(2, '2026-02-22', 'Follow-up visit. BP 125/80. No dizziness.', 'Prescription refill for 2 months.', 'Continuous tracking. Stable maintenance.', 3),
(2, '2026-02-25', 'BP 125/80. No dizziness.', 'Prescription refill for 2 months.', 'Stable maintenance.', 2),
(2, '2026-02-25', 'Follow-up visit. BP 125/80. No dizziness.', 'Prescription refill for 2 months.', 'Continuous tracking. Stable maintenance.', 2),
(2, '2026-03-01', 'BP 125/80. No dizziness.', 'Prescription refill for 2 months.', 'Stable maintenance.', 1),
(2, '2026-03-02', 'Follow-up visit. BP 120/80. Weight down by 1kg.', 'Encouraged walking 30 mins daily.', 'Continuous tracking. Good progress with exercise.', 1),
(2, '2026-03-06', 'BP 120/80. Weight down by 1kg.', 'Encouraged walking 30 mins daily.', 'Good progress with exercise.', 3),
(2, '2026-03-07', 'Follow-up visit. BP 120/80. Weight down by 1kg.', 'Encouraged walking 30 mins daily.', 'Continuous tracking. Good progress with exercise.', 1),
(2, '2026-03-14', 'BP 120/80. Weight down by 1kg.', 'Encouraged walking 30 mins daily.', 'Good progress with exercise.', 2),
(2, '2026-03-15', 'Follow-up visit. BP 128/82. Routine checkup.', 'None.', 'Continuous tracking. Still within target range.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(2, '2026-03-22', 'BP 128/82. Routine checkup.', 'None.', 'Still within target range.', 2),
(2, '2026-03-24', 'Follow-up visit. BP 128/82. Routine checkup.', 'None.', 'Continuous tracking. Still within target range.', 2),
(2, '2026-03-24', 'BP 128/82. Routine checkup.', 'None.', 'Still within target range.', 3),
(2, '2026-03-28', 'Follow-up visit. BP 130/80. Refill request.', 'Amlodipine refilled.', 'Continuous tracking. Maintenance check.', 1),
(2, '2026-04-02', 'BP 130/80. Refill request.', 'Amlodipine refilled.', 'Maintenance check.', 3),
(2, '2026-04-04', 'Follow-up visit. BP 130/80. Refill request.', 'Amlodipine refilled.', 'Continuous tracking. Maintenance check.', 3),
(2, '2026-04-04', 'BP 130/80. Refill request.', 'Amlodipine refilled.', 'Maintenance check.', 3),
(2, '2026-04-05', 'Follow-up visit. BP 120/80. No signs of retinopathy or edema.', 'Continue current plan.', 'Continuous tracking. Maintenance is effective.', 3),
(2, '2026-04-05', 'BP 120/80. No signs of retinopathy or edema.', 'Continue current plan.', 'Maintenance is effective.', 3),
(2, '2026-04-06', 'Follow-up visit. BP 120/80. No signs of retinopathy or edema.', 'Continue current plan.', 'Continuous tracking. Maintenance is effective.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(2, '2026-04-09', 'BP 120/80. No signs of retinopathy or edema.', 'Continue current plan.', 'Maintenance is effective.', 1);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(3, '2025-12-15', 'Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Fungal skin infection. Non-infectious to others via touch.', 1),
(3, '2025-12-22', 'Follow-up visit. Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Continuous tracking. Fungal skin infection. Non-infectious to others via touch.', 1),
(3, '2025-12-25', 'Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Fungal skin infection. Non-infectious to others via touch.', 3),
(3, '2025-12-29', 'Follow-up visit. Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Continuous tracking. Fungal skin infection. Non-infectious to others via touch.', 2),
(3, '2025-12-31', 'Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Fungal skin infection. Non-infectious to others via touch.', 3),
(3, '2025-12-31', 'Follow-up visit. Itching significantly reduced. Redness fading.', 'Continue Cream for 7 more days. Do not scratch.', 'Continuous tracking. Partial resolution.', 3),
(3, '2026-01-01', 'Itching significantly reduced. Redness fading.', 'Continue Cream for 7 more days. Do not scratch.', 'Partial resolution.', 2),
(3, '2026-01-08', 'Follow-up visit. Itching significantly reduced. Redness fading.', 'Continue Cream for 7 more days. Do not scratch.', 'Continuous tracking. Partial resolution.', 1),
(3, '2026-01-09', 'Itching significantly reduced. Redness fading.', 'Continue Cream for 7 more days. Do not scratch.', 'Partial resolution.', 2),
(3, '2026-01-14', 'Follow-up visit. Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Continuous tracking. Healing.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(3, '2026-01-15', 'Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Healing.', 3),
(3, '2026-01-18', 'Follow-up visit. Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Continuous tracking. Healing.', 1),
(3, '2026-01-24', 'Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Healing.', 1),
(3, '2026-01-30', 'Follow-up visit. Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Continuous tracking. Healing.', 1),
(3, '2026-02-02', 'Skin cleared. Occasional itch when sweating.', 'Miconazole powder for shoes/socks.', 'Full recovery. Prevention advised.', 1),
(3, '2026-02-05', 'Follow-up visit. Skin cleared. Occasional itch when sweating.', 'Miconazole powder for shoes/socks.', 'Continuous tracking. Full recovery. Prevention advised.', 2),
(3, '2026-02-11', 'Skin cleared. Occasional itch when sweating.', 'Miconazole powder for shoes/socks.', 'Full recovery. Prevention advised.', 2),
(3, '2026-02-14', 'Follow-up visit. Skin cleared. Occasional itch when sweating.', 'Miconazole powder for shoes/socks.', 'Continuous tracking. Full recovery. Prevention advised.', 1),
(3, '2026-02-14', 'Stable skin.', 'None.', 'No active lesions.', 3),
(3, '2026-02-14', 'Follow-up visit. Stable skin.', 'None.', 'Continuous tracking. No active lesions.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(3, '2026-02-18', 'Stable skin.', 'None.', 'No active lesions.', 3),
(3, '2026-02-21', 'Follow-up visit. Stable skin.', 'None.', 'Continuous tracking. No active lesions.', 1),
(3, '2026-02-22', 'Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Reinforced hygiene counseling.', 1),
(3, '2026-02-22', 'Follow-up visit. Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Continuous tracking. Reinforced hygiene counseling.', 1),
(3, '2026-02-22', 'Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Reinforced hygiene counseling.', 1),
(3, '2026-02-23', 'Follow-up visit. Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Continuous tracking. Reinforced hygiene counseling.', 1),
(3, '2026-02-27', 'Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Reinforced hygiene counseling.', 3),
(3, '2026-02-28', 'Follow-up visit. Cleared again.', 'None.', 'Continuous tracking. Successful re-treatment.', 3),
(3, '2026-03-04', 'Cleared again.', 'None.', 'Successful re-treatment.', 2),
(3, '2026-03-05', 'Follow-up visit. Cleared again.', 'None.', 'Continuous tracking. Successful re-treatment.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(3, '2026-03-07', 'Cleared again.', 'None.', 'Successful re-treatment.', 3),
(3, '2026-03-08', 'Follow-up visit. Follow up. No new lesions.', 'None.', 'Continuous tracking. Clear.', 1),
(3, '2026-03-12', 'Follow up. No new lesions.', 'None.', 'Clear.', 3),
(3, '2026-03-14', 'Follow-up visit. Follow up. No new lesions.', 'None.', 'Continuous tracking. Clear.', 1),
(3, '2026-03-16', 'Follow up. No new lesions.', 'None.', 'Clear.', 1),
(3, '2026-03-20', 'Follow-up visit. Follow up. No new lesions.', 'None.', 'Continuous tracking. Clear.', 2),
(3, '2026-03-23', 'Routine checkup.', 'None.', 'Stable.', 3),
(3, '2026-03-26', 'Follow-up visit. Routine checkup.', 'None.', 'Continuous tracking. Stable.', 2),
(3, '2026-03-30', 'Routine checkup.', 'None.', 'Stable.', 1),
(3, '2026-04-02', 'Follow-up visit. Routine checkup.', 'None.', 'Continuous tracking. Stable.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(3, '2026-04-04', 'Healthy skin.', 'None.', 'Discharged from skin monitoring.', 2),
(3, '2026-04-11', 'Follow-up visit. Healthy skin.', 'None.', 'Continuous tracking. Discharged from skin monitoring.', 1),
(3, '2026-04-11', 'Healthy skin.', 'None.', 'Discharged from skin monitoring.', 1),
(3, '2026-04-12', 'Follow-up visit. Healthy skin.', 'None.', 'Continuous tracking. Discharged from skin monitoring.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(4, '2025-12-23', 'BP 150/90. Occasional nape pain after salty meals.', 'Amlodipine 5mg OD. Advised low-salt, low-fat diet.', 'Stage 1 Hypertension. OPD monitoring.', 3),
(4, '2025-12-27', 'Follow-up visit. BP 150/90. Occasional nape pain after salty meals.', 'Amlodipine 5mg OD. Advised low-salt, low-fat diet.', 'Continuous tracking. Stage 1 Hypertension. OPD monitoring.', 2),
(4, '2026-01-02', 'BP 150/90. Occasional nape pain after salty meals.', 'Amlodipine 5mg OD. Advised low-salt, low-fat diet.', 'Stage 1 Hypertension. OPD monitoring.', 1),
(4, '2026-01-06', 'Follow-up visit. BP 140/85. Nape pain reduced.', 'Continue Amlodipine. Provided diet chart.', 'Continuous tracking. Stabilizing. Patient compliant.', 1),
(4, '2026-01-15', 'BP 140/85. Nape pain reduced.', 'Continue Amlodipine. Provided diet chart.', 'Stabilizing. Patient compliant.', 2),
(4, '2026-01-15', 'Follow-up visit. BP 130/80. No complaints.', 'Maintain current meds.', 'Continuous tracking. Excellent BP control.', 3),
(4, '2026-01-16', 'BP 130/80. No complaints.', 'Maintain current meds.', 'Excellent BP control.', 1),
(4, '2026-01-17', 'Follow-up visit. BP 130/80. No complaints.', 'Maintain current meds.', 'Continuous tracking. Excellent BP control.', 1),
(4, '2026-01-19', 'BP 145/90. Reported eating at a fiesta.', 'Counseling on diet during holidays. Maintain meds.', 'Lifestyle-induced BP spike.', 3),
(4, '2026-02-05', 'Follow-up visit. BP 145/90. Reported eating at a fiesta.', 'Counseling on diet during holidays. Maintain meds.', 'Continuous tracking. Lifestyle-induced BP spike.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(4, '2026-02-06', 'BP 135/85. Feeling better.', 'Continue Amlodipine.', 'Return to baseline.', 2),
(4, '2026-02-16', 'Follow-up visit. BP 135/85. Feeling better.', 'Continue Amlodipine.', 'Continuous tracking. Return to baseline.', 1),
(4, '2026-02-18', 'BP 125/80. No dizziness.', 'Prescription refill for 2 months.', 'Stable maintenance.', 2),
(4, '2026-02-23', 'Follow-up visit. BP 125/80. No dizziness.', 'Prescription refill for 2 months.', 'Continuous tracking. Stable maintenance.', 2),
(4, '2026-03-01', 'BP 125/80. No dizziness.', 'Prescription refill for 2 months.', 'Stable maintenance.', 2),
(4, '2026-03-02', 'Follow-up visit. BP 120/80. Weight down by 1kg.', 'Encouraged walking 30 mins daily.', 'Continuous tracking. Good progress with exercise.', 1),
(4, '2026-03-07', 'BP 120/80. Weight down by 1kg.', 'Encouraged walking 30 mins daily.', 'Good progress with exercise.', 3),
(4, '2026-03-20', 'Follow-up visit. BP 128/82. Routine checkup.', 'None.', 'Continuous tracking. Still within target range.', 1),
(4, '2026-03-28', 'BP 128/82. Routine checkup.', 'None.', 'Still within target range.', 1),
(4, '2026-03-28', 'Follow-up visit. BP 128/82. Routine checkup.', 'None.', 'Continuous tracking. Still within target range.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(4, '2026-03-31', 'BP 130/80. Refill request.', 'Amlodipine refilled.', 'Maintenance check.', 2),
(4, '2026-03-31', 'Follow-up visit. BP 130/80. Refill request.', 'Amlodipine refilled.', 'Continuous tracking. Maintenance check.', 3),
(4, '2026-04-10', 'BP 120/80. No signs of retinopathy or edema.', 'Continue current plan.', 'Maintenance is effective.', 3),
(4, '2026-04-11', 'Follow-up visit. BP 120/80. No signs of retinopathy or edema.', 'Continue current plan.', 'Continuous tracking. Maintenance is effective.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(5, '2025-12-21', 'BP 150/90. Occasional nape pain after salty meals.', 'Amlodipine 5mg OD. Advised low-salt, low-fat diet.', 'Stage 1 Hypertension. OPD monitoring.', 3),
(5, '2025-12-24', 'Follow-up visit. BP 150/90. Occasional nape pain after salty meals.', 'Amlodipine 5mg OD. Advised low-salt, low-fat diet.', 'Continuous tracking. Stage 1 Hypertension. OPD monitoring.', 3),
(5, '2026-01-04', 'BP 150/90. Occasional nape pain after salty meals.', 'Amlodipine 5mg OD. Advised low-salt, low-fat diet.', 'Stage 1 Hypertension. OPD monitoring.', 3),
(5, '2026-01-11', 'Follow-up visit. BP 140/85. Nape pain reduced.', 'Continue Amlodipine. Provided diet chart.', 'Continuous tracking. Stabilizing. Patient compliant.', 2),
(5, '2026-01-12', 'BP 140/85. Nape pain reduced.', 'Continue Amlodipine. Provided diet chart.', 'Stabilizing. Patient compliant.', 2),
(5, '2026-01-14', 'Follow-up visit. BP 130/80. No complaints.', 'Maintain current meds.', 'Continuous tracking. Excellent BP control.', 2),
(5, '2026-01-17', 'BP 130/80. No complaints.', 'Maintain current meds.', 'Excellent BP control.', 1),
(5, '2026-01-17', 'Follow-up visit. BP 145/90. Reported eating at a fiesta.', 'Counseling on diet during holidays. Maintain meds.', 'Continuous tracking. Lifestyle-induced BP spike.', 2),
(5, '2026-01-18', 'BP 145/90. Reported eating at a fiesta.', 'Counseling on diet during holidays. Maintain meds.', 'Lifestyle-induced BP spike.', 2),
(5, '2026-01-19', 'Follow-up visit. BP 135/85. Feeling better.', 'Continue Amlodipine.', 'Continuous tracking. Return to baseline.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(5, '2026-02-08', 'BP 135/85. Feeling better.', 'Continue Amlodipine.', 'Return to baseline.', 2),
(5, '2026-02-11', 'Follow-up visit. BP 125/80. No dizziness.', 'Prescription refill for 2 months.', 'Continuous tracking. Stable maintenance.', 2),
(5, '2026-02-19', 'BP 125/80. No dizziness.', 'Prescription refill for 2 months.', 'Stable maintenance.', 3),
(5, '2026-03-13', 'Follow-up visit. BP 120/80. Weight down by 1kg.', 'Encouraged walking 30 mins daily.', 'Continuous tracking. Good progress with exercise.', 1),
(5, '2026-03-13', 'BP 120/80. Weight down by 1kg.', 'Encouraged walking 30 mins daily.', 'Good progress with exercise.', 3),
(5, '2026-03-15', 'Follow-up visit. BP 128/82. Routine checkup.', 'None.', 'Continuous tracking. Still within target range.', 1),
(5, '2026-03-29', 'BP 128/82. Routine checkup.', 'None.', 'Still within target range.', 2),
(5, '2026-04-03', 'Follow-up visit. BP 130/80. Refill request.', 'Amlodipine refilled.', 'Continuous tracking. Maintenance check.', 3),
(5, '2026-04-04', 'BP 130/80. Refill request.', 'Amlodipine refilled.', 'Maintenance check.', 3),
(5, '2026-04-12', 'Follow-up visit. BP 120/80. No signs of retinopathy or edema.', 'Continue current plan.', 'Continuous tracking. Maintenance is effective.', 1);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(5, '2026-04-13', 'BP 120/80. No signs of retinopathy or edema.', 'Continue current plan.', 'Maintenance is effective.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(6, '2025-12-15', 'Burning sensation in the chest, sour taste in mouth.', 'Omeprazole 20mg OD (30 mins before breakfast). Avoid coffee/spicy food.', 'Suspected Acid Reflux (GERD).', 1),
(6, '2025-12-16', 'Follow-up visit. Burning sensation in the chest, sour taste in mouth.', 'Omeprazole 20mg OD (30 mins before breakfast). Avoid coffee/spicy food.', 'Continuous tracking. Suspected Acid Reflux (GERD).', 2),
(6, '2025-12-19', 'Burning sensation in the chest, sour taste in mouth.', 'Omeprazole 20mg OD (30 mins before breakfast). Avoid coffee/spicy food.', 'Suspected Acid Reflux (GERD).', 1),
(6, '2025-12-21', 'Follow-up visit. Burning sensation in the chest, sour taste in mouth.', 'Omeprazole 20mg OD (30 mins before breakfast). Avoid coffee/spicy food.', 'Continuous tracking. Suspected Acid Reflux (GERD).', 2),
(6, '2025-12-22', 'Feeling better. Reflux only happens when lying down after dinner.', 'Maintain Omeprazole. Advised not to lie down for 2 hrs after eating.', 'Lifestyle adjustment required.', 3),
(6, '2025-12-26', 'Follow-up visit. Feeling better. Reflux only happens when lying down after dinner.', 'Maintain Omeprazole. Advised not to lie down for 2 hrs after eating.', 'Continuous tracking. Lifestyle adjustment required.', 3),
(6, '2025-12-26', 'Feeling better. Reflux only happens when lying down after dinner.', 'Maintain Omeprazole. Advised not to lie down for 2 hrs after eating.', 'Lifestyle adjustment required.', 3),
(6, '2025-12-31', 'Follow-up visit. Stable. No heartburn.', 'Tapering Omeprazole to PRN.', 'Continuous tracking. Improving.', 3),
(6, '2026-01-03', 'Stable. No heartburn.', 'Tapering Omeprazole to PRN.', 'Improving.', 1),
(6, '2026-01-07', 'Follow-up visit. Stable. No heartburn.', 'Tapering Omeprazole to PRN.', 'Continuous tracking. Improving.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(6, '2026-01-09', 'Mild bloating after eating gata dishes.', 'Simethicone PRN. Continue diet avoidance.', 'Dietary flare-up.', 1),
(6, '2026-01-12', 'Follow-up visit. Mild bloating after eating gata dishes.', 'Simethicone PRN. Continue diet avoidance.', 'Continuous tracking. Dietary flare-up.', 2),
(6, '2026-01-14', 'Mild bloating after eating gata dishes.', 'Simethicone PRN. Continue diet avoidance.', 'Dietary flare-up.', 1),
(6, '2026-01-16', 'Follow-up visit. Mild bloating after eating gata dishes.', 'Simethicone PRN. Continue diet avoidance.', 'Continuous tracking. Dietary flare-up.', 2),
(6, '2026-01-16', 'Bloating resolved.', 'Stay on bland diet for 3 days.', 'Managed.', 2),
(6, '2026-01-19', 'Follow-up visit. Bloating resolved.', 'Stay on bland diet for 3 days.', 'Continuous tracking. Managed.', 3),
(6, '2026-01-27', 'Bloating resolved.', 'Stay on bland diet for 3 days.', 'Managed.', 2),
(6, '2026-01-28', 'Follow-up visit. Feeling normal. No antacids needed for a week.', 'None.', 'Continuous tracking. Stable.', 2),
(6, '2026-02-01', 'Feeling normal. No antacids needed for a week.', 'None.', 'Stable.', 3),
(6, '2026-02-06', 'Follow-up visit. Feeling normal. No antacids needed for a week.', 'None.', 'Continuous tracking. Stable.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(6, '2026-02-11', 'Stable.', 'None.', 'Checkup.', 3),
(6, '2026-02-12', 'Follow-up visit. Stable.', 'None.', 'Continuous tracking. Checkup.', 3),
(6, '2026-02-14', 'Stable.', 'None.', 'Checkup.', 2),
(6, '2026-02-14', 'Follow-up visit. Stable.', 'None.', 'Continuous tracking. Checkup.', 2),
(6, '2026-02-19', 'Occasional stress-induced stomach ache.', 'Warm water, relaxation.', 'Psychosomatic factor.', 3),
(6, '2026-02-22', 'Follow-up visit. Occasional stress-induced stomach ache.', 'Warm water, relaxation.', 'Continuous tracking. Psychosomatic factor.', 2),
(6, '2026-02-25', 'Occasional stress-induced stomach ache.', 'Warm water, relaxation.', 'Psychosomatic factor.', 1),
(6, '2026-03-05', 'Follow-up visit. No symptoms.', 'None.', 'Continuous tracking. Asymptomatic.', 2),
(6, '2026-03-14', 'No symptoms.', 'None.', 'Asymptomatic.', 1),
(6, '2026-03-17', 'Follow-up visit. No symptoms.', 'None.', 'Continuous tracking. Asymptomatic.', 1);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(6, '2026-03-28', 'Full recovery. Patient learned dietary triggers.', 'None.', 'Case closed.', 2),
(6, '2026-04-03', 'Follow-up visit. Full recovery. Patient learned dietary triggers.', 'None.', 'Continuous tracking. Case closed.', 1),
(6, '2026-04-07', 'Full recovery. Patient learned dietary triggers.', 'None.', 'Case closed.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(7, '2025-12-17', 'Sneezing, runny nose, mild throat itchiness', 'Prescribed Cetirizine 10mg OD. Vitamin C 500mg. Drink plenty of water.', 'Likely viral upper respiratory infection. Rest advised.', 1),
(7, '2025-12-20', 'Follow-up visit. Sneezing, runny nose, mild throat itchiness', 'Prescribed Cetirizine 10mg OD. Vitamin C 500mg. Drink plenty of water.', 'Continuous tracking. Likely viral upper respiratory infection. Rest advised.', 1),
(7, '2025-12-22', 'Sneezing, runny nose, mild throat itchiness', 'Prescribed Cetirizine 10mg OD. Vitamin C 500mg. Drink plenty of water.', 'Likely viral upper respiratory infection. Rest advised.', 3),
(7, '2025-12-24', 'Follow-up visit. Slight dry cough, no fever', 'Continue Vitamin C. Added Ambroxol 30mg TID for cough.', 'Continuous tracking. Patient feels slightly better.', 2),
(7, '2026-01-01', 'Slight dry cough, no fever', 'Continue Vitamin C. Added Ambroxol 30mg TID for cough.', 'Patient feels slightly better.', 3),
(7, '2026-01-05', 'Follow-up visit. Slight dry cough, no fever', 'Continue Vitamin C. Added Ambroxol 30mg TID for cough.', 'Continuous tracking. Patient feels slightly better.', 2),
(7, '2026-01-14', 'No symptoms. Routine vitamin refill', 'Refilled Multivitamins.', 'Recovery complete.', 3),
(7, '2026-01-18', 'Follow-up visit. No symptoms. Routine vitamin refill', 'Refilled Multivitamins.', 'Continuous tracking. Recovery complete.', 1),
(7, '2026-01-20', 'No symptoms. Routine vitamin refill', 'Refilled Multivitamins.', 'Recovery complete.', 1),
(7, '2026-01-27', 'Follow-up visit. Recurrence of symptoms after rainy travel: Feverish, sore throat', 'Paracetamol 500mg PRN. Gargle with warm salt water.', 'Continuous tracking. New episode of viral flu.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(7, '2026-02-03', 'Recurrence of symptoms after rainy travel: Feverish, sore throat', 'Paracetamol 500mg PRN. Gargle with warm salt water.', 'New episode of viral flu.', 1),
(7, '2026-02-03', 'Follow-up visit. Recurrence of symptoms after rainy travel: Feverish, sore throat', 'Paracetamol 500mg PRN. Gargle with warm salt water.', 'Continuous tracking. New episode of viral flu.', 1),
(7, '2026-02-05', 'Productive cough, yellowish phlegm', 'Amoxicillin 500mg TID for 7 days. Continue hydration.', 'Suspected mild secondary bacterial infection.', 3),
(7, '2026-02-09', 'Follow-up visit. Productive cough, yellowish phlegm', 'Amoxicillin 500mg TID for 7 days. Continue hydration.', 'Continuous tracking. Suspected mild secondary bacterial infection.', 2),
(7, '2026-02-10', 'Productive cough, yellowish phlegm', 'Amoxicillin 500mg TID for 7 days. Continue hydration.', 'Suspected mild secondary bacterial infection.', 2),
(7, '2026-02-13', 'Follow-up visit. Cough improving, still feels weak', 'Continue Antibiotics. Rest.', 'Continuous tracking. Compliance is good.', 1),
(7, '2026-02-20', 'Cough improving, still feels weak', 'Continue Antibiotics. Rest.', 'Compliance is good.', 1),
(7, '2026-02-22', 'Follow-up visit. Cough improving, still feels weak', 'Continue Antibiotics. Rest.', 'Continuous tracking. Compliance is good.', 1),
(7, '2026-02-23', 'Resolved. Throat clear.', 'Vitamins only.', 'Back to healthy baseline.', 2),
(7, '2026-02-23', 'Follow-up visit. Resolved. Throat clear.', 'Vitamins only.', 'Continuous tracking. Back to healthy baseline.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(7, '2026-02-24', 'Resolved. Throat clear.', 'Vitamins only.', 'Back to healthy baseline.', 2),
(7, '2026-02-28', 'Follow-up visit. Minor nasal congestion due to allergens', 'Loratadine 10mg OD.', 'Continuous tracking. Seasonal allergy management.', 3),
(7, '2026-03-05', 'Minor nasal congestion due to allergens', 'Loratadine 10mg OD.', 'Seasonal allergy management.', 2),
(7, '2026-03-07', 'Follow-up visit. Minor nasal congestion due to allergens', 'Loratadine 10mg OD.', 'Continuous tracking. Seasonal allergy management.', 3),
(7, '2026-03-14', 'Stable. Feeling well.', 'None.', 'Fully asymptomatic.', 1),
(7, '2026-03-24', 'Follow-up visit. Stable. Feeling well.', 'None.', 'Continuous tracking. Fully asymptomatic.', 2),
(7, '2026-03-30', 'Stable. Feeling well.', 'None.', 'Fully asymptomatic.', 1),
(7, '2026-04-01', 'Follow-up visit. Routine visit. Clean bill of health.', 'Stay hydrated.', 'Continuous tracking. Patient educated on flu prevention.', 1),
(7, '2026-04-11', 'Routine visit. Clean bill of health.', 'Stay hydrated.', 'Patient educated on flu prevention.', 2),
(7, '2026-04-12', 'Follow-up visit. Routine visit. Clean bill of health.', 'Stay hydrated.', 'Continuous tracking. Patient educated on flu prevention.', 1);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(8, '2025-12-15', 'Burning sensation in the chest, sour taste in mouth.', 'Omeprazole 20mg OD (30 mins before breakfast). Avoid coffee/spicy food.', 'Suspected Acid Reflux (GERD).', 2),
(8, '2025-12-16', 'Follow-up visit. Burning sensation in the chest, sour taste in mouth.', 'Omeprazole 20mg OD (30 mins before breakfast). Avoid coffee/spicy food.', 'Continuous tracking. Suspected Acid Reflux (GERD).', 3),
(8, '2025-12-26', 'Burning sensation in the chest, sour taste in mouth.', 'Omeprazole 20mg OD (30 mins before breakfast). Avoid coffee/spicy food.', 'Suspected Acid Reflux (GERD).', 1),
(8, '2025-12-29', 'Follow-up visit. Feeling better. Reflux only happens when lying down after dinner.', 'Maintain Omeprazole. Advised not to lie down for 2 hrs after eating.', 'Continuous tracking. Lifestyle adjustment required.', 1),
(8, '2025-12-31', 'Feeling better. Reflux only happens when lying down after dinner.', 'Maintain Omeprazole. Advised not to lie down for 2 hrs after eating.', 'Lifestyle adjustment required.', 1),
(8, '2026-01-04', 'Follow-up visit. Feeling better. Reflux only happens when lying down after dinner.', 'Maintain Omeprazole. Advised not to lie down for 2 hrs after eating.', 'Continuous tracking. Lifestyle adjustment required.', 2),
(8, '2026-01-05', 'Stable. No heartburn.', 'Tapering Omeprazole to PRN.', 'Improving.', 2),
(8, '2026-01-11', 'Follow-up visit. Stable. No heartburn.', 'Tapering Omeprazole to PRN.', 'Continuous tracking. Improving.', 2),
(8, '2026-01-12', 'Mild bloating after eating gata dishes.', 'Simethicone PRN. Continue diet avoidance.', 'Dietary flare-up.', 2),
(8, '2026-01-12', 'Follow-up visit. Mild bloating after eating gata dishes.', 'Simethicone PRN. Continue diet avoidance.', 'Continuous tracking. Dietary flare-up.', 1);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(8, '2026-01-24', 'Mild bloating after eating gata dishes.', 'Simethicone PRN. Continue diet avoidance.', 'Dietary flare-up.', 1),
(8, '2026-01-29', 'Follow-up visit. Bloating resolved.', 'Stay on bland diet for 3 days.', 'Continuous tracking. Managed.', 3),
(8, '2026-01-30', 'Bloating resolved.', 'Stay on bland diet for 3 days.', 'Managed.', 3),
(8, '2026-01-31', 'Follow-up visit. Feeling normal. No antacids needed for a week.', 'None.', 'Continuous tracking. Stable.', 2),
(8, '2026-02-04', 'Feeling normal. No antacids needed for a week.', 'None.', 'Stable.', 2),
(8, '2026-02-08', 'Follow-up visit. Feeling normal. No antacids needed for a week.', 'None.', 'Continuous tracking. Stable.', 3),
(8, '2026-02-12', 'Stable.', 'None.', 'Checkup.', 1),
(8, '2026-02-15', 'Follow-up visit. Stable.', 'None.', 'Continuous tracking. Checkup.', 1),
(8, '2026-03-09', 'Stable.', 'None.', 'Checkup.', 2),
(8, '2026-03-14', 'Follow-up visit. Occasional stress-induced stomach ache.', 'Warm water, relaxation.', 'Continuous tracking. Psychosomatic factor.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(8, '2026-03-20', 'Occasional stress-induced stomach ache.', 'Warm water, relaxation.', 'Psychosomatic factor.', 3),
(8, '2026-03-24', 'Follow-up visit. No symptoms.', 'None.', 'Continuous tracking. Asymptomatic.', 2),
(8, '2026-03-29', 'No symptoms.', 'None.', 'Asymptomatic.', 2),
(8, '2026-04-04', 'Follow-up visit. No symptoms.', 'None.', 'Continuous tracking. Asymptomatic.', 2),
(8, '2026-04-08', 'Full recovery. Patient learned dietary triggers.', 'None.', 'Case closed.', 3),
(8, '2026-04-11', 'Follow-up visit. Full recovery. Patient learned dietary triggers.', 'None.', 'Continuous tracking. Case closed.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(9, '2025-12-17', 'Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Fungal skin infection. Non-infectious to others via touch.', 1),
(9, '2025-12-18', 'Follow-up visit. Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Continuous tracking. Fungal skin infection. Non-infectious to others via touch.', 2),
(9, '2025-12-21', 'Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Fungal skin infection. Non-infectious to others via touch.', 2),
(9, '2025-12-22', 'Follow-up visit. Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Continuous tracking. Fungal skin infection. Non-infectious to others via touch.', 2),
(9, '2025-12-22', 'Itching significantly reduced. Redness fading.', 'Continue Cream for 7 more days. Do not scratch.', 'Partial resolution.', 2),
(9, '2025-12-22', 'Follow-up visit. Itching significantly reduced. Redness fading.', 'Continue Cream for 7 more days. Do not scratch.', 'Continuous tracking. Partial resolution.', 3),
(9, '2025-12-26', 'Itching significantly reduced. Redness fading.', 'Continue Cream for 7 more days. Do not scratch.', 'Partial resolution.', 2),
(9, '2025-12-27', 'Follow-up visit. Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Continuous tracking. Healing.', 1),
(9, '2025-12-29', 'Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Healing.', 2),
(9, '2025-12-30', 'Follow-up visit. Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Continuous tracking. Healing.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(9, '2026-01-01', 'Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Healing.', 1),
(9, '2026-01-09', 'Follow-up visit. Skin cleared. Occasional itch when sweating.', 'Miconazole powder for shoes/socks.', 'Continuous tracking. Full recovery. Prevention advised.', 1),
(9, '2026-01-12', 'Skin cleared. Occasional itch when sweating.', 'Miconazole powder for shoes/socks.', 'Full recovery. Prevention advised.', 1),
(9, '2026-01-15', 'Follow-up visit. Skin cleared. Occasional itch when sweating.', 'Miconazole powder for shoes/socks.', 'Continuous tracking. Full recovery. Prevention advised.', 2),
(9, '2026-01-17', 'Stable skin.', 'None.', 'No active lesions.', 2),
(9, '2026-01-18', 'Follow-up visit. Stable skin.', 'None.', 'Continuous tracking. No active lesions.', 2),
(9, '2026-01-22', 'Stable skin.', 'None.', 'No active lesions.', 1),
(9, '2026-01-27', 'Follow-up visit. Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Continuous tracking. Reinforced hygiene counseling.', 3),
(9, '2026-01-29', 'Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Reinforced hygiene counseling.', 1),
(9, '2026-02-03', 'Follow-up visit. Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Continuous tracking. Reinforced hygiene counseling.', 1);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(9, '2026-02-11', 'Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Reinforced hygiene counseling.', 1),
(9, '2026-02-12', 'Follow-up visit. Cleared again.', 'None.', 'Continuous tracking. Successful re-treatment.', 1),
(9, '2026-02-17', 'Cleared again.', 'None.', 'Successful re-treatment.', 1),
(9, '2026-02-19', 'Follow-up visit. Cleared again.', 'None.', 'Continuous tracking. Successful re-treatment.', 1),
(9, '2026-03-09', 'Follow up. No new lesions.', 'None.', 'Clear.', 2),
(9, '2026-03-11', 'Follow-up visit. Follow up. No new lesions.', 'None.', 'Continuous tracking. Clear.', 1),
(9, '2026-03-18', 'Follow up. No new lesions.', 'None.', 'Clear.', 3),
(9, '2026-03-19', 'Follow-up visit. Follow up. No new lesions.', 'None.', 'Continuous tracking. Clear.', 1),
(9, '2026-03-19', 'Routine checkup.', 'None.', 'Stable.', 3),
(9, '2026-03-21', 'Follow-up visit. Routine checkup.', 'None.', 'Continuous tracking. Stable.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(9, '2026-03-23', 'Routine checkup.', 'None.', 'Stable.', 1),
(9, '2026-03-26', 'Follow-up visit. Healthy skin.', 'None.', 'Continuous tracking. Discharged from skin monitoring.', 3),
(9, '2026-03-27', 'Healthy skin.', 'None.', 'Discharged from skin monitoring.', 1),
(9, '2026-04-04', 'Follow-up visit. Healthy skin.', 'None.', 'Continuous tracking. Discharged from skin monitoring.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(10, '2025-12-17', 'Burning sensation in the chest, sour taste in mouth.', 'Omeprazole 20mg OD (30 mins before breakfast). Avoid coffee/spicy food.', 'Suspected Acid Reflux (GERD).', 1),
(10, '2026-01-04', 'Follow-up visit. Burning sensation in the chest, sour taste in mouth.', 'Omeprazole 20mg OD (30 mins before breakfast). Avoid coffee/spicy food.', 'Continuous tracking. Suspected Acid Reflux (GERD).', 1),
(10, '2026-01-05', 'Feeling better. Reflux only happens when lying down after dinner.', 'Maintain Omeprazole. Advised not to lie down for 2 hrs after eating.', 'Lifestyle adjustment required.', 3),
(10, '2026-01-08', 'Follow-up visit. Stable. No heartburn.', 'Tapering Omeprazole to PRN.', 'Continuous tracking. Improving.', 2),
(10, '2026-01-29', 'Stable. No heartburn.', 'Tapering Omeprazole to PRN.', 'Improving.', 3),
(10, '2026-02-01', 'Follow-up visit. Mild bloating after eating gata dishes.', 'Simethicone PRN. Continue diet avoidance.', 'Continuous tracking. Dietary flare-up.', 3),
(10, '2026-02-16', 'Bloating resolved.', 'Stay on bland diet for 3 days.', 'Managed.', 1),
(10, '2026-02-18', 'Follow-up visit. Feeling normal. No antacids needed for a week.', 'None.', 'Continuous tracking. Stable.', 2),
(10, '2026-02-25', 'Feeling normal. No antacids needed for a week.', 'None.', 'Stable.', 1),
(10, '2026-03-01', 'Follow-up visit. Stable.', 'None.', 'Continuous tracking. Checkup.', 1);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(10, '2026-03-12', 'Occasional stress-induced stomach ache.', 'Warm water, relaxation.', 'Psychosomatic factor.', 1),
(10, '2026-03-23', 'Follow-up visit. Occasional stress-induced stomach ache.', 'Warm water, relaxation.', 'Continuous tracking. Psychosomatic factor.', 2),
(10, '2026-03-29', 'No symptoms.', 'None.', 'Asymptomatic.', 1),
(10, '2026-04-07', 'Follow-up visit. Full recovery. Patient learned dietary triggers.', 'None.', 'Continuous tracking. Case closed.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(11, '2025-12-19', 'Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Fungal skin infection. Non-infectious to others via touch.', 2),
(11, '2025-12-26', 'Follow-up visit. Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Continuous tracking. Fungal skin infection. Non-infectious to others via touch.', 3),
(11, '2025-12-26', 'Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Fungal skin infection. Non-infectious to others via touch.', 3),
(11, '2025-12-27', 'Follow-up visit. Itching significantly reduced. Redness fading.', 'Continue Cream for 7 more days. Do not scratch.', 'Continuous tracking. Partial resolution.', 1),
(11, '2026-01-03', 'Itching significantly reduced. Redness fading.', 'Continue Cream for 7 more days. Do not scratch.', 'Partial resolution.', 3),
(11, '2026-01-13', 'Follow-up visit. Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Continuous tracking. Healing.', 3),
(11, '2026-01-21', 'Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Healing.', 2),
(11, '2026-01-21', 'Follow-up visit. Skin cleared. Occasional itch when sweating.', 'Miconazole powder for shoes/socks.', 'Continuous tracking. Full recovery. Prevention advised.', 3),
(11, '2026-01-24', 'Skin cleared. Occasional itch when sweating.', 'Miconazole powder for shoes/socks.', 'Full recovery. Prevention advised.', 2),
(11, '2026-02-09', 'Follow-up visit. Skin cleared. Occasional itch when sweating.', 'Miconazole powder for shoes/socks.', 'Continuous tracking. Full recovery. Prevention advised.', 1);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(11, '2026-02-11', 'Stable skin.', 'None.', 'No active lesions.', 1),
(11, '2026-02-12', 'Follow-up visit. Stable skin.', 'None.', 'Continuous tracking. No active lesions.', 1),
(11, '2026-02-16', 'Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Reinforced hygiene counseling.', 2),
(11, '2026-02-17', 'Follow-up visit. Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Continuous tracking. Reinforced hygiene counseling.', 2),
(11, '2026-03-05', 'Cleared again.', 'None.', 'Successful re-treatment.', 2),
(11, '2026-03-13', 'Follow-up visit. Cleared again.', 'None.', 'Continuous tracking. Successful re-treatment.', 1),
(11, '2026-03-14', 'Cleared again.', 'None.', 'Successful re-treatment.', 3),
(11, '2026-03-16', 'Follow-up visit. Follow up. No new lesions.', 'None.', 'Continuous tracking. Clear.', 1),
(11, '2026-03-18', 'Follow up. No new lesions.', 'None.', 'Clear.', 3),
(11, '2026-03-21', 'Follow-up visit. Routine checkup.', 'None.', 'Continuous tracking. Stable.', 1);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(11, '2026-03-23', 'Routine checkup.', 'None.', 'Stable.', 2),
(11, '2026-03-23', 'Follow-up visit. Healthy skin.', 'None.', 'Continuous tracking. Discharged from skin monitoring.', 1),
(11, '2026-03-29', 'Healthy skin.', 'None.', 'Discharged from skin monitoring.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(12, '2025-12-14', 'Sneezing, runny nose, mild throat itchiness', 'Prescribed Cetirizine 10mg OD. Vitamin C 500mg. Drink plenty of water.', 'Likely viral upper respiratory infection. Rest advised.', 2),
(12, '2025-12-16', 'Follow-up visit. Sneezing, runny nose, mild throat itchiness', 'Prescribed Cetirizine 10mg OD. Vitamin C 500mg. Drink plenty of water.', 'Continuous tracking. Likely viral upper respiratory infection. Rest advised.', 3),
(12, '2025-12-20', 'Sneezing, runny nose, mild throat itchiness', 'Prescribed Cetirizine 10mg OD. Vitamin C 500mg. Drink plenty of water.', 'Likely viral upper respiratory infection. Rest advised.', 3),
(12, '2025-12-22', 'Follow-up visit. Sneezing, runny nose, mild throat itchiness', 'Prescribed Cetirizine 10mg OD. Vitamin C 500mg. Drink plenty of water.', 'Continuous tracking. Likely viral upper respiratory infection. Rest advised.', 1),
(12, '2025-12-23', 'Sneezing, runny nose, mild throat itchiness', 'Prescribed Cetirizine 10mg OD. Vitamin C 500mg. Drink plenty of water.', 'Likely viral upper respiratory infection. Rest advised.', 3),
(12, '2025-12-24', 'Follow-up visit. Slight dry cough, no fever', 'Continue Vitamin C. Added Ambroxol 30mg TID for cough.', 'Continuous tracking. Patient feels slightly better.', 3),
(12, '2025-12-28', 'Slight dry cough, no fever', 'Continue Vitamin C. Added Ambroxol 30mg TID for cough.', 'Patient feels slightly better.', 1),
(12, '2025-12-28', 'Follow-up visit. Slight dry cough, no fever', 'Continue Vitamin C. Added Ambroxol 30mg TID for cough.', 'Continuous tracking. Patient feels slightly better.', 3),
(12, '2025-12-29', 'Slight dry cough, no fever', 'Continue Vitamin C. Added Ambroxol 30mg TID for cough.', 'Patient feels slightly better.', 2),
(12, '2026-01-02', 'Follow-up visit. No symptoms. Routine vitamin refill', 'Refilled Multivitamins.', 'Continuous tracking. Recovery complete.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(12, '2026-01-02', 'No symptoms. Routine vitamin refill', 'Refilled Multivitamins.', 'Recovery complete.', 3),
(12, '2026-01-04', 'Follow-up visit. No symptoms. Routine vitamin refill', 'Refilled Multivitamins.', 'Continuous tracking. Recovery complete.', 2),
(12, '2026-01-05', 'No symptoms. Routine vitamin refill', 'Refilled Multivitamins.', 'Recovery complete.', 1),
(12, '2026-01-07', 'Follow-up visit. No symptoms. Routine vitamin refill', 'Refilled Multivitamins.', 'Continuous tracking. Recovery complete.', 2),
(12, '2026-01-09', 'Recurrence of symptoms after rainy travel: Feverish, sore throat', 'Paracetamol 500mg PRN. Gargle with warm salt water.', 'New episode of viral flu.', 1),
(12, '2026-01-10', 'Follow-up visit. Recurrence of symptoms after rainy travel: Feverish, sore throat', 'Paracetamol 500mg PRN. Gargle with warm salt water.', 'Continuous tracking. New episode of viral flu.', 2),
(12, '2026-01-12', 'Recurrence of symptoms after rainy travel: Feverish, sore throat', 'Paracetamol 500mg PRN. Gargle with warm salt water.', 'New episode of viral flu.', 1),
(12, '2026-01-26', 'Follow-up visit. Recurrence of symptoms after rainy travel: Feverish, sore throat', 'Paracetamol 500mg PRN. Gargle with warm salt water.', 'Continuous tracking. New episode of viral flu.', 3),
(12, '2026-01-29', 'Productive cough, yellowish phlegm', 'Amoxicillin 500mg TID for 7 days. Continue hydration.', 'Suspected mild secondary bacterial infection.', 1),
(12, '2026-01-29', 'Follow-up visit. Productive cough, yellowish phlegm', 'Amoxicillin 500mg TID for 7 days. Continue hydration.', 'Continuous tracking. Suspected mild secondary bacterial infection.', 1);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(12, '2026-02-01', 'Productive cough, yellowish phlegm', 'Amoxicillin 500mg TID for 7 days. Continue hydration.', 'Suspected mild secondary bacterial infection.', 1),
(12, '2026-02-03', 'Follow-up visit. Productive cough, yellowish phlegm', 'Amoxicillin 500mg TID for 7 days. Continue hydration.', 'Continuous tracking. Suspected mild secondary bacterial infection.', 1),
(12, '2026-02-06', 'Productive cough, yellowish phlegm', 'Amoxicillin 500mg TID for 7 days. Continue hydration.', 'Suspected mild secondary bacterial infection.', 3),
(12, '2026-02-06', 'Follow-up visit. Cough improving, still feels weak', 'Continue Antibiotics. Rest.', 'Continuous tracking. Compliance is good.', 1),
(12, '2026-02-07', 'Cough improving, still feels weak', 'Continue Antibiotics. Rest.', 'Compliance is good.', 2),
(12, '2026-02-14', 'Follow-up visit. Cough improving, still feels weak', 'Continue Antibiotics. Rest.', 'Continuous tracking. Compliance is good.', 3),
(12, '2026-02-14', 'Cough improving, still feels weak', 'Continue Antibiotics. Rest.', 'Compliance is good.', 1),
(12, '2026-02-16', 'Follow-up visit. Resolved. Throat clear.', 'Vitamins only.', 'Continuous tracking. Back to healthy baseline.', 3),
(12, '2026-02-17', 'Resolved. Throat clear.', 'Vitamins only.', 'Back to healthy baseline.', 2),
(12, '2026-02-21', 'Follow-up visit. Resolved. Throat clear.', 'Vitamins only.', 'Continuous tracking. Back to healthy baseline.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(12, '2026-02-25', 'Resolved. Throat clear.', 'Vitamins only.', 'Back to healthy baseline.', 2),
(12, '2026-02-27', 'Follow-up visit. Resolved. Throat clear.', 'Vitamins only.', 'Continuous tracking. Back to healthy baseline.', 2),
(12, '2026-02-27', 'Minor nasal congestion due to allergens', 'Loratadine 10mg OD.', 'Seasonal allergy management.', 3),
(12, '2026-02-28', 'Follow-up visit. Minor nasal congestion due to allergens', 'Loratadine 10mg OD.', 'Continuous tracking. Seasonal allergy management.', 2),
(12, '2026-03-01', 'Minor nasal congestion due to allergens', 'Loratadine 10mg OD.', 'Seasonal allergy management.', 3),
(12, '2026-03-01', 'Follow-up visit. Minor nasal congestion due to allergens', 'Loratadine 10mg OD.', 'Continuous tracking. Seasonal allergy management.', 3),
(12, '2026-03-07', 'Stable. Feeling well.', 'None.', 'Fully asymptomatic.', 2),
(12, '2026-03-08', 'Follow-up visit. Stable. Feeling well.', 'None.', 'Continuous tracking. Fully asymptomatic.', 3),
(12, '2026-03-16', 'Stable. Feeling well.', 'None.', 'Fully asymptomatic.', 3),
(12, '2026-03-16', 'Follow-up visit. Stable. Feeling well.', 'None.', 'Continuous tracking. Fully asymptomatic.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(12, '2026-03-21', 'Stable. Feeling well.', 'None.', 'Fully asymptomatic.', 3),
(12, '2026-03-24', 'Follow-up visit. Routine visit. Clean bill of health.', 'Stay hydrated.', 'Continuous tracking. Patient educated on flu prevention.', 3),
(12, '2026-04-04', 'Routine visit. Clean bill of health.', 'Stay hydrated.', 'Patient educated on flu prevention.', 1),
(12, '2026-04-04', 'Follow-up visit. Routine visit. Clean bill of health.', 'Stay hydrated.', 'Continuous tracking. Patient educated on flu prevention.', 2),
(12, '2026-04-13', 'Routine visit. Clean bill of health.', 'Stay hydrated.', 'Patient educated on flu prevention.', 1);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(13, '2025-12-15', 'Burning sensation in the chest, sour taste in mouth.', 'Omeprazole 20mg OD (30 mins before breakfast). Avoid coffee/spicy food.', 'Suspected Acid Reflux (GERD).', 3),
(13, '2025-12-19', 'Follow-up visit. Burning sensation in the chest, sour taste in mouth.', 'Omeprazole 20mg OD (30 mins before breakfast). Avoid coffee/spicy food.', 'Continuous tracking. Suspected Acid Reflux (GERD).', 2),
(13, '2025-12-26', 'Burning sensation in the chest, sour taste in mouth.', 'Omeprazole 20mg OD (30 mins before breakfast). Avoid coffee/spicy food.', 'Suspected Acid Reflux (GERD).', 1),
(13, '2025-12-30', 'Follow-up visit. Burning sensation in the chest, sour taste in mouth.', 'Omeprazole 20mg OD (30 mins before breakfast). Avoid coffee/spicy food.', 'Continuous tracking. Suspected Acid Reflux (GERD).', 3),
(13, '2026-01-02', 'Burning sensation in the chest, sour taste in mouth.', 'Omeprazole 20mg OD (30 mins before breakfast). Avoid coffee/spicy food.', 'Suspected Acid Reflux (GERD).', 1),
(13, '2026-01-09', 'Follow-up visit. Feeling better. Reflux only happens when lying down after dinner.', 'Maintain Omeprazole. Advised not to lie down for 2 hrs after eating.', 'Continuous tracking. Lifestyle adjustment required.', 1),
(13, '2026-01-10', 'Feeling better. Reflux only happens when lying down after dinner.', 'Maintain Omeprazole. Advised not to lie down for 2 hrs after eating.', 'Lifestyle adjustment required.', 2),
(13, '2026-01-13', 'Follow-up visit. Feeling better. Reflux only happens when lying down after dinner.', 'Maintain Omeprazole. Advised not to lie down for 2 hrs after eating.', 'Continuous tracking. Lifestyle adjustment required.', 3),
(13, '2026-01-14', 'Feeling better. Reflux only happens when lying down after dinner.', 'Maintain Omeprazole. Advised not to lie down for 2 hrs after eating.', 'Lifestyle adjustment required.', 2),
(13, '2026-01-15', 'Follow-up visit. Stable. No heartburn.', 'Tapering Omeprazole to PRN.', 'Continuous tracking. Improving.', 1);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(13, '2026-01-16', 'Stable. No heartburn.', 'Tapering Omeprazole to PRN.', 'Improving.', 1),
(13, '2026-01-17', 'Follow-up visit. Stable. No heartburn.', 'Tapering Omeprazole to PRN.', 'Continuous tracking. Improving.', 2),
(13, '2026-01-19', 'Stable. No heartburn.', 'Tapering Omeprazole to PRN.', 'Improving.', 1),
(13, '2026-01-26', 'Follow-up visit. Mild bloating after eating gata dishes.', 'Simethicone PRN. Continue diet avoidance.', 'Continuous tracking. Dietary flare-up.', 3),
(13, '2026-01-31', 'Mild bloating after eating gata dishes.', 'Simethicone PRN. Continue diet avoidance.', 'Dietary flare-up.', 3),
(13, '2026-01-31', 'Follow-up visit. Mild bloating after eating gata dishes.', 'Simethicone PRN. Continue diet avoidance.', 'Continuous tracking. Dietary flare-up.', 3),
(13, '2026-02-05', 'Mild bloating after eating gata dishes.', 'Simethicone PRN. Continue diet avoidance.', 'Dietary flare-up.', 2),
(13, '2026-02-08', 'Follow-up visit. Mild bloating after eating gata dishes.', 'Simethicone PRN. Continue diet avoidance.', 'Continuous tracking. Dietary flare-up.', 3),
(13, '2026-02-08', 'Bloating resolved.', 'Stay on bland diet for 3 days.', 'Managed.', 1),
(13, '2026-02-14', 'Follow-up visit. Bloating resolved.', 'Stay on bland diet for 3 days.', 'Continuous tracking. Managed.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(13, '2026-02-19', 'Bloating resolved.', 'Stay on bland diet for 3 days.', 'Managed.', 1),
(13, '2026-02-23', 'Follow-up visit. Bloating resolved.', 'Stay on bland diet for 3 days.', 'Continuous tracking. Managed.', 2),
(13, '2026-03-02', 'Feeling normal. No antacids needed for a week.', 'None.', 'Stable.', 2),
(13, '2026-03-07', 'Follow-up visit. Feeling normal. No antacids needed for a week.', 'None.', 'Continuous tracking. Stable.', 1),
(13, '2026-03-10', 'Feeling normal. No antacids needed for a week.', 'None.', 'Stable.', 2),
(13, '2026-03-17', 'Follow-up visit. Feeling normal. No antacids needed for a week.', 'None.', 'Continuous tracking. Stable.', 2),
(13, '2026-03-18', 'Stable.', 'None.', 'Checkup.', 3),
(13, '2026-03-20', 'Follow-up visit. Stable.', 'None.', 'Continuous tracking. Checkup.', 3),
(13, '2026-03-20', 'Stable.', 'None.', 'Checkup.', 1),
(13, '2026-03-21', 'Follow-up visit. Stable.', 'None.', 'Continuous tracking. Checkup.', 1);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(13, '2026-03-23', 'Stable.', 'None.', 'Checkup.', 3),
(13, '2026-03-24', 'Follow-up visit. Occasional stress-induced stomach ache.', 'Warm water, relaxation.', 'Continuous tracking. Psychosomatic factor.', 1),
(13, '2026-03-29', 'Occasional stress-induced stomach ache.', 'Warm water, relaxation.', 'Psychosomatic factor.', 2),
(13, '2026-03-29', 'Follow-up visit. Occasional stress-induced stomach ache.', 'Warm water, relaxation.', 'Continuous tracking. Psychosomatic factor.', 3),
(13, '2026-03-30', 'Occasional stress-induced stomach ache.', 'Warm water, relaxation.', 'Psychosomatic factor.', 2),
(13, '2026-04-03', 'Follow-up visit. No symptoms.', 'None.', 'Continuous tracking. Asymptomatic.', 1),
(13, '2026-04-03', 'No symptoms.', 'None.', 'Asymptomatic.', 3),
(13, '2026-04-05', 'Follow-up visit. No symptoms.', 'None.', 'Continuous tracking. Asymptomatic.', 3),
(13, '2026-04-05', 'No symptoms.', 'None.', 'Asymptomatic.', 2),
(13, '2026-04-09', 'Follow-up visit. Full recovery. Patient learned dietary triggers.', 'None.', 'Continuous tracking. Case closed.', 1);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(13, '2026-04-09', 'Full recovery. Patient learned dietary triggers.', 'None.', 'Case closed.', 2),
(13, '2026-04-09', 'Follow-up visit. Full recovery. Patient learned dietary triggers.', 'None.', 'Continuous tracking. Case closed.', 1),
(13, '2026-04-13', 'Full recovery. Patient learned dietary triggers.', 'None.', 'Case closed.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(14, '2025-12-22', 'Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Fungal skin infection. Non-infectious to others via touch.', 3),
(14, '2025-12-31', 'Follow-up visit. Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Continuous tracking. Fungal skin infection. Non-infectious to others via touch.', 3),
(14, '2026-01-03', 'Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Fungal skin infection. Non-infectious to others via touch.', 2),
(14, '2026-01-04', 'Follow-up visit. Itching significantly reduced. Redness fading.', 'Continue Cream for 7 more days. Do not scratch.', 'Continuous tracking. Partial resolution.', 3),
(14, '2026-01-05', 'Itching significantly reduced. Redness fading.', 'Continue Cream for 7 more days. Do not scratch.', 'Partial resolution.', 2),
(14, '2026-01-14', 'Follow-up visit. Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Continuous tracking. Healing.', 2),
(14, '2026-01-20', 'Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Healing.', 1),
(14, '2026-01-23', 'Follow-up visit. Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Continuous tracking. Healing.', 1),
(14, '2026-01-26', 'Skin cleared. Occasional itch when sweating.', 'Miconazole powder for shoes/socks.', 'Full recovery. Prevention advised.', 1),
(14, '2026-01-28', 'Follow-up visit. Skin cleared. Occasional itch when sweating.', 'Miconazole powder for shoes/socks.', 'Continuous tracking. Full recovery. Prevention advised.', 1);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(14, '2026-01-29', 'Stable skin.', 'None.', 'No active lesions.', 1),
(14, '2026-01-30', 'Follow-up visit. Stable skin.', 'None.', 'Continuous tracking. No active lesions.', 2),
(14, '2026-02-01', 'Stable skin.', 'None.', 'No active lesions.', 3),
(14, '2026-02-03', 'Follow-up visit. Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Continuous tracking. Reinforced hygiene counseling.', 2),
(14, '2026-02-08', 'Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Reinforced hygiene counseling.', 1),
(14, '2026-02-21', 'Follow-up visit. Cleared again.', 'None.', 'Continuous tracking. Successful re-treatment.', 1),
(14, '2026-02-25', 'Cleared again.', 'None.', 'Successful re-treatment.', 3),
(14, '2026-02-26', 'Follow-up visit. Cleared again.', 'None.', 'Continuous tracking. Successful re-treatment.', 2),
(14, '2026-03-08', 'Follow up. No new lesions.', 'None.', 'Clear.', 1),
(14, '2026-03-16', 'Follow-up visit. Follow up. No new lesions.', 'None.', 'Continuous tracking. Clear.', 1);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(14, '2026-03-17', 'Routine checkup.', 'None.', 'Stable.', 3),
(14, '2026-03-21', 'Follow-up visit. Routine checkup.', 'None.', 'Continuous tracking. Stable.', 2),
(14, '2026-04-06', 'Routine checkup.', 'None.', 'Stable.', 3),
(14, '2026-04-08', 'Follow-up visit. Healthy skin.', 'None.', 'Continuous tracking. Discharged from skin monitoring.', 3),
(14, '2026-04-09', 'Healthy skin.', 'None.', 'Discharged from skin monitoring.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(15, '2025-12-23', 'BP 150/90. Occasional nape pain after salty meals.', 'Amlodipine 5mg OD. Advised low-salt, low-fat diet.', 'Stage 1 Hypertension. OPD monitoring.', 1),
(15, '2025-12-29', 'Follow-up visit. BP 150/90. Occasional nape pain after salty meals.', 'Amlodipine 5mg OD. Advised low-salt, low-fat diet.', 'Continuous tracking. Stage 1 Hypertension. OPD monitoring.', 2),
(15, '2026-01-04', 'BP 150/90. Occasional nape pain after salty meals.', 'Amlodipine 5mg OD. Advised low-salt, low-fat diet.', 'Stage 1 Hypertension. OPD monitoring.', 1),
(15, '2026-01-12', 'Follow-up visit. BP 140/85. Nape pain reduced.', 'Continue Amlodipine. Provided diet chart.', 'Continuous tracking. Stabilizing. Patient compliant.', 1),
(15, '2026-01-14', 'BP 140/85. Nape pain reduced.', 'Continue Amlodipine. Provided diet chart.', 'Stabilizing. Patient compliant.', 1),
(15, '2026-01-22', 'Follow-up visit. BP 130/80. No complaints.', 'Maintain current meds.', 'Continuous tracking. Excellent BP control.', 1),
(15, '2026-01-26', 'BP 130/80. No complaints.', 'Maintain current meds.', 'Excellent BP control.', 2),
(15, '2026-02-12', 'Follow-up visit. BP 145/90. Reported eating at a fiesta.', 'Counseling on diet during holidays. Maintain meds.', 'Continuous tracking. Lifestyle-induced BP spike.', 2),
(15, '2026-02-23', 'BP 145/90. Reported eating at a fiesta.', 'Counseling on diet during holidays. Maintain meds.', 'Lifestyle-induced BP spike.', 2),
(15, '2026-02-23', 'Follow-up visit. BP 135/85. Feeling better.', 'Continue Amlodipine.', 'Continuous tracking. Return to baseline.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(15, '2026-02-24', 'BP 135/85. Feeling better.', 'Continue Amlodipine.', 'Return to baseline.', 2),
(15, '2026-02-27', 'Follow-up visit. BP 125/80. No dizziness.', 'Prescription refill for 2 months.', 'Continuous tracking. Stable maintenance.', 1),
(15, '2026-02-27', 'BP 125/80. No dizziness.', 'Prescription refill for 2 months.', 'Stable maintenance.', 1),
(15, '2026-02-28', 'Follow-up visit. BP 125/80. No dizziness.', 'Prescription refill for 2 months.', 'Continuous tracking. Stable maintenance.', 2),
(15, '2026-03-05', 'BP 120/80. Weight down by 1kg.', 'Encouraged walking 30 mins daily.', 'Good progress with exercise.', 2),
(15, '2026-03-07', 'Follow-up visit. BP 120/80. Weight down by 1kg.', 'Encouraged walking 30 mins daily.', 'Continuous tracking. Good progress with exercise.', 2),
(15, '2026-03-08', 'BP 128/82. Routine checkup.', 'None.', 'Still within target range.', 3),
(15, '2026-03-10', 'Follow-up visit. BP 128/82. Routine checkup.', 'None.', 'Continuous tracking. Still within target range.', 3),
(15, '2026-03-19', 'BP 130/80. Refill request.', 'Amlodipine refilled.', 'Maintenance check.', 1),
(15, '2026-03-20', 'Follow-up visit. BP 130/80. Refill request.', 'Amlodipine refilled.', 'Continuous tracking. Maintenance check.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(15, '2026-03-24', 'BP 120/80. No signs of retinopathy or edema.', 'Continue current plan.', 'Maintenance is effective.', 3),
(15, '2026-04-03', 'Follow-up visit. BP 120/80. No signs of retinopathy or edema.', 'Continue current plan.', 'Continuous tracking. Maintenance is effective.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(16, '2025-12-18', 'Burning sensation in the chest, sour taste in mouth.', 'Omeprazole 20mg OD (30 mins before breakfast). Avoid coffee/spicy food.', 'Suspected Acid Reflux (GERD).', 3),
(16, '2025-12-26', 'Follow-up visit. Burning sensation in the chest, sour taste in mouth.', 'Omeprazole 20mg OD (30 mins before breakfast). Avoid coffee/spicy food.', 'Continuous tracking. Suspected Acid Reflux (GERD).', 3),
(16, '2025-12-30', 'Burning sensation in the chest, sour taste in mouth.', 'Omeprazole 20mg OD (30 mins before breakfast). Avoid coffee/spicy food.', 'Suspected Acid Reflux (GERD).', 3),
(16, '2026-01-03', 'Follow-up visit. Feeling better. Reflux only happens when lying down after dinner.', 'Maintain Omeprazole. Advised not to lie down for 2 hrs after eating.', 'Continuous tracking. Lifestyle adjustment required.', 1),
(16, '2026-01-06', 'Feeling better. Reflux only happens when lying down after dinner.', 'Maintain Omeprazole. Advised not to lie down for 2 hrs after eating.', 'Lifestyle adjustment required.', 2),
(16, '2026-01-07', 'Follow-up visit. Stable. No heartburn.', 'Tapering Omeprazole to PRN.', 'Continuous tracking. Improving.', 3),
(16, '2026-01-10', 'Stable. No heartburn.', 'Tapering Omeprazole to PRN.', 'Improving.', 2),
(16, '2026-01-26', 'Follow-up visit. Mild bloating after eating gata dishes.', 'Simethicone PRN. Continue diet avoidance.', 'Continuous tracking. Dietary flare-up.', 3),
(16, '2026-02-04', 'Mild bloating after eating gata dishes.', 'Simethicone PRN. Continue diet avoidance.', 'Dietary flare-up.', 3),
(16, '2026-02-18', 'Follow-up visit. Bloating resolved.', 'Stay on bland diet for 3 days.', 'Continuous tracking. Managed.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(16, '2026-02-19', 'Bloating resolved.', 'Stay on bland diet for 3 days.', 'Managed.', 1),
(16, '2026-02-25', 'Follow-up visit. Feeling normal. No antacids needed for a week.', 'None.', 'Continuous tracking. Stable.', 3),
(16, '2026-02-26', 'Feeling normal. No antacids needed for a week.', 'None.', 'Stable.', 3),
(16, '2026-03-06', 'Follow-up visit. Feeling normal. No antacids needed for a week.', 'None.', 'Continuous tracking. Stable.', 2),
(16, '2026-03-08', 'Stable.', 'None.', 'Checkup.', 3),
(16, '2026-03-13', 'Follow-up visit. Stable.', 'None.', 'Continuous tracking. Checkup.', 2),
(16, '2026-03-19', 'Occasional stress-induced stomach ache.', 'Warm water, relaxation.', 'Psychosomatic factor.', 2),
(16, '2026-03-26', 'Follow-up visit. Occasional stress-induced stomach ache.', 'Warm water, relaxation.', 'Continuous tracking. Psychosomatic factor.', 1),
(16, '2026-04-01', 'No symptoms.', 'None.', 'Asymptomatic.', 2),
(16, '2026-04-07', 'Follow-up visit. No symptoms.', 'None.', 'Continuous tracking. Asymptomatic.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(16, '2026-04-10', 'Full recovery. Patient learned dietary triggers.', 'None.', 'Case closed.', 1),
(16, '2026-04-13', 'Follow-up visit. Full recovery. Patient learned dietary triggers.', 'None.', 'Continuous tracking. Case closed.', 1);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(17, '2025-12-15', 'Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Fungal skin infection. Non-infectious to others via touch.', 2),
(17, '2025-12-16', 'Follow-up visit. Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Continuous tracking. Fungal skin infection. Non-infectious to others via touch.', 3),
(17, '2025-12-21', 'Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Fungal skin infection. Non-infectious to others via touch.', 3),
(17, '2025-12-28', 'Follow-up visit. Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Continuous tracking. Fungal skin infection. Non-infectious to others via touch.', 1),
(17, '2026-01-05', 'Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Fungal skin infection. Non-infectious to others via touch.', 2),
(17, '2026-01-05', 'Follow-up visit. Itching significantly reduced. Redness fading.', 'Continue Cream for 7 more days. Do not scratch.', 'Continuous tracking. Partial resolution.', 2),
(17, '2026-01-10', 'Itching significantly reduced. Redness fading.', 'Continue Cream for 7 more days. Do not scratch.', 'Partial resolution.', 2),
(17, '2026-01-11', 'Follow-up visit. Itching significantly reduced. Redness fading.', 'Continue Cream for 7 more days. Do not scratch.', 'Continuous tracking. Partial resolution.', 3),
(17, '2026-01-12', 'Itching significantly reduced. Redness fading.', 'Continue Cream for 7 more days. Do not scratch.', 'Partial resolution.', 2),
(17, '2026-01-15', 'Follow-up visit. Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Continuous tracking. Healing.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(17, '2026-01-16', 'Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Healing.', 1),
(17, '2026-01-16', 'Follow-up visit. Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Continuous tracking. Healing.', 1),
(17, '2026-01-20', 'Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Healing.', 3),
(17, '2026-01-22', 'Follow-up visit. Skin cleared. Occasional itch when sweating.', 'Miconazole powder for shoes/socks.', 'Continuous tracking. Full recovery. Prevention advised.', 3),
(17, '2026-01-23', 'Skin cleared. Occasional itch when sweating.', 'Miconazole powder for shoes/socks.', 'Full recovery. Prevention advised.', 2),
(17, '2026-01-25', 'Follow-up visit. Skin cleared. Occasional itch when sweating.', 'Miconazole powder for shoes/socks.', 'Continuous tracking. Full recovery. Prevention advised.', 3),
(17, '2026-01-26', 'Skin cleared. Occasional itch when sweating.', 'Miconazole powder for shoes/socks.', 'Full recovery. Prevention advised.', 1),
(17, '2026-01-27', 'Follow-up visit. Stable skin.', 'None.', 'Continuous tracking. No active lesions.', 1),
(17, '2026-01-31', 'Stable skin.', 'None.', 'No active lesions.', 2),
(17, '2026-02-01', 'Follow-up visit. Stable skin.', 'None.', 'Continuous tracking. No active lesions.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(17, '2026-02-02', 'Stable skin.', 'None.', 'No active lesions.', 3),
(17, '2026-02-03', 'Follow-up visit. Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Continuous tracking. Reinforced hygiene counseling.', 1),
(17, '2026-02-06', 'Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Reinforced hygiene counseling.', 1),
(17, '2026-02-08', 'Follow-up visit. Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Continuous tracking. Reinforced hygiene counseling.', 3),
(17, '2026-02-11', 'Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Reinforced hygiene counseling.', 1),
(17, '2026-02-15', 'Follow-up visit. Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Continuous tracking. Reinforced hygiene counseling.', 2),
(17, '2026-02-16', 'Cleared again.', 'None.', 'Successful re-treatment.', 1),
(17, '2026-02-18', 'Follow-up visit. Cleared again.', 'None.', 'Continuous tracking. Successful re-treatment.', 3),
(17, '2026-02-18', 'Cleared again.', 'None.', 'Successful re-treatment.', 1),
(17, '2026-02-18', 'Follow-up visit. Cleared again.', 'None.', 'Continuous tracking. Successful re-treatment.', 1);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(17, '2026-02-27', 'Follow up. No new lesions.', 'None.', 'Clear.', 1),
(17, '2026-02-28', 'Follow-up visit. Follow up. No new lesions.', 'None.', 'Continuous tracking. Clear.', 1),
(17, '2026-03-01', 'Follow up. No new lesions.', 'None.', 'Clear.', 1),
(17, '2026-03-03', 'Follow-up visit. Follow up. No new lesions.', 'None.', 'Continuous tracking. Clear.', 2),
(17, '2026-03-03', 'Routine checkup.', 'None.', 'Stable.', 1),
(17, '2026-03-13', 'Follow-up visit. Routine checkup.', 'None.', 'Continuous tracking. Stable.', 2),
(17, '2026-03-13', 'Routine checkup.', 'None.', 'Stable.', 1),
(17, '2026-03-23', 'Follow-up visit. Routine checkup.', 'None.', 'Continuous tracking. Stable.', 3),
(17, '2026-03-25', 'Healthy skin.', 'None.', 'Discharged from skin monitoring.', 1),
(17, '2026-04-10', 'Follow-up visit. Healthy skin.', 'None.', 'Continuous tracking. Discharged from skin monitoring.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(17, '2026-04-11', 'Healthy skin.', 'None.', 'Discharged from skin monitoring.', 3),
(17, '2026-04-11', 'Follow-up visit. Healthy skin.', 'None.', 'Continuous tracking. Discharged from skin monitoring.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(18, '2025-12-17', 'Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Fungal skin infection. Non-infectious to others via touch.', 3),
(18, '2025-12-22', 'Follow-up visit. Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Continuous tracking. Fungal skin infection. Non-infectious to others via touch.', 1),
(18, '2026-01-03', 'Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Fungal skin infection. Non-infectious to others via touch.', 3),
(18, '2026-01-06', 'Follow-up visit. Itching significantly reduced. Redness fading.', 'Continue Cream for 7 more days. Do not scratch.', 'Continuous tracking. Partial resolution.', 3),
(18, '2026-01-10', 'Itching significantly reduced. Redness fading.', 'Continue Cream for 7 more days. Do not scratch.', 'Partial resolution.', 2),
(18, '2026-01-15', 'Follow-up visit. Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Continuous tracking. Healing.', 2),
(18, '2026-01-23', 'Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Healing.', 1),
(18, '2026-01-24', 'Follow-up visit. Skin cleared. Occasional itch when sweating.', 'Miconazole powder for shoes/socks.', 'Continuous tracking. Full recovery. Prevention advised.', 2),
(18, '2026-01-24', 'Skin cleared. Occasional itch when sweating.', 'Miconazole powder for shoes/socks.', 'Full recovery. Prevention advised.', 2),
(18, '2026-02-05', 'Follow-up visit. Skin cleared. Occasional itch when sweating.', 'Miconazole powder for shoes/socks.', 'Continuous tracking. Full recovery. Prevention advised.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(18, '2026-02-19', 'Stable skin.', 'None.', 'No active lesions.', 1),
(18, '2026-02-19', 'Follow-up visit. Stable skin.', 'None.', 'Continuous tracking. No active lesions.', 2),
(18, '2026-02-24', 'Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Reinforced hygiene counseling.', 3),
(18, '2026-03-10', 'Follow-up visit. Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Continuous tracking. Reinforced hygiene counseling.', 3),
(18, '2026-03-10', 'Cleared again.', 'None.', 'Successful re-treatment.', 1),
(18, '2026-03-12', 'Follow-up visit. Cleared again.', 'None.', 'Continuous tracking. Successful re-treatment.', 3),
(18, '2026-03-14', 'Cleared again.', 'None.', 'Successful re-treatment.', 3),
(18, '2026-03-23', 'Follow-up visit. Follow up. No new lesions.', 'None.', 'Continuous tracking. Clear.', 3),
(18, '2026-03-28', 'Follow up. No new lesions.', 'None.', 'Clear.', 2),
(18, '2026-03-29', 'Follow-up visit. Routine checkup.', 'None.', 'Continuous tracking. Stable.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(18, '2026-04-02', 'Routine checkup.', 'None.', 'Stable.', 2),
(18, '2026-04-04', 'Follow-up visit. Healthy skin.', 'None.', 'Continuous tracking. Discharged from skin monitoring.', 3),
(18, '2026-04-10', 'Healthy skin.', 'None.', 'Discharged from skin monitoring.', 1);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(19, '2025-12-15', 'Sneezing, runny nose, mild throat itchiness', 'Prescribed Cetirizine 10mg OD. Vitamin C 500mg. Drink plenty of water.', 'Likely viral upper respiratory infection. Rest advised.', 2),
(19, '2025-12-17', 'Follow-up visit. Sneezing, runny nose, mild throat itchiness', 'Prescribed Cetirizine 10mg OD. Vitamin C 500mg. Drink plenty of water.', 'Continuous tracking. Likely viral upper respiratory infection. Rest advised.', 1),
(19, '2025-12-17', 'Sneezing, runny nose, mild throat itchiness', 'Prescribed Cetirizine 10mg OD. Vitamin C 500mg. Drink plenty of water.', 'Likely viral upper respiratory infection. Rest advised.', 1),
(19, '2025-12-19', 'Follow-up visit. Sneezing, runny nose, mild throat itchiness', 'Prescribed Cetirizine 10mg OD. Vitamin C 500mg. Drink plenty of water.', 'Continuous tracking. Likely viral upper respiratory infection. Rest advised.', 3),
(19, '2025-12-22', 'Slight dry cough, no fever', 'Continue Vitamin C. Added Ambroxol 30mg TID for cough.', 'Patient feels slightly better.', 2),
(19, '2025-12-22', 'Follow-up visit. Slight dry cough, no fever', 'Continue Vitamin C. Added Ambroxol 30mg TID for cough.', 'Continuous tracking. Patient feels slightly better.', 1),
(19, '2025-12-24', 'Slight dry cough, no fever', 'Continue Vitamin C. Added Ambroxol 30mg TID for cough.', 'Patient feels slightly better.', 1),
(19, '2025-12-29', 'Follow-up visit. No symptoms. Routine vitamin refill', 'Refilled Multivitamins.', 'Continuous tracking. Recovery complete.', 1),
(19, '2026-01-07', 'No symptoms. Routine vitamin refill', 'Refilled Multivitamins.', 'Recovery complete.', 1),
(19, '2026-01-14', 'Follow-up visit. No symptoms. Routine vitamin refill', 'Refilled Multivitamins.', 'Continuous tracking. Recovery complete.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(19, '2026-01-17', 'Recurrence of symptoms after rainy travel: Feverish, sore throat', 'Paracetamol 500mg PRN. Gargle with warm salt water.', 'New episode of viral flu.', 3),
(19, '2026-01-20', 'Follow-up visit. Recurrence of symptoms after rainy travel: Feverish, sore throat', 'Paracetamol 500mg PRN. Gargle with warm salt water.', 'Continuous tracking. New episode of viral flu.', 2),
(19, '2026-01-20', 'Recurrence of symptoms after rainy travel: Feverish, sore throat', 'Paracetamol 500mg PRN. Gargle with warm salt water.', 'New episode of viral flu.', 3),
(19, '2026-01-20', 'Follow-up visit. Productive cough, yellowish phlegm', 'Amoxicillin 500mg TID for 7 days. Continue hydration.', 'Continuous tracking. Suspected mild secondary bacterial infection.', 1),
(19, '2026-01-20', 'Productive cough, yellowish phlegm', 'Amoxicillin 500mg TID for 7 days. Continue hydration.', 'Suspected mild secondary bacterial infection.', 1),
(19, '2026-01-21', 'Follow-up visit. Productive cough, yellowish phlegm', 'Amoxicillin 500mg TID for 7 days. Continue hydration.', 'Continuous tracking. Suspected mild secondary bacterial infection.', 1),
(19, '2026-01-29', 'Cough improving, still feels weak', 'Continue Antibiotics. Rest.', 'Compliance is good.', 1),
(19, '2026-01-31', 'Follow-up visit. Cough improving, still feels weak', 'Continue Antibiotics. Rest.', 'Continuous tracking. Compliance is good.', 2),
(19, '2026-01-31', 'Cough improving, still feels weak', 'Continue Antibiotics. Rest.', 'Compliance is good.', 2),
(19, '2026-02-04', 'Follow-up visit. Cough improving, still feels weak', 'Continue Antibiotics. Rest.', 'Continuous tracking. Compliance is good.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(19, '2026-02-05', 'Resolved. Throat clear.', 'Vitamins only.', 'Back to healthy baseline.', 3),
(19, '2026-02-06', 'Follow-up visit. Resolved. Throat clear.', 'Vitamins only.', 'Continuous tracking. Back to healthy baseline.', 3),
(19, '2026-02-15', 'Resolved. Throat clear.', 'Vitamins only.', 'Back to healthy baseline.', 3),
(19, '2026-03-09', 'Follow-up visit. Minor nasal congestion due to allergens', 'Loratadine 10mg OD.', 'Continuous tracking. Seasonal allergy management.', 1),
(19, '2026-03-14', 'Minor nasal congestion due to allergens', 'Loratadine 10mg OD.', 'Seasonal allergy management.', 2),
(19, '2026-03-15', 'Follow-up visit. Minor nasal congestion due to allergens', 'Loratadine 10mg OD.', 'Continuous tracking. Seasonal allergy management.', 3),
(19, '2026-03-15', 'Stable. Feeling well.', 'None.', 'Fully asymptomatic.', 3),
(19, '2026-03-16', 'Follow-up visit. Stable. Feeling well.', 'None.', 'Continuous tracking. Fully asymptomatic.', 3),
(19, '2026-03-18', 'Stable. Feeling well.', 'None.', 'Fully asymptomatic.', 1),
(19, '2026-03-27', 'Follow-up visit. Routine visit. Clean bill of health.', 'Stay hydrated.', 'Continuous tracking. Patient educated on flu prevention.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(19, '2026-03-30', 'Routine visit. Clean bill of health.', 'Stay hydrated.', 'Patient educated on flu prevention.', 1),
(19, '2026-03-31', 'Follow-up visit. Routine visit. Clean bill of health.', 'Stay hydrated.', 'Continuous tracking. Patient educated on flu prevention.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(20, '2025-12-18', 'BP 150/90. Occasional nape pain after salty meals.', 'Amlodipine 5mg OD. Advised low-salt, low-fat diet.', 'Stage 1 Hypertension. OPD monitoring.', 1),
(20, '2025-12-27', 'Follow-up visit. BP 150/90. Occasional nape pain after salty meals.', 'Amlodipine 5mg OD. Advised low-salt, low-fat diet.', 'Continuous tracking. Stage 1 Hypertension. OPD monitoring.', 1),
(20, '2025-12-29', 'BP 150/90. Occasional nape pain after salty meals.', 'Amlodipine 5mg OD. Advised low-salt, low-fat diet.', 'Stage 1 Hypertension. OPD monitoring.', 3),
(20, '2026-01-01', 'Follow-up visit. BP 140/85. Nape pain reduced.', 'Continue Amlodipine. Provided diet chart.', 'Continuous tracking. Stabilizing. Patient compliant.', 1),
(20, '2026-01-10', 'BP 140/85. Nape pain reduced.', 'Continue Amlodipine. Provided diet chart.', 'Stabilizing. Patient compliant.', 3),
(20, '2026-01-12', 'Follow-up visit. BP 130/80. No complaints.', 'Maintain current meds.', 'Continuous tracking. Excellent BP control.', 3),
(20, '2026-01-21', 'BP 130/80. No complaints.', 'Maintain current meds.', 'Excellent BP control.', 2),
(20, '2026-01-28', 'Follow-up visit. BP 145/90. Reported eating at a fiesta.', 'Counseling on diet during holidays. Maintain meds.', 'Continuous tracking. Lifestyle-induced BP spike.', 2),
(20, '2026-02-02', 'BP 145/90. Reported eating at a fiesta.', 'Counseling on diet during holidays. Maintain meds.', 'Lifestyle-induced BP spike.', 1),
(20, '2026-02-10', 'Follow-up visit. BP 135/85. Feeling better.', 'Continue Amlodipine.', 'Continuous tracking. Return to baseline.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(20, '2026-02-10', 'BP 135/85. Feeling better.', 'Continue Amlodipine.', 'Return to baseline.', 2),
(20, '2026-02-12', 'Follow-up visit. BP 125/80. No dizziness.', 'Prescription refill for 2 months.', 'Continuous tracking. Stable maintenance.', 1),
(20, '2026-02-17', 'BP 125/80. No dizziness.', 'Prescription refill for 2 months.', 'Stable maintenance.', 1),
(20, '2026-02-23', 'Follow-up visit. BP 125/80. No dizziness.', 'Prescription refill for 2 months.', 'Continuous tracking. Stable maintenance.', 1),
(20, '2026-02-28', 'BP 120/80. Weight down by 1kg.', 'Encouraged walking 30 mins daily.', 'Good progress with exercise.', 3),
(20, '2026-03-02', 'Follow-up visit. BP 120/80. Weight down by 1kg.', 'Encouraged walking 30 mins daily.', 'Continuous tracking. Good progress with exercise.', 3),
(20, '2026-03-11', 'BP 128/82. Routine checkup.', 'None.', 'Still within target range.', 2),
(20, '2026-03-11', 'Follow-up visit. BP 128/82. Routine checkup.', 'None.', 'Continuous tracking. Still within target range.', 3),
(20, '2026-03-12', 'BP 130/80. Refill request.', 'Amlodipine refilled.', 'Maintenance check.', 2),
(20, '2026-03-19', 'Follow-up visit. BP 130/80. Refill request.', 'Amlodipine refilled.', 'Continuous tracking. Maintenance check.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(20, '2026-03-21', 'BP 120/80. No signs of retinopathy or edema.', 'Continue current plan.', 'Maintenance is effective.', 3),
(20, '2026-04-05', 'Follow-up visit. BP 120/80. No signs of retinopathy or edema.', 'Continue current plan.', 'Continuous tracking. Maintenance is effective.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(21, '2025-12-16', 'Burning sensation in the chest, sour taste in mouth.', 'Omeprazole 20mg OD (30 mins before breakfast). Avoid coffee/spicy food.', 'Suspected Acid Reflux (GERD).', 2),
(21, '2025-12-16', 'Follow-up visit. Burning sensation in the chest, sour taste in mouth.', 'Omeprazole 20mg OD (30 mins before breakfast). Avoid coffee/spicy food.', 'Continuous tracking. Suspected Acid Reflux (GERD).', 1),
(21, '2025-12-16', 'Burning sensation in the chest, sour taste in mouth.', 'Omeprazole 20mg OD (30 mins before breakfast). Avoid coffee/spicy food.', 'Suspected Acid Reflux (GERD).', 2),
(21, '2025-12-22', 'Follow-up visit. Burning sensation in the chest, sour taste in mouth.', 'Omeprazole 20mg OD (30 mins before breakfast). Avoid coffee/spicy food.', 'Continuous tracking. Suspected Acid Reflux (GERD).', 3),
(21, '2025-12-22', 'Feeling better. Reflux only happens when lying down after dinner.', 'Maintain Omeprazole. Advised not to lie down for 2 hrs after eating.', 'Lifestyle adjustment required.', 2),
(21, '2025-12-25', 'Follow-up visit. Feeling better. Reflux only happens when lying down after dinner.', 'Maintain Omeprazole. Advised not to lie down for 2 hrs after eating.', 'Continuous tracking. Lifestyle adjustment required.', 3),
(21, '2025-12-27', 'Feeling better. Reflux only happens when lying down after dinner.', 'Maintain Omeprazole. Advised not to lie down for 2 hrs after eating.', 'Lifestyle adjustment required.', 2),
(21, '2025-12-29', 'Follow-up visit. Stable. No heartburn.', 'Tapering Omeprazole to PRN.', 'Continuous tracking. Improving.', 1),
(21, '2026-01-11', 'Stable. No heartburn.', 'Tapering Omeprazole to PRN.', 'Improving.', 3),
(21, '2026-01-15', 'Follow-up visit. Stable. No heartburn.', 'Tapering Omeprazole to PRN.', 'Continuous tracking. Improving.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(21, '2026-01-16', 'Stable. No heartburn.', 'Tapering Omeprazole to PRN.', 'Improving.', 2),
(21, '2026-01-22', 'Follow-up visit. Mild bloating after eating gata dishes.', 'Simethicone PRN. Continue diet avoidance.', 'Continuous tracking. Dietary flare-up.', 3),
(21, '2026-01-26', 'Mild bloating after eating gata dishes.', 'Simethicone PRN. Continue diet avoidance.', 'Dietary flare-up.', 2),
(21, '2026-01-27', 'Follow-up visit. Mild bloating after eating gata dishes.', 'Simethicone PRN. Continue diet avoidance.', 'Continuous tracking. Dietary flare-up.', 3),
(21, '2026-02-03', 'Bloating resolved.', 'Stay on bland diet for 3 days.', 'Managed.', 3),
(21, '2026-02-03', 'Follow-up visit. Bloating resolved.', 'Stay on bland diet for 3 days.', 'Continuous tracking. Managed.', 2),
(21, '2026-02-10', 'Bloating resolved.', 'Stay on bland diet for 3 days.', 'Managed.', 1),
(21, '2026-02-11', 'Follow-up visit. Bloating resolved.', 'Stay on bland diet for 3 days.', 'Continuous tracking. Managed.', 2),
(21, '2026-02-11', 'Feeling normal. No antacids needed for a week.', 'None.', 'Stable.', 2),
(21, '2026-02-12', 'Follow-up visit. Feeling normal. No antacids needed for a week.', 'None.', 'Continuous tracking. Stable.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(21, '2026-02-14', 'Feeling normal. No antacids needed for a week.', 'None.', 'Stable.', 2),
(21, '2026-02-22', 'Follow-up visit. Stable.', 'None.', 'Continuous tracking. Checkup.', 1),
(21, '2026-02-26', 'Stable.', 'None.', 'Checkup.', 2),
(21, '2026-03-08', 'Follow-up visit. Stable.', 'None.', 'Continuous tracking. Checkup.', 1),
(21, '2026-03-09', 'Stable.', 'None.', 'Checkup.', 3),
(21, '2026-03-12', 'Follow-up visit. Occasional stress-induced stomach ache.', 'Warm water, relaxation.', 'Continuous tracking. Psychosomatic factor.', 3),
(21, '2026-03-16', 'Occasional stress-induced stomach ache.', 'Warm water, relaxation.', 'Psychosomatic factor.', 1),
(21, '2026-03-19', 'Follow-up visit. Occasional stress-induced stomach ache.', 'Warm water, relaxation.', 'Continuous tracking. Psychosomatic factor.', 3),
(21, '2026-03-22', 'No symptoms.', 'None.', 'Asymptomatic.', 2),
(21, '2026-03-23', 'Follow-up visit. No symptoms.', 'None.', 'Continuous tracking. Asymptomatic.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(21, '2026-03-28', 'No symptoms.', 'None.', 'Asymptomatic.', 3),
(21, '2026-03-30', 'Follow-up visit. No symptoms.', 'None.', 'Continuous tracking. Asymptomatic.', 1),
(21, '2026-04-01', 'Full recovery. Patient learned dietary triggers.', 'None.', 'Case closed.', 3),
(21, '2026-04-02', 'Follow-up visit. Full recovery. Patient learned dietary triggers.', 'None.', 'Continuous tracking. Case closed.', 1),
(21, '2026-04-05', 'Full recovery. Patient learned dietary triggers.', 'None.', 'Case closed.', 1);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(22, '2025-12-16', 'Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Fungal skin infection. Non-infectious to others via touch.', 3),
(22, '2025-12-17', 'Follow-up visit. Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Continuous tracking. Fungal skin infection. Non-infectious to others via touch.', 2),
(22, '2025-12-17', 'Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Fungal skin infection. Non-infectious to others via touch.', 3),
(22, '2025-12-31', 'Follow-up visit. Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Continuous tracking. Fungal skin infection. Non-infectious to others via touch.', 3),
(22, '2025-12-31', 'Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Fungal skin infection. Non-infectious to others via touch.', 2),
(22, '2026-01-02', 'Follow-up visit. Itching significantly reduced. Redness fading.', 'Continue Cream for 7 more days. Do not scratch.', 'Continuous tracking. Partial resolution.', 2),
(22, '2026-01-03', 'Itching significantly reduced. Redness fading.', 'Continue Cream for 7 more days. Do not scratch.', 'Partial resolution.', 1),
(22, '2026-01-05', 'Follow-up visit. Itching significantly reduced. Redness fading.', 'Continue Cream for 7 more days. Do not scratch.', 'Continuous tracking. Partial resolution.', 1),
(22, '2026-01-10', 'Itching significantly reduced. Redness fading.', 'Continue Cream for 7 more days. Do not scratch.', 'Partial resolution.', 1),
(22, '2026-01-11', 'Follow-up visit. Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Continuous tracking. Healing.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(22, '2026-01-12', 'Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Healing.', 2),
(22, '2026-01-18', 'Follow-up visit. Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Continuous tracking. Healing.', 3),
(22, '2026-01-19', 'Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Healing.', 2),
(22, '2026-01-20', 'Follow-up visit. Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Continuous tracking. Healing.', 3),
(22, '2026-01-22', 'Skin cleared. Occasional itch when sweating.', 'Miconazole powder for shoes/socks.', 'Full recovery. Prevention advised.', 3),
(22, '2026-01-23', 'Follow-up visit. Skin cleared. Occasional itch when sweating.', 'Miconazole powder for shoes/socks.', 'Continuous tracking. Full recovery. Prevention advised.', 2),
(22, '2026-01-23', 'Skin cleared. Occasional itch when sweating.', 'Miconazole powder for shoes/socks.', 'Full recovery. Prevention advised.', 3),
(22, '2026-01-27', 'Follow-up visit. Skin cleared. Occasional itch when sweating.', 'Miconazole powder for shoes/socks.', 'Continuous tracking. Full recovery. Prevention advised.', 2),
(22, '2026-01-30', 'Stable skin.', 'None.', 'No active lesions.', 2),
(22, '2026-01-31', 'Follow-up visit. Stable skin.', 'None.', 'Continuous tracking. No active lesions.', 1);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(22, '2026-02-01', 'Stable skin.', 'None.', 'No active lesions.', 1),
(22, '2026-02-06', 'Follow-up visit. Stable skin.', 'None.', 'Continuous tracking. No active lesions.', 1),
(22, '2026-02-06', 'Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Reinforced hygiene counseling.', 3),
(22, '2026-02-10', 'Follow-up visit. Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Continuous tracking. Reinforced hygiene counseling.', 1),
(22, '2026-02-11', 'Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Reinforced hygiene counseling.', 2),
(22, '2026-02-11', 'Follow-up visit. Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Continuous tracking. Reinforced hygiene counseling.', 3),
(22, '2026-02-11', 'Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Reinforced hygiene counseling.', 3),
(22, '2026-02-12', 'Follow-up visit. Cleared again.', 'None.', 'Continuous tracking. Successful re-treatment.', 2),
(22, '2026-02-16', 'Cleared again.', 'None.', 'Successful re-treatment.', 1),
(22, '2026-02-22', 'Follow-up visit. Cleared again.', 'None.', 'Continuous tracking. Successful re-treatment.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(22, '2026-02-25', 'Cleared again.', 'None.', 'Successful re-treatment.', 1),
(22, '2026-02-28', 'Follow-up visit. Follow up. No new lesions.', 'None.', 'Continuous tracking. Clear.', 2),
(22, '2026-03-04', 'Follow up. No new lesions.', 'None.', 'Clear.', 3),
(22, '2026-03-04', 'Follow-up visit. Follow up. No new lesions.', 'None.', 'Continuous tracking. Clear.', 2),
(22, '2026-03-07', 'Follow up. No new lesions.', 'None.', 'Clear.', 1),
(22, '2026-03-07', 'Follow-up visit. Follow up. No new lesions.', 'None.', 'Continuous tracking. Clear.', 1),
(22, '2026-03-10', 'Routine checkup.', 'None.', 'Stable.', 2),
(22, '2026-03-13', 'Follow-up visit. Routine checkup.', 'None.', 'Continuous tracking. Stable.', 3),
(22, '2026-03-22', 'Routine checkup.', 'None.', 'Stable.', 3),
(22, '2026-03-22', 'Follow-up visit. Routine checkup.', 'None.', 'Continuous tracking. Stable.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(22, '2026-03-23', 'Healthy skin.', 'None.', 'Discharged from skin monitoring.', 3),
(22, '2026-03-27', 'Follow-up visit. Healthy skin.', 'None.', 'Continuous tracking. Discharged from skin monitoring.', 3),
(22, '2026-04-11', 'Healthy skin.', 'None.', 'Discharged from skin monitoring.', 1),
(22, '2026-04-12', 'Follow-up visit. Healthy skin.', 'None.', 'Continuous tracking. Discharged from skin monitoring.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(23, '2025-12-14', 'BP 150/90. Occasional nape pain after salty meals.', 'Amlodipine 5mg OD. Advised low-salt, low-fat diet.', 'Stage 1 Hypertension. OPD monitoring.', 2),
(23, '2025-12-15', 'Follow-up visit. BP 150/90. Occasional nape pain after salty meals.', 'Amlodipine 5mg OD. Advised low-salt, low-fat diet.', 'Continuous tracking. Stage 1 Hypertension. OPD monitoring.', 1),
(23, '2025-12-15', 'BP 150/90. Occasional nape pain after salty meals.', 'Amlodipine 5mg OD. Advised low-salt, low-fat diet.', 'Stage 1 Hypertension. OPD monitoring.', 3),
(23, '2025-12-18', 'Follow-up visit. BP 150/90. Occasional nape pain after salty meals.', 'Amlodipine 5mg OD. Advised low-salt, low-fat diet.', 'Continuous tracking. Stage 1 Hypertension. OPD monitoring.', 2),
(23, '2025-12-19', 'BP 150/90. Occasional nape pain after salty meals.', 'Amlodipine 5mg OD. Advised low-salt, low-fat diet.', 'Stage 1 Hypertension. OPD monitoring.', 1),
(23, '2025-12-21', 'Follow-up visit. BP 140/85. Nape pain reduced.', 'Continue Amlodipine. Provided diet chart.', 'Continuous tracking. Stabilizing. Patient compliant.', 2),
(23, '2025-12-23', 'BP 140/85. Nape pain reduced.', 'Continue Amlodipine. Provided diet chart.', 'Stabilizing. Patient compliant.', 1),
(23, '2025-12-27', 'Follow-up visit. BP 140/85. Nape pain reduced.', 'Continue Amlodipine. Provided diet chart.', 'Continuous tracking. Stabilizing. Patient compliant.', 3),
(23, '2025-12-31', 'BP 140/85. Nape pain reduced.', 'Continue Amlodipine. Provided diet chart.', 'Stabilizing. Patient compliant.', 2),
(23, '2025-12-31', 'Follow-up visit. BP 130/80. No complaints.', 'Maintain current meds.', 'Continuous tracking. Excellent BP control.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(23, '2026-01-01', 'BP 130/80. No complaints.', 'Maintain current meds.', 'Excellent BP control.', 3),
(23, '2026-01-05', 'Follow-up visit. BP 130/80. No complaints.', 'Maintain current meds.', 'Continuous tracking. Excellent BP control.', 2),
(23, '2026-01-14', 'BP 130/80. No complaints.', 'Maintain current meds.', 'Excellent BP control.', 1),
(23, '2026-01-16', 'Follow-up visit. BP 145/90. Reported eating at a fiesta.', 'Counseling on diet during holidays. Maintain meds.', 'Continuous tracking. Lifestyle-induced BP spike.', 2),
(23, '2026-01-17', 'BP 145/90. Reported eating at a fiesta.', 'Counseling on diet during holidays. Maintain meds.', 'Lifestyle-induced BP spike.', 2),
(23, '2026-01-22', 'Follow-up visit. BP 145/90. Reported eating at a fiesta.', 'Counseling on diet during holidays. Maintain meds.', 'Continuous tracking. Lifestyle-induced BP spike.', 3),
(23, '2026-01-27', 'BP 145/90. Reported eating at a fiesta.', 'Counseling on diet during holidays. Maintain meds.', 'Lifestyle-induced BP spike.', 1),
(23, '2026-01-28', 'Follow-up visit. BP 145/90. Reported eating at a fiesta.', 'Counseling on diet during holidays. Maintain meds.', 'Continuous tracking. Lifestyle-induced BP spike.', 2),
(23, '2026-01-31', 'BP 135/85. Feeling better.', 'Continue Amlodipine.', 'Return to baseline.', 3),
(23, '2026-02-06', 'Follow-up visit. BP 135/85. Feeling better.', 'Continue Amlodipine.', 'Continuous tracking. Return to baseline.', 1);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(23, '2026-02-06', 'BP 135/85. Feeling better.', 'Continue Amlodipine.', 'Return to baseline.', 1),
(23, '2026-02-11', 'Follow-up visit. BP 135/85. Feeling better.', 'Continue Amlodipine.', 'Continuous tracking. Return to baseline.', 3),
(23, '2026-02-15', 'BP 125/80. No dizziness.', 'Prescription refill for 2 months.', 'Stable maintenance.', 2),
(23, '2026-02-16', 'Follow-up visit. BP 125/80. No dizziness.', 'Prescription refill for 2 months.', 'Continuous tracking. Stable maintenance.', 2),
(23, '2026-02-17', 'BP 125/80. No dizziness.', 'Prescription refill for 2 months.', 'Stable maintenance.', 1),
(23, '2026-02-23', 'Follow-up visit. BP 125/80. No dizziness.', 'Prescription refill for 2 months.', 'Continuous tracking. Stable maintenance.', 1),
(23, '2026-02-26', 'BP 120/80. Weight down by 1kg.', 'Encouraged walking 30 mins daily.', 'Good progress with exercise.', 3),
(23, '2026-03-01', 'Follow-up visit. BP 120/80. Weight down by 1kg.', 'Encouraged walking 30 mins daily.', 'Continuous tracking. Good progress with exercise.', 1),
(23, '2026-03-02', 'BP 120/80. Weight down by 1kg.', 'Encouraged walking 30 mins daily.', 'Good progress with exercise.', 2),
(23, '2026-03-02', 'Follow-up visit. BP 120/80. Weight down by 1kg.', 'Encouraged walking 30 mins daily.', 'Continuous tracking. Good progress with exercise.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(23, '2026-03-03', 'BP 120/80. Weight down by 1kg.', 'Encouraged walking 30 mins daily.', 'Good progress with exercise.', 3),
(23, '2026-03-05', 'Follow-up visit. BP 128/82. Routine checkup.', 'None.', 'Continuous tracking. Still within target range.', 1),
(23, '2026-03-06', 'BP 128/82. Routine checkup.', 'None.', 'Still within target range.', 3),
(23, '2026-03-12', 'Follow-up visit. BP 128/82. Routine checkup.', 'None.', 'Continuous tracking. Still within target range.', 2),
(23, '2026-03-14', 'BP 128/82. Routine checkup.', 'None.', 'Still within target range.', 3),
(23, '2026-03-18', 'Follow-up visit. BP 130/80. Refill request.', 'Amlodipine refilled.', 'Continuous tracking. Maintenance check.', 1),
(23, '2026-03-23', 'BP 130/80. Refill request.', 'Amlodipine refilled.', 'Maintenance check.', 1),
(23, '2026-03-25', 'Follow-up visit. BP 130/80. Refill request.', 'Amlodipine refilled.', 'Continuous tracking. Maintenance check.', 2),
(23, '2026-04-03', 'BP 130/80. Refill request.', 'Amlodipine refilled.', 'Maintenance check.', 1),
(23, '2026-04-04', 'Follow-up visit. BP 120/80. No signs of retinopathy or edema.', 'Continue current plan.', 'Continuous tracking. Maintenance is effective.', 1);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(23, '2026-04-07', 'BP 120/80. No signs of retinopathy or edema.', 'Continue current plan.', 'Maintenance is effective.', 1),
(23, '2026-04-09', 'Follow-up visit. BP 120/80. No signs of retinopathy or edema.', 'Continue current plan.', 'Continuous tracking. Maintenance is effective.', 1),
(23, '2026-04-10', 'BP 120/80. No signs of retinopathy or edema.', 'Continue current plan.', 'Maintenance is effective.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(24, '2025-12-14', 'Sneezing, runny nose, mild throat itchiness', 'Prescribed Cetirizine 10mg OD. Vitamin C 500mg. Drink plenty of water.', 'Likely viral upper respiratory infection. Rest advised.', 2),
(24, '2025-12-15', 'Follow-up visit. Sneezing, runny nose, mild throat itchiness', 'Prescribed Cetirizine 10mg OD. Vitamin C 500mg. Drink plenty of water.', 'Continuous tracking. Likely viral upper respiratory infection. Rest advised.', 1),
(24, '2025-12-19', 'Sneezing, runny nose, mild throat itchiness', 'Prescribed Cetirizine 10mg OD. Vitamin C 500mg. Drink plenty of water.', 'Likely viral upper respiratory infection. Rest advised.', 3),
(24, '2025-12-27', 'Follow-up visit. Slight dry cough, no fever', 'Continue Vitamin C. Added Ambroxol 30mg TID for cough.', 'Continuous tracking. Patient feels slightly better.', 3),
(24, '2026-01-05', 'Slight dry cough, no fever', 'Continue Vitamin C. Added Ambroxol 30mg TID for cough.', 'Patient feels slightly better.', 2),
(24, '2026-01-11', 'Follow-up visit. Slight dry cough, no fever', 'Continue Vitamin C. Added Ambroxol 30mg TID for cough.', 'Continuous tracking. Patient feels slightly better.', 1),
(24, '2026-01-11', 'No symptoms. Routine vitamin refill', 'Refilled Multivitamins.', 'Recovery complete.', 2),
(24, '2026-01-21', 'Follow-up visit. No symptoms. Routine vitamin refill', 'Refilled Multivitamins.', 'Continuous tracking. Recovery complete.', 2),
(24, '2026-01-24', 'No symptoms. Routine vitamin refill', 'Refilled Multivitamins.', 'Recovery complete.', 3),
(24, '2026-02-05', 'Follow-up visit. Recurrence of symptoms after rainy travel: Feverish, sore throat', 'Paracetamol 500mg PRN. Gargle with warm salt water.', 'Continuous tracking. New episode of viral flu.', 1);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(24, '2026-02-10', 'Recurrence of symptoms after rainy travel: Feverish, sore throat', 'Paracetamol 500mg PRN. Gargle with warm salt water.', 'New episode of viral flu.', 3),
(24, '2026-02-23', 'Follow-up visit. Recurrence of symptoms after rainy travel: Feverish, sore throat', 'Paracetamol 500mg PRN. Gargle with warm salt water.', 'Continuous tracking. New episode of viral flu.', 1),
(24, '2026-02-25', 'Productive cough, yellowish phlegm', 'Amoxicillin 500mg TID for 7 days. Continue hydration.', 'Suspected mild secondary bacterial infection.', 2),
(24, '2026-02-25', 'Follow-up visit. Productive cough, yellowish phlegm', 'Amoxicillin 500mg TID for 7 days. Continue hydration.', 'Continuous tracking. Suspected mild secondary bacterial infection.', 1),
(24, '2026-03-01', 'Cough improving, still feels weak', 'Continue Antibiotics. Rest.', 'Compliance is good.', 1),
(24, '2026-03-01', 'Follow-up visit. Cough improving, still feels weak', 'Continue Antibiotics. Rest.', 'Continuous tracking. Compliance is good.', 2),
(24, '2026-03-02', 'Cough improving, still feels weak', 'Continue Antibiotics. Rest.', 'Compliance is good.', 2),
(24, '2026-03-13', 'Follow-up visit. Resolved. Throat clear.', 'Vitamins only.', 'Continuous tracking. Back to healthy baseline.', 1),
(24, '2026-03-14', 'Resolved. Throat clear.', 'Vitamins only.', 'Back to healthy baseline.', 2),
(24, '2026-03-17', 'Follow-up visit. Resolved. Throat clear.', 'Vitamins only.', 'Continuous tracking. Back to healthy baseline.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(24, '2026-03-27', 'Minor nasal congestion due to allergens', 'Loratadine 10mg OD.', 'Seasonal allergy management.', 2),
(24, '2026-03-28', 'Follow-up visit. Minor nasal congestion due to allergens', 'Loratadine 10mg OD.', 'Continuous tracking. Seasonal allergy management.', 3),
(24, '2026-03-30', 'Minor nasal congestion due to allergens', 'Loratadine 10mg OD.', 'Seasonal allergy management.', 1),
(24, '2026-03-31', 'Follow-up visit. Stable. Feeling well.', 'None.', 'Continuous tracking. Fully asymptomatic.', 1),
(24, '2026-04-02', 'Stable. Feeling well.', 'None.', 'Fully asymptomatic.', 1),
(24, '2026-04-03', 'Follow-up visit. Stable. Feeling well.', 'None.', 'Continuous tracking. Fully asymptomatic.', 3),
(24, '2026-04-11', 'Routine visit. Clean bill of health.', 'Stay hydrated.', 'Patient educated on flu prevention.', 2),
(24, '2026-04-13', 'Follow-up visit. Routine visit. Clean bill of health.', 'Stay hydrated.', 'Continuous tracking. Patient educated on flu prevention.', 1);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(25, '2025-12-20', 'Burning sensation in the chest, sour taste in mouth.', 'Omeprazole 20mg OD (30 mins before breakfast). Avoid coffee/spicy food.', 'Suspected Acid Reflux (GERD).', 2),
(25, '2025-12-26', 'Follow-up visit. Burning sensation in the chest, sour taste in mouth.', 'Omeprazole 20mg OD (30 mins before breakfast). Avoid coffee/spicy food.', 'Continuous tracking. Suspected Acid Reflux (GERD).', 1),
(25, '2025-12-29', 'Burning sensation in the chest, sour taste in mouth.', 'Omeprazole 20mg OD (30 mins before breakfast). Avoid coffee/spicy food.', 'Suspected Acid Reflux (GERD).', 1),
(25, '2025-12-30', 'Follow-up visit. Burning sensation in the chest, sour taste in mouth.', 'Omeprazole 20mg OD (30 mins before breakfast). Avoid coffee/spicy food.', 'Continuous tracking. Suspected Acid Reflux (GERD).', 2),
(25, '2026-01-05', 'Feeling better. Reflux only happens when lying down after dinner.', 'Maintain Omeprazole. Advised not to lie down for 2 hrs after eating.', 'Lifestyle adjustment required.', 2),
(25, '2026-01-07', 'Follow-up visit. Feeling better. Reflux only happens when lying down after dinner.', 'Maintain Omeprazole. Advised not to lie down for 2 hrs after eating.', 'Continuous tracking. Lifestyle adjustment required.', 2),
(25, '2026-01-07', 'Feeling better. Reflux only happens when lying down after dinner.', 'Maintain Omeprazole. Advised not to lie down for 2 hrs after eating.', 'Lifestyle adjustment required.', 2),
(25, '2026-01-09', 'Follow-up visit. Feeling better. Reflux only happens when lying down after dinner.', 'Maintain Omeprazole. Advised not to lie down for 2 hrs after eating.', 'Continuous tracking. Lifestyle adjustment required.', 1),
(25, '2026-01-10', 'Stable. No heartburn.', 'Tapering Omeprazole to PRN.', 'Improving.', 2),
(25, '2026-01-14', 'Follow-up visit. Stable. No heartburn.', 'Tapering Omeprazole to PRN.', 'Continuous tracking. Improving.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(25, '2026-01-15', 'Stable. No heartburn.', 'Tapering Omeprazole to PRN.', 'Improving.', 3),
(25, '2026-01-17', 'Follow-up visit. Stable. No heartburn.', 'Tapering Omeprazole to PRN.', 'Continuous tracking. Improving.', 2),
(25, '2026-01-19', 'Mild bloating after eating gata dishes.', 'Simethicone PRN. Continue diet avoidance.', 'Dietary flare-up.', 1),
(25, '2026-01-21', 'Follow-up visit. Mild bloating after eating gata dishes.', 'Simethicone PRN. Continue diet avoidance.', 'Continuous tracking. Dietary flare-up.', 1),
(25, '2026-01-22', 'Mild bloating after eating gata dishes.', 'Simethicone PRN. Continue diet avoidance.', 'Dietary flare-up.', 3),
(25, '2026-02-03', 'Follow-up visit. Mild bloating after eating gata dishes.', 'Simethicone PRN. Continue diet avoidance.', 'Continuous tracking. Dietary flare-up.', 2),
(25, '2026-02-07', 'Bloating resolved.', 'Stay on bland diet for 3 days.', 'Managed.', 3),
(25, '2026-02-07', 'Follow-up visit. Bloating resolved.', 'Stay on bland diet for 3 days.', 'Continuous tracking. Managed.', 2),
(25, '2026-02-11', 'Bloating resolved.', 'Stay on bland diet for 3 days.', 'Managed.', 1),
(25, '2026-02-14', 'Follow-up visit. Feeling normal. No antacids needed for a week.', 'None.', 'Continuous tracking. Stable.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(25, '2026-02-17', 'Feeling normal. No antacids needed for a week.', 'None.', 'Stable.', 3),
(25, '2026-02-17', 'Follow-up visit. Feeling normal. No antacids needed for a week.', 'None.', 'Continuous tracking. Stable.', 2),
(25, '2026-03-01', 'Feeling normal. No antacids needed for a week.', 'None.', 'Stable.', 3),
(25, '2026-03-04', 'Follow-up visit. Stable.', 'None.', 'Continuous tracking. Checkup.', 1),
(25, '2026-03-11', 'Stable.', 'None.', 'Checkup.', 2),
(25, '2026-03-11', 'Follow-up visit. Stable.', 'None.', 'Continuous tracking. Checkup.', 1),
(25, '2026-03-18', 'Stable.', 'None.', 'Checkup.', 3),
(25, '2026-03-18', 'Follow-up visit. Occasional stress-induced stomach ache.', 'Warm water, relaxation.', 'Continuous tracking. Psychosomatic factor.', 2),
(25, '2026-03-19', 'Occasional stress-induced stomach ache.', 'Warm water, relaxation.', 'Psychosomatic factor.', 3),
(25, '2026-03-25', 'Follow-up visit. Occasional stress-induced stomach ache.', 'Warm water, relaxation.', 'Continuous tracking. Psychosomatic factor.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(25, '2026-03-28', 'Occasional stress-induced stomach ache.', 'Warm water, relaxation.', 'Psychosomatic factor.', 2),
(25, '2026-03-28', 'Follow-up visit. No symptoms.', 'None.', 'Continuous tracking. Asymptomatic.', 1),
(25, '2026-03-29', 'No symptoms.', 'None.', 'Asymptomatic.', 2),
(25, '2026-03-30', 'Follow-up visit. No symptoms.', 'None.', 'Continuous tracking. Asymptomatic.', 1),
(25, '2026-04-05', 'No symptoms.', 'None.', 'Asymptomatic.', 2),
(25, '2026-04-06', 'Follow-up visit. Full recovery. Patient learned dietary triggers.', 'None.', 'Continuous tracking. Case closed.', 3),
(25, '2026-04-10', 'Full recovery. Patient learned dietary triggers.', 'None.', 'Case closed.', 2),
(25, '2026-04-12', 'Follow-up visit. Full recovery. Patient learned dietary triggers.', 'None.', 'Continuous tracking. Case closed.', 1);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(26, '2025-12-16', 'Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Fungal skin infection. Non-infectious to others via touch.', 2),
(26, '2025-12-29', 'Follow-up visit. Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Continuous tracking. Fungal skin infection. Non-infectious to others via touch.', 3),
(26, '2026-01-03', 'Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Fungal skin infection. Non-infectious to others via touch.', 1),
(26, '2026-01-04', 'Follow-up visit. Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Continuous tracking. Fungal skin infection. Non-infectious to others via touch.', 1),
(26, '2026-01-04', 'Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Fungal skin infection. Non-infectious to others via touch.', 2),
(26, '2026-01-04', 'Follow-up visit. Itching significantly reduced. Redness fading.', 'Continue Cream for 7 more days. Do not scratch.', 'Continuous tracking. Partial resolution.', 2),
(26, '2026-01-15', 'Itching significantly reduced. Redness fading.', 'Continue Cream for 7 more days. Do not scratch.', 'Partial resolution.', 1),
(26, '2026-01-16', 'Follow-up visit. Itching significantly reduced. Redness fading.', 'Continue Cream for 7 more days. Do not scratch.', 'Continuous tracking. Partial resolution.', 3),
(26, '2026-01-18', 'Itching significantly reduced. Redness fading.', 'Continue Cream for 7 more days. Do not scratch.', 'Partial resolution.', 1),
(26, '2026-01-20', 'Follow-up visit. Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Continuous tracking. Healing.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(26, '2026-01-21', 'Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Healing.', 1),
(26, '2026-01-21', 'Follow-up visit. Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Continuous tracking. Healing.', 1),
(26, '2026-01-25', 'Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Healing.', 2),
(26, '2026-01-26', 'Follow-up visit. Skin cleared. Occasional itch when sweating.', 'Miconazole powder for shoes/socks.', 'Continuous tracking. Full recovery. Prevention advised.', 2),
(26, '2026-01-31', 'Skin cleared. Occasional itch when sweating.', 'Miconazole powder for shoes/socks.', 'Full recovery. Prevention advised.', 1),
(26, '2026-01-31', 'Follow-up visit. Skin cleared. Occasional itch when sweating.', 'Miconazole powder for shoes/socks.', 'Continuous tracking. Full recovery. Prevention advised.', 3),
(26, '2026-01-31', 'Skin cleared. Occasional itch when sweating.', 'Miconazole powder for shoes/socks.', 'Full recovery. Prevention advised.', 3),
(26, '2026-02-06', 'Follow-up visit. Stable skin.', 'None.', 'Continuous tracking. No active lesions.', 2),
(26, '2026-02-09', 'Stable skin.', 'None.', 'No active lesions.', 3),
(26, '2026-02-10', 'Follow-up visit. Stable skin.', 'None.', 'Continuous tracking. No active lesions.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(26, '2026-02-14', 'Stable skin.', 'None.', 'No active lesions.', 3),
(26, '2026-02-17', 'Follow-up visit. Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Continuous tracking. Reinforced hygiene counseling.', 3),
(26, '2026-02-17', 'Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Reinforced hygiene counseling.', 2),
(26, '2026-02-26', 'Follow-up visit. Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Continuous tracking. Reinforced hygiene counseling.', 1),
(26, '2026-03-04', 'Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Reinforced hygiene counseling.', 3),
(26, '2026-03-05', 'Follow-up visit. Cleared again.', 'None.', 'Continuous tracking. Successful re-treatment.', 2),
(26, '2026-03-07', 'Cleared again.', 'None.', 'Successful re-treatment.', 3),
(26, '2026-03-08', 'Follow-up visit. Cleared again.', 'None.', 'Continuous tracking. Successful re-treatment.', 3),
(26, '2026-03-09', 'Cleared again.', 'None.', 'Successful re-treatment.', 2),
(26, '2026-03-12', 'Follow-up visit. Follow up. No new lesions.', 'None.', 'Continuous tracking. Clear.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(26, '2026-03-16', 'Follow up. No new lesions.', 'None.', 'Clear.', 3),
(26, '2026-03-17', 'Follow-up visit. Follow up. No new lesions.', 'None.', 'Continuous tracking. Clear.', 3),
(26, '2026-03-23', 'Follow up. No new lesions.', 'None.', 'Clear.', 3),
(26, '2026-03-25', 'Follow-up visit. Routine checkup.', 'None.', 'Continuous tracking. Stable.', 2),
(26, '2026-04-02', 'Routine checkup.', 'None.', 'Stable.', 2),
(26, '2026-04-02', 'Follow-up visit. Routine checkup.', 'None.', 'Continuous tracking. Stable.', 2),
(26, '2026-04-04', 'Routine checkup.', 'None.', 'Stable.', 2),
(26, '2026-04-07', 'Follow-up visit. Healthy skin.', 'None.', 'Continuous tracking. Discharged from skin monitoring.', 3),
(26, '2026-04-11', 'Healthy skin.', 'None.', 'Discharged from skin monitoring.', 1),
(26, '2026-04-13', 'Follow-up visit. Healthy skin.', 'None.', 'Continuous tracking. Discharged from skin monitoring.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(26, '2026-04-13', 'Healthy skin.', 'None.', 'Discharged from skin monitoring.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(27, '2025-12-15', 'BP 150/90. Occasional nape pain after salty meals.', 'Amlodipine 5mg OD. Advised low-salt, low-fat diet.', 'Stage 1 Hypertension. OPD monitoring.', 2),
(27, '2025-12-24', 'Follow-up visit. BP 150/90. Occasional nape pain after salty meals.', 'Amlodipine 5mg OD. Advised low-salt, low-fat diet.', 'Continuous tracking. Stage 1 Hypertension. OPD monitoring.', 1),
(27, '2025-12-24', 'BP 150/90. Occasional nape pain after salty meals.', 'Amlodipine 5mg OD. Advised low-salt, low-fat diet.', 'Stage 1 Hypertension. OPD monitoring.', 2),
(27, '2026-01-03', 'Follow-up visit. BP 140/85. Nape pain reduced.', 'Continue Amlodipine. Provided diet chart.', 'Continuous tracking. Stabilizing. Patient compliant.', 1),
(27, '2026-01-06', 'BP 140/85. Nape pain reduced.', 'Continue Amlodipine. Provided diet chart.', 'Stabilizing. Patient compliant.', 1),
(27, '2026-01-09', 'Follow-up visit. BP 140/85. Nape pain reduced.', 'Continue Amlodipine. Provided diet chart.', 'Continuous tracking. Stabilizing. Patient compliant.', 2),
(27, '2026-01-12', 'BP 130/80. No complaints.', 'Maintain current meds.', 'Excellent BP control.', 1),
(27, '2026-01-14', 'Follow-up visit. BP 130/80. No complaints.', 'Maintain current meds.', 'Continuous tracking. Excellent BP control.', 1),
(27, '2026-01-15', 'BP 145/90. Reported eating at a fiesta.', 'Counseling on diet during holidays. Maintain meds.', 'Lifestyle-induced BP spike.', 1),
(27, '2026-01-31', 'Follow-up visit. BP 145/90. Reported eating at a fiesta.', 'Counseling on diet during holidays. Maintain meds.', 'Continuous tracking. Lifestyle-induced BP spike.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(27, '2026-01-31', 'BP 145/90. Reported eating at a fiesta.', 'Counseling on diet during holidays. Maintain meds.', 'Lifestyle-induced BP spike.', 1),
(27, '2026-02-08', 'Follow-up visit. BP 135/85. Feeling better.', 'Continue Amlodipine.', 'Continuous tracking. Return to baseline.', 1),
(27, '2026-02-14', 'BP 135/85. Feeling better.', 'Continue Amlodipine.', 'Return to baseline.', 2),
(27, '2026-02-25', 'Follow-up visit. BP 125/80. No dizziness.', 'Prescription refill for 2 months.', 'Continuous tracking. Stable maintenance.', 3),
(27, '2026-02-25', 'BP 125/80. No dizziness.', 'Prescription refill for 2 months.', 'Stable maintenance.', 2),
(27, '2026-03-01', 'Follow-up visit. BP 125/80. No dizziness.', 'Prescription refill for 2 months.', 'Continuous tracking. Stable maintenance.', 1),
(27, '2026-03-03', 'BP 120/80. Weight down by 1kg.', 'Encouraged walking 30 mins daily.', 'Good progress with exercise.', 2),
(27, '2026-03-04', 'Follow-up visit. BP 120/80. Weight down by 1kg.', 'Encouraged walking 30 mins daily.', 'Continuous tracking. Good progress with exercise.', 2),
(27, '2026-03-05', 'BP 120/80. Weight down by 1kg.', 'Encouraged walking 30 mins daily.', 'Good progress with exercise.', 2),
(27, '2026-03-14', 'Follow-up visit. BP 128/82. Routine checkup.', 'None.', 'Continuous tracking. Still within target range.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(27, '2026-03-15', 'BP 128/82. Routine checkup.', 'None.', 'Still within target range.', 2),
(27, '2026-03-18', 'Follow-up visit. BP 130/80. Refill request.', 'Amlodipine refilled.', 'Continuous tracking. Maintenance check.', 2),
(27, '2026-03-20', 'BP 130/80. Refill request.', 'Amlodipine refilled.', 'Maintenance check.', 3),
(27, '2026-04-04', 'Follow-up visit. BP 130/80. Refill request.', 'Amlodipine refilled.', 'Continuous tracking. Maintenance check.', 2),
(27, '2026-04-05', 'BP 120/80. No signs of retinopathy or edema.', 'Continue current plan.', 'Maintenance is effective.', 2),
(27, '2026-04-07', 'Follow-up visit. BP 120/80. No signs of retinopathy or edema.', 'Continue current plan.', 'Continuous tracking. Maintenance is effective.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(28, '2025-12-14', 'Burning sensation in the chest, sour taste in mouth.', 'Omeprazole 20mg OD (30 mins before breakfast). Avoid coffee/spicy food.', 'Suspected Acid Reflux (GERD).', 2),
(28, '2025-12-23', 'Follow-up visit. Burning sensation in the chest, sour taste in mouth.', 'Omeprazole 20mg OD (30 mins before breakfast). Avoid coffee/spicy food.', 'Continuous tracking. Suspected Acid Reflux (GERD).', 2),
(28, '2025-12-23', 'Burning sensation in the chest, sour taste in mouth.', 'Omeprazole 20mg OD (30 mins before breakfast). Avoid coffee/spicy food.', 'Suspected Acid Reflux (GERD).', 3),
(28, '2025-12-26', 'Follow-up visit. Burning sensation in the chest, sour taste in mouth.', 'Omeprazole 20mg OD (30 mins before breakfast). Avoid coffee/spicy food.', 'Continuous tracking. Suspected Acid Reflux (GERD).', 3),
(28, '2025-12-31', 'Feeling better. Reflux only happens when lying down after dinner.', 'Maintain Omeprazole. Advised not to lie down for 2 hrs after eating.', 'Lifestyle adjustment required.', 2),
(28, '2026-01-01', 'Follow-up visit. Feeling better. Reflux only happens when lying down after dinner.', 'Maintain Omeprazole. Advised not to lie down for 2 hrs after eating.', 'Continuous tracking. Lifestyle adjustment required.', 1),
(28, '2026-01-03', 'Feeling better. Reflux only happens when lying down after dinner.', 'Maintain Omeprazole. Advised not to lie down for 2 hrs after eating.', 'Lifestyle adjustment required.', 1),
(28, '2026-01-06', 'Follow-up visit. Feeling better. Reflux only happens when lying down after dinner.', 'Maintain Omeprazole. Advised not to lie down for 2 hrs after eating.', 'Continuous tracking. Lifestyle adjustment required.', 3),
(28, '2026-01-06', 'Stable. No heartburn.', 'Tapering Omeprazole to PRN.', 'Improving.', 3),
(28, '2026-01-07', 'Follow-up visit. Stable. No heartburn.', 'Tapering Omeprazole to PRN.', 'Continuous tracking. Improving.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(28, '2026-01-08', 'Stable. No heartburn.', 'Tapering Omeprazole to PRN.', 'Improving.', 1),
(28, '2026-01-10', 'Follow-up visit. Stable. No heartburn.', 'Tapering Omeprazole to PRN.', 'Continuous tracking. Improving.', 3),
(28, '2026-01-17', 'Mild bloating after eating gata dishes.', 'Simethicone PRN. Continue diet avoidance.', 'Dietary flare-up.', 2),
(28, '2026-01-17', 'Follow-up visit. Mild bloating after eating gata dishes.', 'Simethicone PRN. Continue diet avoidance.', 'Continuous tracking. Dietary flare-up.', 2),
(28, '2026-01-22', 'Mild bloating after eating gata dishes.', 'Simethicone PRN. Continue diet avoidance.', 'Dietary flare-up.', 2),
(28, '2026-01-27', 'Follow-up visit. Bloating resolved.', 'Stay on bland diet for 3 days.', 'Continuous tracking. Managed.', 2),
(28, '2026-01-31', 'Bloating resolved.', 'Stay on bland diet for 3 days.', 'Managed.', 3),
(28, '2026-01-31', 'Follow-up visit. Bloating resolved.', 'Stay on bland diet for 3 days.', 'Continuous tracking. Managed.', 2),
(28, '2026-02-01', 'Bloating resolved.', 'Stay on bland diet for 3 days.', 'Managed.', 3),
(28, '2026-02-05', 'Follow-up visit. Feeling normal. No antacids needed for a week.', 'None.', 'Continuous tracking. Stable.', 1);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(28, '2026-02-07', 'Feeling normal. No antacids needed for a week.', 'None.', 'Stable.', 1),
(28, '2026-02-16', 'Follow-up visit. Feeling normal. No antacids needed for a week.', 'None.', 'Continuous tracking. Stable.', 2),
(28, '2026-02-18', 'Feeling normal. No antacids needed for a week.', 'None.', 'Stable.', 3),
(28, '2026-02-24', 'Follow-up visit. Stable.', 'None.', 'Continuous tracking. Checkup.', 1),
(28, '2026-02-26', 'Stable.', 'None.', 'Checkup.', 3),
(28, '2026-03-01', 'Follow-up visit. Stable.', 'None.', 'Continuous tracking. Checkup.', 1),
(28, '2026-03-10', 'Occasional stress-induced stomach ache.', 'Warm water, relaxation.', 'Psychosomatic factor.', 1),
(28, '2026-03-11', 'Follow-up visit. Occasional stress-induced stomach ache.', 'Warm water, relaxation.', 'Continuous tracking. Psychosomatic factor.', 2),
(28, '2026-03-11', 'Occasional stress-induced stomach ache.', 'Warm water, relaxation.', 'Psychosomatic factor.', 3),
(28, '2026-03-13', 'Follow-up visit. Occasional stress-induced stomach ache.', 'Warm water, relaxation.', 'Continuous tracking. Psychosomatic factor.', 1);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(28, '2026-03-15', 'No symptoms.', 'None.', 'Asymptomatic.', 3),
(28, '2026-03-17', 'Follow-up visit. No symptoms.', 'None.', 'Continuous tracking. Asymptomatic.', 3),
(28, '2026-03-30', 'No symptoms.', 'None.', 'Asymptomatic.', 1),
(28, '2026-04-01', 'Follow-up visit. No symptoms.', 'None.', 'Continuous tracking. Asymptomatic.', 2),
(28, '2026-04-02', 'Full recovery. Patient learned dietary triggers.', 'None.', 'Case closed.', 3),
(28, '2026-04-05', 'Follow-up visit. Full recovery. Patient learned dietary triggers.', 'None.', 'Continuous tracking. Case closed.', 3),
(28, '2026-04-09', 'Full recovery. Patient learned dietary triggers.', 'None.', 'Case closed.', 1);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(29, '2025-12-14', 'Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Fungal skin infection. Non-infectious to others via touch.', 2),
(29, '2025-12-25', 'Follow-up visit. Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Continuous tracking. Fungal skin infection. Non-infectious to others via touch.', 3),
(29, '2025-12-31', 'Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Fungal skin infection. Non-infectious to others via touch.', 1),
(29, '2026-01-02', 'Follow-up visit. Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Continuous tracking. Fungal skin infection. Non-infectious to others via touch.', 1),
(29, '2026-01-04', 'Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Fungal skin infection. Non-infectious to others via touch.', 1),
(29, '2026-01-10', 'Follow-up visit. Itching significantly reduced. Redness fading.', 'Continue Cream for 7 more days. Do not scratch.', 'Continuous tracking. Partial resolution.', 2),
(29, '2026-01-14', 'Itching significantly reduced. Redness fading.', 'Continue Cream for 7 more days. Do not scratch.', 'Partial resolution.', 2),
(29, '2026-01-17', 'Follow-up visit. Itching significantly reduced. Redness fading.', 'Continue Cream for 7 more days. Do not scratch.', 'Continuous tracking. Partial resolution.', 1),
(29, '2026-01-22', 'Itching significantly reduced. Redness fading.', 'Continue Cream for 7 more days. Do not scratch.', 'Partial resolution.', 2),
(29, '2026-01-22', 'Follow-up visit. Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Continuous tracking. Healing.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(29, '2026-01-30', 'Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Healing.', 3),
(29, '2026-01-30', 'Follow-up visit. Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Continuous tracking. Healing.', 1),
(29, '2026-01-30', 'Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Healing.', 2),
(29, '2026-02-06', 'Follow-up visit. Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Continuous tracking. Healing.', 2),
(29, '2026-02-09', 'Skin cleared. Occasional itch when sweating.', 'Miconazole powder for shoes/socks.', 'Full recovery. Prevention advised.', 3),
(29, '2026-02-11', 'Follow-up visit. Skin cleared. Occasional itch when sweating.', 'Miconazole powder for shoes/socks.', 'Continuous tracking. Full recovery. Prevention advised.', 1),
(29, '2026-02-14', 'Skin cleared. Occasional itch when sweating.', 'Miconazole powder for shoes/socks.', 'Full recovery. Prevention advised.', 3),
(29, '2026-02-15', 'Follow-up visit. Skin cleared. Occasional itch when sweating.', 'Miconazole powder for shoes/socks.', 'Continuous tracking. Full recovery. Prevention advised.', 1),
(29, '2026-02-16', 'Stable skin.', 'None.', 'No active lesions.', 1),
(29, '2026-02-20', 'Follow-up visit. Stable skin.', 'None.', 'Continuous tracking. No active lesions.', 1);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(29, '2026-02-21', 'Stable skin.', 'None.', 'No active lesions.', 3),
(29, '2026-02-23', 'Follow-up visit. Stable skin.', 'None.', 'Continuous tracking. No active lesions.', 2),
(29, '2026-02-25', 'Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Reinforced hygiene counseling.', 1),
(29, '2026-03-01', 'Follow-up visit. Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Continuous tracking. Reinforced hygiene counseling.', 2),
(29, '2026-03-11', 'Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Reinforced hygiene counseling.', 3),
(29, '2026-03-12', 'Follow-up visit. Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Continuous tracking. Reinforced hygiene counseling.', 3),
(29, '2026-03-13', 'Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Reinforced hygiene counseling.', 3),
(29, '2026-03-14', 'Follow-up visit. Cleared again.', 'None.', 'Continuous tracking. Successful re-treatment.', 3),
(29, '2026-03-14', 'Cleared again.', 'None.', 'Successful re-treatment.', 2),
(29, '2026-03-15', 'Follow-up visit. Cleared again.', 'None.', 'Continuous tracking. Successful re-treatment.', 1);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(29, '2026-03-18', 'Cleared again.', 'None.', 'Successful re-treatment.', 3),
(29, '2026-03-20', 'Follow-up visit. Follow up. No new lesions.', 'None.', 'Continuous tracking. Clear.', 3),
(29, '2026-03-21', 'Follow up. No new lesions.', 'None.', 'Clear.', 3),
(29, '2026-03-22', 'Follow-up visit. Follow up. No new lesions.', 'None.', 'Continuous tracking. Clear.', 1),
(29, '2026-03-24', 'Follow up. No new lesions.', 'None.', 'Clear.', 2),
(29, '2026-03-27', 'Follow-up visit. Follow up. No new lesions.', 'None.', 'Continuous tracking. Clear.', 3),
(29, '2026-03-27', 'Routine checkup.', 'None.', 'Stable.', 1),
(29, '2026-03-28', 'Follow-up visit. Routine checkup.', 'None.', 'Continuous tracking. Stable.', 1),
(29, '2026-03-29', 'Routine checkup.', 'None.', 'Stable.', 3),
(29, '2026-03-30', 'Follow-up visit. Routine checkup.', 'None.', 'Continuous tracking. Stable.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(29, '2026-04-02', 'Healthy skin.', 'None.', 'Discharged from skin monitoring.', 2),
(29, '2026-04-02', 'Follow-up visit. Healthy skin.', 'None.', 'Continuous tracking. Discharged from skin monitoring.', 3),
(29, '2026-04-04', 'Healthy skin.', 'None.', 'Discharged from skin monitoring.', 3),
(29, '2026-04-08', 'Follow-up visit. Healthy skin.', 'None.', 'Continuous tracking. Discharged from skin monitoring.', 2);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(30, '2025-12-25', 'Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Fungal skin infection. Non-infectious to others via touch.', 3),
(30, '2026-01-04', 'Follow-up visit. Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Continuous tracking. Fungal skin infection. Non-infectious to others via touch.', 1),
(30, '2026-01-06', 'Itchy, red circular rashes on the back/arms.', 'Clotrimazole Cream BID. Advised keeping area dry.', 'Fungal skin infection. Non-infectious to others via touch.', 2),
(30, '2026-01-08', 'Follow-up visit. Itching significantly reduced. Redness fading.', 'Continue Cream for 7 more days. Do not scratch.', 'Continuous tracking. Partial resolution.', 2),
(30, '2026-01-11', 'Itching significantly reduced. Redness fading.', 'Continue Cream for 7 more days. Do not scratch.', 'Partial resolution.', 2),
(30, '2026-01-20', 'Follow-up visit. Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Continuous tracking. Healing.', 3),
(30, '2026-01-20', 'Rashes almost gone. Hypopigmented spots left.', 'Continue topical.', 'Healing.', 3),
(30, '2026-01-24', 'Follow-up visit. Skin cleared. Occasional itch when sweating.', 'Miconazole powder for shoes/socks.', 'Continuous tracking. Full recovery. Prevention advised.', 2),
(30, '2026-01-27', 'Skin cleared. Occasional itch when sweating.', 'Miconazole powder for shoes/socks.', 'Full recovery. Prevention advised.', 3),
(30, '2026-02-09', 'Follow-up visit. Stable skin.', 'None.', 'Continuous tracking. No active lesions.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(30, '2026-02-15', 'Stable skin.', 'None.', 'No active lesions.', 2),
(30, '2026-02-17', 'Follow-up visit. Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Continuous tracking. Reinforced hygiene counseling.', 1),
(30, '2026-02-20', 'Minor recurrence due to gym use/sweating.', 'Resume Clotrimazole Cream.', 'Reinforced hygiene counseling.', 2),
(30, '2026-03-03', 'Follow-up visit. Cleared again.', 'None.', 'Continuous tracking. Successful re-treatment.', 1),
(30, '2026-03-07', 'Cleared again.', 'None.', 'Successful re-treatment.', 2),
(30, '2026-03-11', 'Follow-up visit. Follow up. No new lesions.', 'None.', 'Continuous tracking. Clear.', 2),
(30, '2026-03-18', 'Follow up. No new lesions.', 'None.', 'Clear.', 2),
(30, '2026-03-28', 'Follow-up visit. Routine checkup.', 'None.', 'Continuous tracking. Stable.', 1),
(30, '2026-04-01', 'Routine checkup.', 'None.', 'Stable.', 2),
(30, '2026-04-03', 'Follow-up visit. Healthy skin.', 'None.', 'Continuous tracking. Discharged from skin monitoring.', 3);
INSERT INTO consultation (patient_id, visit_date, symptoms_diagnosis, treatment, remarks, physician_id) VALUES
(30, '2026-04-08', 'Healthy skin.', 'None.', 'Discharged from skin monitoring.', 1);
