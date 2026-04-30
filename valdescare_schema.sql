-- ============================================================
-- ValdesCare Clinical Decision Support System
-- Database Schema — Step 1
-- Target: MySQL 5.7+ / MariaDB 10.x (via XAMPP / phpMyAdmin)
-- ============================================================

-- Create and select the database
CREATE DATABASE IF NOT EXISTS valdescare
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE valdescare;

-- Clean up old views and tables to enforce schema update
SET FOREIGN_KEY_CHECKS = 0;
DROP VIEW IF EXISTS v_patient_full;
DROP VIEW IF EXISTS v_consultation_full;
DROP TABLE IF EXISTS consultation;
DROP TABLE IF EXISTS patient;
DROP TABLE IF EXISTS household;
SET FOREIGN_KEY_CHECKS = 1;
-- TABLE: patient
-- Individual patient record (Fused with household fields)
-- ============================================================
CREATE TABLE IF NOT EXISTS patient (
    patient_id              INT UNSIGNED NOT NULL AUTO_INCREMENT,
    household_no            VARCHAR(50)  NOT NULL,
    first_name              VARCHAR(100) NOT NULL,
    last_name               VARCHAR(100) NOT NULL,
    patient_name            VARCHAR(200) NOT NULL,
    dob                     DATE         NOT NULL COMMENT 'Date of birth',
    age_group               ENUM('Pediatric', 'Adult', 'Geriatric') NOT NULL DEFAULT 'Adult',
    sex                     ENUM('Male','Female') NOT NULL,
    address                 VARCHAR(255) NOT NULL,
    mobile_no               VARCHAR(50)  NOT NULL,
    mothers_maiden_name     VARCHAR(150) NULL DEFAULT NULL,
    relationship_to_head    VARCHAR(50)  NOT NULL,
    is_ip                   ENUM('Yes','No') NOT NULL DEFAULT 'No' COMMENT 'Indigenous People household',
    nhts_status             ENUM('NHTS','NON-NHTS') NOT NULL DEFAULT 'NON-NHTS'  COMMENT 'NHTS / 4Ps registered household',
    is_philhealth_member    ENUM('Yes','No') NOT NULL DEFAULT 'No',
    philhealth_no           VARCHAR(50)  NULL DEFAULT NULL COMMENT 'PhilHealth identification number',
    philhealth_category     VARCHAR(100) NULL DEFAULT NULL,
    school_status           ENUM('In-School','Out of School Youth','Not in School') NOT NULL DEFAULT 'Not in School',
    created_at              TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at              TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (patient_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLE: category
-- Clinical category / service line (e.g. Pediatrics, OB-GYN)
-- ============================================================
CREATE TABLE IF NOT EXISTS category (
    category_id    TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name           VARCHAR(60)      NOT NULL,
    description    VARCHAR(255)         NULL DEFAULT NULL,

    PRIMARY KEY (category_id),
    UNIQUE KEY uq_category_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Seed the initial clinical categories
INSERT IGNORE INTO category (name, description) VALUES
    ('Pediatrics',          'Patients aged 0–18 years'),
    ('Internal Medicine',   'Adult general medicine'),
    ('OB-GYN',              'Obstetrics and Gynecology'),
    ('Dental',              'Oral health services'),
    ('General Surgery',     'Minor surgical procedures');

-- ============================================================
-- TABLE: physician
-- Attending doctors / health workers
-- ============================================================
CREATE TABLE IF NOT EXISTS physician (
    physician_id   SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    first_name     VARCHAR(80)       NOT NULL,
    last_name      VARCHAR(80)       NOT NULL,
    specialty      VARCHAR(100)          NULL DEFAULT NULL,
    license_no     VARCHAR(30)           NULL DEFAULT NULL COMMENT 'PRC license number',
    is_active      TINYINT(1)        NOT NULL DEFAULT 1,

    PRIMARY KEY (physician_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLE: consultation
-- Core clinical encounter record.
-- ============================================================
CREATE TABLE IF NOT EXISTS consultation (
    consultation_id     INT UNSIGNED NOT NULL AUTO_INCREMENT,
    patient_id          INT UNSIGNED NOT NULL,
    visit_date          DATE         NOT NULL,
    chief_complaint     VARCHAR(150) NULL DEFAULT NULL,
    complaint_details   TEXT         NULL DEFAULT NULL,
    diagnosis           VARCHAR(150) NULL DEFAULT NULL,
    treatment           TEXT         NULL DEFAULT NULL,
    remarks             TEXT         NULL DEFAULT NULL,
    physician_id        SMALLINT UNSIGNED NULL DEFAULT NULL,
    created_at          TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (consultation_id),
    CONSTRAINT fk_consult_patient
        FOREIGN KEY (patient_id)
        REFERENCES patient (patient_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_consult_physician
        FOREIGN KEY (physician_id)
        REFERENCES physician (physician_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL,

    INDEX idx_visit_date    (visit_date),
    INDEX idx_patient_date  (patient_id, visit_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLE: chief_complaints
-- Autosuggest dictionary for chief complaints.
-- ============================================================
CREATE TABLE IF NOT EXISTS chief_complaints (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_cc_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLE: diagnoses
-- Autosuggest dictionary for diagnoses.
-- ============================================================
CREATE TABLE IF NOT EXISTS diagnoses (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_diag_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- VIEW: v_patient_full
-- Convenience view for listings
-- ============================================================
CREATE OR REPLACE VIEW v_patient_full AS
SELECT
    patient_id,
    CONCAT(last_name, ', ', first_name) AS full_name,
    dob,
    TIMESTAMPDIFF(YEAR, dob, CURDATE()) AS age,
    sex,
    school_status,
    philhealth_no,
    address AS full_address,
    is_ip,
    nhts_status
FROM patient;

-- ============================================================
-- VIEW: v_consultation_full
-- Full consultation view for analytics and reports
-- ============================================================
CREATE OR REPLACE VIEW v_consultation_full AS
SELECT
    c.consultation_id,
    c.visit_date,
    p.patient_id,
    CONCAT(p.last_name, ', ', p.first_name) AS patient_name,
    TIMESTAMPDIFF(YEAR, p.dob, c.visit_date) AS age_at_visit,
    p.sex,
    p.is_ip,
    p.nhts_status,
    CONCAT(ph.last_name, ', ', ph.first_name) AS physician_name,
    c.chief_complaint,
    c.complaint_details,
    c.diagnosis,
    c.treatment
FROM consultation c
JOIN patient      p   ON c.patient_id    = p.patient_id
LEFT JOIN physician   ph  ON c.physician_id  = ph.physician_id;
