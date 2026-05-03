# AUF — Don Emiliano J. Valdes Medical Clinic
### Clinical Decision Support & Patient Trace Analytics System

ValdesCare is a professional, offline-first clinical management system designed for the AUF Don Emiliano J. Valdes Medical Clinic. It provides a robust platform for patient registration, clinical encounter tracking, and dynamic health analytics, optimized for local network deployment.

---

## 🚀 Key Features

*   **Dynamic Analytics Dashboard**: Real-time tracking of patient volume, demographics, and top diagnoses with interactive Chart.js visualizations.
*   **Comprehensive Patient Records**: Digital management of patient profiles, household data, and PhilHealth status.
*   **Configurable Clinic Hours**: System-wide settings to define operating hours, which automatically scales the dashboard's "Today" visualization with a professional buffer.
*   **Clinical Encounters**: Structured logging of chief complaints, detailed symptoms, diagnoses, and treatments.
*   **Smart Medical Dictionary**: Intelligent, self-building database that provides real-time autocomplete suggestions for diagnoses and chief complaints to speed up clinical data entry.
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

### 1. Get the Source Code

#### Option A: Clone via Git (Recommended)
1. Open your terminal (Command Prompt, PowerShell, or Git Bash).
2. Navigate to your XAMPP `htdocs` directory:
   ```bash
   cd C:\xampp\htdocs\ccs06-appdev
   ```
   > ⚠️ If the `ccs06-appdev` folder doesn't exist yet, create it first:
   > ```bash
   > mkdir C:\xampp\htdocs\ccs06-appdev
   > cd C:\xampp\htdocs\ccs06-appdev
   > ```
3. Clone the repository:
   ```bash
   git clone https://github.com/iamstrix/ValdesCare.git final-test
   ```
4. The app will be accessible at: `http://localhost/ccs06-appdev/final-test/`

#### Option B: Manual Placement
Move the `final-test` folder into your XAMPP's `htdocs` directory:
`C:\xampp\htdocs\ccs06-appdev\final-test`

### 2. Database Setup (phpMyAdmin)
The system requires a MySQL database named `valdescare`. Follow these steps to set it up:

1.  Open **XAMPP Control Panel** and start **Apache** and **MySQL**.
2.  Go to **phpMyAdmin** in your browser: `http://localhost/phpmyadmin`.
3.  Click on the **Import** tab at the top.
4.  Click **Choose File** and select the `valdescare_schema.sql` file from the cloned project folder:
    `C:\xampp\htdocs\ccs06-appdev\final-test\valdescare_schema.sql`
5.  Click **Go**.

This will automatically create the `valdescare` database, all tables, views, foreign keys, and seed the initial data in one step.

> **Note:** If you prefer to create the database manually first, go to phpMyAdmin → click **New** → name it `valdescare` → click **Create** — then follow steps 3–5 above.

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
