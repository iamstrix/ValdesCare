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

14. "Fully describe the database's structure, relationships and everything in one paragraph. In a subsequent paragraph, generate a prompt that successfully visualizes the database's relationships, tables, etc. when inputted into an image generation LLM."
