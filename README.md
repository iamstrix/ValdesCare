# AUF — Don Emiliano J. Valdes Medical Clinic
### Clinical Decision Support & Patient Trace Analytics System

ValdesCare is a professional, offline-first clinical management system designed for the AUF Don Emiliano J. Valdes Medical Clinic. It provides a robust platform for patient registration, clinical encounter tracking, and dynamic health analytics, optimized for local network deployment.

---

## 🚀 Key Features

*   **Dynamic Analytics Dashboard**: Real-time tracking of patient volume, demographics, and top diagnoses with interactive Chart.js visualizations.
*   **Comprehensive Patient Records**: Digital management of patient profiles, household data, and PhilHealth status.
*   **Clinical Encounters**: Structured logging of chief complaints, detailed symptoms, diagnoses, and treatments.
*   **Physician Directory**: Management of attending physicians and health workers.
*   **Report Generation**: Automated generation of printable patient history and medical summaries.
*   **Local Network Optimized**: Designed to run seamlessly in a LAN environment using XAMPP.

---

## 🛠️ Prerequisites

*   **XAMPP** (Apache & MySQL)
*   **PHP 7.4 or higher**
*   **Web Browser**: Chrome, Edge, or Firefox (Modern versions)

---

## 📥 Installation & Setup

### 1. Project Placement
Move the `final-test` folder into your XAMPP's `htdocs` directory:
`C:\xampp\htdocs\ccs06-appdev\final-test`

### 2. Database Setup (phpMyAdmin)
The system requires a MySQL database named `valdescare`. Follow these steps to set it up:

1.  Open **XAMPP Control Panel** and start **Apache** and **MySQL**.
2.  Go to **phpMyAdmin** in your browser: `http://localhost/phpmyadmin`.
3.  Click on the **New** button in the left sidebar.
4.  Enter `valdescare` as the database name and click **Create**.
5.  Click on the **SQL** tab at the top.
6.  **Copy and paste** the SQL code below into the box and click **Go**.

#### 📋 Initialization SQL Query
```sql
-- ============================================================
-- ValdesCare Clinical Decision Support System
-- Database Schema
-- ============================================================

CREATE TABLE IF NOT EXISTS patient (
    patient_id              INT UNSIGNED NOT NULL AUTO_INCREMENT,
    household_no            VARCHAR(50)  NOT NULL,
    patient_name            VARCHAR(150) NOT NULL,
    dob                     DATE         NOT NULL COMMENT 'Date of birth',
    age_group               ENUM('Pediatric', 'Adult', 'Geriatric') NOT NULL DEFAULT 'Adult',
    sex                     ENUM('Male','Female') NOT NULL,
    address                 VARCHAR(255) NOT NULL,
    mobile_no               VARCHAR(50)  NOT NULL,
    mothers_maiden_name     VARCHAR(150) NULL DEFAULT NULL,
    relationship_to_head    VARCHAR(50)  NOT NULL,
    is_ip                   ENUM('Yes','No') NOT NULL DEFAULT 'No' COMMENT 'Indigenous People household',
    nhts_status             ENUM('NHTS','NON-NHTS') NOT NULL DEFAULT 'NON-NHTS',
    is_philhealth_member    ENUM('Yes','No') NOT NULL DEFAULT 'No',
    philhealth_no           VARCHAR(50)  NULL DEFAULT NULL,
    philhealth_category     VARCHAR(100) NULL DEFAULT NULL,
    school_status           ENUM('In-School','Out of School Youth','Not in School') NOT NULL DEFAULT 'Not in School',
    created_at              TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at              TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (patient_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS category (
    category_id    TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name           VARCHAR(60)      NOT NULL,
    description    VARCHAR(255)         NULL DEFAULT NULL,
    PRIMARY KEY (category_id),
    UNIQUE KEY uq_category_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT IGNORE INTO category (name, description) VALUES
    ('Pediatrics',          'Patients aged 0–18 years'),
    ('Internal Medicine',   'Adult general medicine'),
    ('OB-GYN',              'Obstetrics and Gynecology'),
    ('Dental',              'Oral health services'),
    ('General Surgery',     'Minor surgical procedures');

CREATE TABLE IF NOT EXISTS physician (
    physician_id   SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    first_name     VARCHAR(80)       NOT NULL,
    last_name      VARCHAR(80)       NOT NULL,
    specialty      VARCHAR(100)          NULL DEFAULT NULL,
    license_no     VARCHAR(30)           NULL DEFAULT NULL,
    is_active      TINYINT(1)        NOT NULL DEFAULT 1,
    PRIMARY KEY (physician_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
    CONSTRAINT fk_consult_patient FOREIGN KEY (patient_id) REFERENCES patient (patient_id) ON DELETE CASCADE,
    CONSTRAINT fk_consult_physician FOREIGN KEY (physician_id) REFERENCES physician (physician_id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE OR REPLACE VIEW v_patient_full AS
SELECT
    patient_id,
    patient_name AS full_name,
    dob,
    TIMESTAMPDIFF(YEAR, dob, CURDATE()) AS age,
    sex,
    school_status,
    philhealth_no,
    address AS full_address,
    is_ip,
    nhts_status
FROM patient;

CREATE OR REPLACE VIEW v_consultation_full AS
SELECT
    c.consultation_id,
    c.visit_date,
    p.patient_id,
    p.patient_name,
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
```

### 3. Generate Mock Data (Optional)
If you wish to populate the system with 30 patients and multiple years of visit records for testing:
1.  Open your browser to `http://localhost/ccs06-appdev/final-test/mock_data_gen.php`.
2.  This will generate a file named `mock_records.sql`.
3.  Import `mock_records.sql` into phpMyAdmin using the **Import** tab.

---

## 📂 Project Structure
```text
final-test/
├── dashboard/        ← Analytics & Chart.js visualizations
├── patients/         ← Patient registration & profile management
├── consultations/    ← Clinical encounter logging (New/List/View)
├── physicians/       ← Staff directory management
├── exports/          ← Printable report generation (PDF/HTML)
├── assets/           ← CSS & JS (Chart.js)
├── includes/         ← Shared UI components (Header/Footer)
├── db_connect.php    ← Core database configuration
└── valdescare_schema.sql
```

---

## ⚙️ Configuration Notes
*   **Timezone**: The system is pre-configured to `Asia/Manila` (UTC+8) in `db_connect.php`.
*   **Credentials**: The default database user is `root` with no password. Edit `db_connect.php` if your local MySQL setup differs.
*   **Security**: Ensure `db_connect.php` is never exposed to public internet as it contains database credentials.

---

## ❓ Troubleshooting

| Issue | Solution |
| :--- | :--- |
| **Database Connection Error** | Ensure MySQL is running in XAMPP and the `valdescare` database exists. |
| **Charts are missing** | Ensure `assets/js/chart.min.js` exists or run the recovery command in `README.md`. |
| **Missing CSS/Styles** | Access the system via `http://localhost/` instead of opening files directly. |
| **Date Errors** | Future dates are blocked by default to maintain data integrity. |

---

Developed for the **AUF Don Emiliano J. Valdes Medical Clinic**.
