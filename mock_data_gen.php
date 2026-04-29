<?php
/**
 * mock_data_gen.php
 * Generates an SQL file containing 30 Philippine-centric patients
 * and 10-50 thematic visit records per patient evenly dispersed
 * from Dec 14, 2026 to April 14, 2026.
 * 
 * CONDITIONS: Severity appropriate for SMALL OUT-PATIENT CLINIC.
 */

date_default_timezone_set('Asia/Manila');

$names = [
    "Juan Dela Cruz", "Maria Clara", "Jose Rizal Santos", "Andres Bonifacio", "Emilio Aguinaldo",
    "Apolinario Mabini", "Gabriela Silang", "Melchora Aquino", "Marcelo H. Del Pilar", "Gregorio Del Pilar",
    "Emilio Jacinto", "Antonio Luna", "Juan Luna", "Lapu-Lapu", "Diego Silang",
    "Miguel Malvar", "Macario Sakay", "Teresa Magbanua", "Josefa Llanes Escoda", "Vicente Lim",
    "Ramon Magsaysay", "Ferdinand Marcos", "Corazon Aquino", "Fidel Ramos", "Joseph Estrada",
    "Gloria Macapagal-Arroyo", "Benigno Aquino III", "Rodrigo Duterte", "Leni Robredo", "Manny Pacquiao"
];

$addresses = [
    "123 Rizal St., Brgy. San Jose, Valdes City",
    "456 Bonifacio Ave., Brgy. Sto. Rosario, Valdes City",
    "789 Mabini St., Brgy. San Nicolas, Valdes City",
    "101 Luna St., Brgy. Cutcut, Valdes City"
];

$illnessPathways = [
    [
        'condition' => 'Recurrent Common Cold & Flu',
        'chief_complaint' => 'Cough',
        'diagnosis' => 'Common Cold',
        'stages' => [
            ['det' => 'Sneezing, runny nose, mild throat itchiness', 'treat' => 'Prescribed Cetirizine 10mg OD. Vitamin C 500mg. Drink plenty of water.', 'rem' => 'Likely viral upper respiratory infection. Rest advised.'],
            ['det' => 'Slight dry cough, no fever', 'treat' => 'Continue Vitamin C. Added Ambroxol 30mg TID for cough.', 'rem' => 'Patient feels slightly better.'],
            ['det' => 'No symptoms. Routine vitamin refill', 'treat' => 'Refilled Multivitamins.', 'rem' => 'Recovery complete.'],
            ['det' => 'Recurrence of symptoms after rainy travel: Feverish, sore throat', 'treat' => 'Paracetamol 500mg PRN. Gargle with warm salt water.', 'rem' => 'New episode of viral flu.'],
            ['det' => 'Productive cough, yellowish phlegm', 'treat' => 'Amoxicillin 500mg TID for 7 days. Continue hydration.', 'rem' => 'Suspected mild secondary bacterial infection.'],
            ['det' => 'Cough improving, still feels weak', 'treat' => 'Continue Antibiotics. Rest.', 'rem' => 'Compliance is good.'],
            ['det' => 'Resolved. Throat clear.', 'treat' => 'Vitamins only.', 'rem' => 'Back to healthy baseline.'],
            ['det' => 'Minor nasal congestion due to allergens', 'treat' => 'Loratadine 10mg OD.', 'rem' => 'Seasonal allergy management.'],
            ['det' => 'Stable. Feeling well.', 'treat' => 'None.', 'rem' => 'Fully asymptomatic.'],
            ['det' => 'Routine visit. Clean bill of health.', 'treat' => 'Stay hydrated.', 'rem' => 'Patient educated on flu prevention.']
        ]
    ],
    [
        'condition' => 'Chronic Hypertension (Stable)',
        'chief_complaint' => 'Dizziness',
        'diagnosis' => 'Hypertension',
        'stages' => [
            ['det' => 'BP 150/90. Occasional nape pain after salty meals.', 'treat' => 'Amlodipine 5mg OD. Advised low-salt, low-fat diet.', 'rem' => 'Stage 1 Hypertension. OPD monitoring.'],
            ['det' => 'BP 140/85. Nape pain reduced.', 'treat' => 'Continue Amlodipine. Provided diet chart.', 'rem' => 'Stabilizing. Patient compliant.'],
            ['det' => 'BP 130/80. No complaints.', 'treat' => 'Maintain current meds.', 'rem' => 'Excellent BP control.'],
            ['det' => 'BP 145/90. Reported eating at a fiesta.', 'treat' => 'Counseling on diet during holidays. Maintain meds.', 'rem' => 'Lifestyle-induced BP spike.'],
            ['det' => 'BP 135/85. Feeling better.', 'treat' => 'Continue Amlodipine.', 'rem' => 'Return to baseline.'],
            ['det' => 'BP 125/80. No dizziness.', 'treat' => 'Prescription refill for 2 months.', 'rem' => 'Stable maintenance.'],
            ['det' => 'BP 120/80. Weight down by 1kg.', 'treat' => 'Encouraged walking 30 mins daily.', 'rem' => 'Good progress with exercise.'],
            ['det' => 'BP 128/82. Routine checkup.', 'treat' => 'None.', 'rem' => 'Still within target range.'],
            ['det' => 'BP 130/80. Refill request.', 'treat' => 'Amlodipine refilled.', 'rem' => 'Maintenance check.'],
            ['det' => 'BP 120/80. No signs of retinopathy or edema.', 'treat' => 'Continue current plan.', 'rem' => 'Maintenance is effective.']
        ]
    ],
    [
        'condition' => 'Skin Infection (Tinea / Ringworm)',
        'chief_complaint' => 'Skin Rash',
        'diagnosis' => 'Skin Infection (Tinea)',
        'stages' => [
            ['det' => 'Itchy, red circular rashes on the back/arms.', 'treat' => 'Clotrimazole Cream BID. Advised keeping area dry.', 'rem' => 'Fungal skin infection. Non-infectious to others via touch.'],
            ['det' => 'Itching significantly reduced. Redness fading.', 'treat' => 'Continue Cream for 7 more days. Do not scratch.', 'rem' => 'Partial resolution.'],
            ['det' => 'Rashes almost gone. Hypopigmented spots left.', 'treat' => 'Continue topical.', 'rem' => 'Healing.'],
            ['det' => 'Skin cleared. Occasional itch when sweating.', 'treat' => 'Miconazole powder for shoes/socks.', 'rem' => 'Full recovery. Prevention advised.'],
            ['det' => 'Stable skin.', 'treat' => 'None.', 'rem' => 'No active lesions.'],
            ['det' => 'Minor recurrence due to gym use/sweating.', 'treat' => 'Resume Clotrimazole Cream.', 'rem' => 'Reinforced hygiene counseling.'],
            ['det' => 'Cleared again.', 'treat' => 'None.', 'rem' => 'Successful re-treatment.'],
            ['det' => 'Follow up. No new lesions.', 'treat' => 'None.', 'rem' => 'Clear.'],
            ['det' => 'Routine checkup.', 'treat' => 'None.', 'rem' => 'Stable.'],
            ['det' => 'Healthy skin.', 'treat' => 'None.', 'rem' => 'Discharged from skin monitoring.']
        ]
    ],
    [
        'condition' => 'Mild Gastritis / Acid Reflux',
        'chief_complaint' => 'Stomach ache',
        'diagnosis' => 'Acid Reflux (GERD)',
        'stages' => [
            ['det' => 'Burning sensation in the chest, sour taste in mouth.', 'treat' => 'Omeprazole 20mg OD (30 mins before breakfast). Avoid coffee/spicy food.', 'rem' => 'Suspected Acid Reflux (GERD).'],
            ['det' => 'Feeling better. Reflux only happens when lying down after dinner.', 'treat' => 'Maintain Omeprazole. Advised not to lie down for 2 hrs after eating.', 'rem' => 'Lifestyle adjustment required.'],
            ['det' => 'Stable. No heartburn.', 'treat' => 'Tapering Omeprazole to PRN.', 'rem' => 'Improving.'],
            ['det' => 'Mild bloating after eating gata dishes.', 'treat' => 'Simethicone PRN. Continue diet avoidance.', 'rem' => 'Dietary flare-up.'],
            ['det' => 'Bloating resolved.', 'treat' => 'Stay on bland diet for 3 days.', 'rem' => 'Managed.'],
            ['det' => 'Feeling normal. No antacids needed for a week.', 'treat' => 'None.', 'rem' => 'Stable.'],
            ['det' => 'Stable.', 'treat' => 'None.', 'rem' => 'Checkup.'],
            ['det' => 'Occasional stress-induced stomach ache.', 'treat' => 'Warm water, relaxation.', 'rem' => 'Psychosomatic factor.'],
            ['det' => 'No symptoms.', 'treat' => 'None.', 'rem' => 'Asymptomatic.'],
            ['det' => 'Full recovery. Patient learned dietary triggers.', 'treat' => 'None.', 'rem' => 'Case closed.']
        ]
    ]
];

$sql = "-- ValdesCare Mock Data Generator\n";
$sql .= "-- Generated for Period: Dec 14, 2025 to April 14, 2026\n\n";

$sql .= "SET FOREIGN_KEY_CHECKS = 0;\n";
$sql .= "TRUNCATE TABLE consultation;\n";
$sql .= "TRUNCATE TABLE patient;\n";
$sql .= "TRUNCATE TABLE physician;\n";
$sql .= "SET FOREIGN_KEY_CHECKS = 1;\n\n";

$sql .= "-- Seed Mock Physicians\n";
$sql .= "INSERT INTO physician (first_name, last_name, specialty, is_active) VALUES \n";
$sql .= "('Emiliano', 'Valdes', 'Internal Medicine', 1),\n";
$sql .= "('Fe', 'Mundo', 'Pediatrics', 1),\n";
$sql .= "('Jose', 'Perez', 'General Medicine', 1);\n\n";

$startTimestamp = strtotime('2025-12-14');
$endTimestamp   = strtotime('2026-04-14');

$patientsData = [];

// Generate 30 Patients
for ($i = 0; $i < 30; $i++) {
    $name = $names[$i];
    $hhNo = "HH-" . str_pad(rand(1, 100), 3, '0', STR_PAD_LEFT);
    $dob = date('Y-m-d', strtotime('-' . rand(10, 75) . ' years'));
    $sex = (rand(0,1) ? 'Male' : 'Female');
    $address = $addresses[array_rand($addresses)];
    $mobile = "09" . rand(100000000, 999999999);
    
    // Determine age group based on DOB
    $age = date('Y') - date('Y', strtotime($dob));
    $ageGrp = ($age < 18) ? 'Pediatric' : (($age >= 60) ? 'Geriatric' : 'Adult');
    
    $isIp = (rand(0,9) > 7) ? 'Yes' : 'No';
    $nhts = (rand(0,9) > 5) ? 'NHTS' : 'NON-NHTS';
    $isPhil = (rand(0,9) > 2) ? 'Yes' : 'No';
    $philNo = $isPhil == 'Yes' ? rand(1000000000, 9999999999) : 'NULL';

    $parts = explode(' ', $name);
    $lastName = array_pop($parts);
    $firstName = implode(' ', $parts);
    
    // Build literal SQL values
    $pvals = sprintf(
        "('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', %s, 'Not in School')",
        $hhNo, addslashes($firstName), addslashes($lastName), addslashes($name), $dob, $ageGrp, $sex, addslashes($address), $mobile, 'Head', $isIp, $nhts, $isPhil, ($philNo !== 'NULL' ? $philNo : ''), ($philNo !== 'NULL' ? "'Indigent'" : "NULL")
    );
    
    $sql .= "INSERT INTO patient (household_no, first_name, last_name, patient_name, dob, age_group, sex, address, mobile_no, relationship_to_head, is_ip, nhts_status, is_philhealth_member, philhealth_no, philhealth_category, school_status) VALUES $pvals;\n";
    
    $patientsData[] = [
        'id' => $i + 1,
        'pathway' => $illnessPathways[array_rand($illnessPathways)]
    ];
}

$sql .= "\n-- Generating progression records...\n";

// Generate Visits
foreach ($patientsData as $p) {
    $numVisits = rand(10, 50);
    $pathway = $p['pathway'];
    $stagesCount = count($pathway['stages']);
    
    $times = [];
    for ($k = 0; $k < $numVisits; $k++) {
        $times[] = rand($startTimestamp, $endTimestamp);
    }
    sort($times);
    
    $consultationValues = [];
    foreach ($times as $index => $visitTime) {
        $dateStr = date('Y-m-d', $visitTime);
        
        $stageIdx = floor(($index / $numVisits) * $stagesCount);
        if ($stageIdx >= $stagesCount) $stageIdx = $stagesCount - 1;
        $stage = $pathway['stages'][$stageIdx];
        
        $chiefComp = addslashes($pathway['chief_complaint']);
        $diagnosis = addslashes($pathway['diagnosis']);
        $det = addslashes($stage['det']);
        $treat = addslashes($stage['treat']);
        $rem = addslashes($stage['rem']);
        
        if (($index % 2) != 0) {
            $det = "Follow-up visit. " . $det;
            $rem = "Continuous tracking. " . $rem;
        }

        $physId = rand(1, 3);
        $consultationValues[] = sprintf(
            "(%d, '%s', '%s', '%s', '%s', '%s', '%s', %d)",
            $p['id'], $dateStr, $chiefComp, $det, $diagnosis, $treat, $rem, $physId
        );
    }
    
    $chunks = array_chunk($consultationValues, 10);
    foreach ($chunks as $chunk) {
        $sql .= "INSERT INTO consultation (patient_id, visit_date, chief_complaint, complaint_details, diagnosis, treatment, remarks, physician_id) VALUES\n";
        $sql .= implode(",\n", $chunk) . ";\n";
    }
}

file_put_contents('mock_records.sql', $sql);
echo "mock_records.sql generated successfully with OPD-appropriate conditions!\n";
