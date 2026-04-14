# Prompts Log

1. "Create a markdown file listing down all the prompts used from now on (including this one.)"

2. "Change Color Scheme

Whole website must follow a 60:30:10 color distribution.
 
60% | #FFFFFF
30% | #1F3B9A - Shaded blue 30%. Secondary color
#DFC14F - Gold 10%. Accent"

5. "#01 Analytics Dashboard Time Filter

For the analytics dashboard page, add a Time filter, only viewing data in a specific range.

1. Today
2. Last 7 Days
3. Last 30 Days
4. Last 6 Months
6. Custom Range
7. All Time"

6. "Generate a query to input 100 entries of mock data within the time range of a year, distributed randomly."

7. "#002 Minor Color Change

Change the current blue hue throughout the whole page to this hue #007CFD"

8. "#003 Minor Color Change

Change current blue to #004D9E"

9. "Monthly Visits Div Functionality

1. Expand div when clicked on
2. Div header title changes dynamically based on the applied filter
3. Based on the applied filter, time intervals must be appropriate 

3.1 E.g. Applied filter = "Last 7 Days". X-axis should display the dates for the last 7 days

3.2 E.g. Applied filter = "Today". X-axis should display Entry-Based intervals based on the entered time within the day"

10. "Encounter Log Sorting

Encounter log entries must be sorted by encounter date, not input recency."

11. "Generate an SQL that satsifies these conditions:

1. Removes all current data
2. Adds 10 randomly named patients
3. 50 records with random mock data for each patient, spread across the span of March 2025 to March 2026"

12. "#1701 - Cannot truncate a table referenced in a foreign key constraint (`valdescare`.`consultation`, CONSTRAINT `fk_consult_patient` FOREIGN KEY (`patient_id`) REFERENCES `valdescare`.`patient` (`patient_id`))"

13. "Generate an SQL query to add 20 entries of mock data to each patient with their entry dates scattered around the month of April 2026."

15. "Overhaul, Changes to Patient Registration Fields

Practice strict adherence to the attached image. Fields that are not present in the image, but exist in the form, must be removed E.g Vitals tab.

Then, generate the query to drop affected tables, and to instantiate new ones"

16. "1. Fuse

2. Let's do Radio buttons for the NHTS"

17. "#1062 - Duplicate entry 'Pediatrics' for key 'uq_category_name'"

18. "#1054 - Unknown column 'patient_name' in 'field list'"

19. "Dashboard, Encounter Log, Reports / Print tabs present issues with database retrieval"

20. "Persisting error for index.php

Fatal error: Uncaught PDOException: SQLSTATE[42S02]: Base table or view not found: 1146 Table 'valdescare.household' doesn't exist in C:\xampp\htdocs\ccs06-appdev\final-test\index.php:17"

21. "Generate an SQL query for inputting to phypmyadmin. Satisfies the following conditions: 

30 patients of Philippine-centric names, with 10-50 visit records with varying but relatively relevant values unique to each person E.g. one person has a certain condition with thematically relevant remarks across the given time period.

For each unique patient, there must be visible progress seen through the inputted data towards their specific condition E.g. some people exhibit recurring diseases over the course of a month. 

Disperse the visit records over the course of four (4) months in between the range of December 14, 2026 to April 14, 2026."

22. "Are you able to track token generation with every output?"

23. "#1452 - Cannot add or update a child row: a foreign key constraint fails (`valdescare`.`consultation`, CONSTRAINT `fk_consult_physician` FOREIGN KEY (`physician_id`) REFERENCES `physician` (`physician_id`) ON DELETE SET NULL ON UPDATE CASCADE)"

24. "All the prompts during this session are to be added to prompts.md"

25. "Should be in verbatim with the exception of SQL scripts."

26. "Category Statistic For Pedatric, Adult, and Geriatric Patients

For patient registration, add a new input field categorizing the patient to be a pediatric, adult, or a geriatric. 

Generate an SQL query to create the new field, and for input of the appropriate category for each patient"

27. "Reiterating a previous prompt: "Generate an SQL query for inputting to phypmyadmin. Satisfies the following conditions: 

30 patients of Philippine-centric names, with 10-50 visit records with varying but relatively relevant values unique to each person E.g. one person has a certain condition with thematically relevant remarks across the given time period.

The severity degree of illnesses should only be appropriate and applicable to a small out-patient clinic. E.g. You would not expect a surgery to be held inside a facility this small.

For each unique patient, there must be visible progress seen through the inputted data towards their specific condition E.g. some people exhibit recurring diseases over the course of a month. 

Disperse the visit records over the course of four (4) months in between the range of December 14, 2026 to April 14, 2026.""
