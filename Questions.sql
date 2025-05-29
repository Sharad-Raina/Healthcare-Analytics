/*  
Operations & Patient Care
What percentage of encounters result in readmissions within 30 days, 
and which encounter classes (inpatient/outpatient) have the highest readmission rates?
/*  



/* 
How does average length of stay (calculated from Start and Stop timestamps) vary by encounter class (e.g., emergency vs. wellness)?

Which organizations/locations have the highest patient throughput (encounters per day) and longest wait times?

Financial Performance
What is the net revenue loss per encounter (Total_Claim_Cost - Payer_Coverage) by payer, and which payers have the lowest coverage rates?

How does Base_Encounter_Cost correlate with the number of procedures performed during an encounter?

Which procedures (Procedures.Description) have the highest average Base_Cost, and how often are they performed?

Marketing & Patient Demographics
What demographic segments (age/gender/race) have the highest encounter frequency for urgent care vs. wellness visits? (Use BirthDate for age calculation)

How does patient proximity to organizations (calculated via Patients.Lat/Lon vs. Organization.Lat/Lon) affect encounter frequency?

Which counties/states (from Patients.County/State) have the highest mortality rates post-encounter?

Payer Analysis
Which payers cover the highest percentage of procedure costs, and do they prioritize specific encounter classes (e.g., elective vs. emergency)?

Are there regional trends (Payers.State_Headquartered) in payer coverage amounts or denied claims?

Clinical & Procedural Insights
What are the top 5 ReasonCode/ReasonDescription pairs for procedures, and do they align with the most frequent encounter diagnosis codes?

How does procedure frequency vary by patient age groups (pediatric/adult/geriatric)?

Strategic Planning
Which organizations have the highest proportion of patients with chronic conditions (based on recurring ReasonCode entries)?

What is the monthly trend in encounters, and are there seasonal spikes in specific encounter classes (e.g., flu season for urgent care)?
*/