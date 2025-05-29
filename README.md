# Healthcare-Analytics

Here's a professional and comprehensive `README.md` you can use for your GitHub project based on the SQL code you provided. This README assumes the dataset is a fictional or anonymized healthcare dataset used for analytics purposes:

---

# 🏥 Healthcare Encounter Analytics (SQL Project)

This project showcases an end-to-end SQL-based analysis of a healthcare dataset involving patient encounters, procedures, outcomes, and demographics. It addresses key operational and clinical performance questions using advanced SQL querying techniques. The focus is on extracting actionable insights that can inform hospital administration, payer negotiations, and patient care strategies.

---

## 📊 Project Objective

To analyze healthcare encounter data to evaluate patient care outcomes, operational efficiency, and financial performance across different segments such as payer, provider, encounter class, and demographics.

---

## 💻 Technologies Used

* **SQL Server (T-SQL)**
* **SSMS / Azure Data Studio** (Recommended for executing scripts)
* **Relational Tables**:

  * `encounters`
  * `patients`
  * `procedures`
  * `payers`

---

## 🧠 Key Questions Answered

### 1. 🔁 **Readmission Analysis**

* What percentage of patient encounters result in a **readmission within 30 days**?
* Which **encounter class** (e.g., emergency, inpatient) has the **highest readmission rate**?

### 2. ⏱️ **Length of Stay by Encounter Class**

* How does the **average length of stay** (based on start and stop timestamps) differ across encounter types?

### 3. 🏥 **Patient Throughput & Wait Time**

* Which organizations or locations have the **highest patient throughput** (encounters per day)?
* Where are **average wait times** the longest?

### 4. 💰 **Net Revenue Loss by Payer**

* What is the **average net revenue loss per encounter** calculated as the difference between `Total_Claim_Cost` and `Payer_Coverage`?

### 5. ⚙️ **Procedure Cost Analysis**

* Which **procedures** have the **highest average base cost**, and how frequently are they performed?

### 6. 👥 **Demographic Visit Patterns**

* Which **demographic groups** (based on age, gender, race) visit most frequently for **urgent care vs. wellness** encounters?

### 7. ⚰️ **Post-Encounter Mortality by County**

* Which **counties or states** exhibit the **highest mortality rates** after the last patient encounter?

---

## 🧾 Sample SQL Snippets

Here’s an example of how readmissions within 30 days are calculated using window functions:

```sql
WITH re AS (
  SELECT 
    PATIENT, 
    [START], 
    LAG([START]) OVER (PARTITION BY PATIENT ORDER BY [START]) AS previous_admission,
    DATEDIFF(DAY, LAG([START]) OVER (PARTITION BY PATIENT ORDER BY [START]), [START]) AS diff
  FROM dbo.encounters
)
SELECT COUNT(DISTINCT PATIENT) * 100.0 / (SELECT COUNT(*) FROM dbo.encounters) AS Readmission_Percentage
FROM re
WHERE diff > 0 AND diff <= 30;
```

---

## 📂 Folder Structure

```
📁 SQL-Healthcare-Analytics
│
├── 📄 README.md             # Project documentation
├── 📄 encounter_analysis.sql  # All SQL queries (this file)
```

---

## ✅ Skills Demonstrated

* Analytical thinking and healthcare KPIs
* Use of **window functions** (`LAG`)
* **Date/time operations** (`DATEDIFF`, `CAST`)
* Aggregation and grouping techniques
* **Revenue and cost calculations**
* Joining and updating relational datasets
* Designing KPIs like throughput and mortality rate

---

## 📌 Notes

* This project uses **anonymized or simulated data**.
* Queries are optimized for SQL Server. Minor tweaks may be needed for other RDBMS systems like PostgreSQL or MySQL.
* Results may vary depending on data quality and completeness.

---

## 📧 Contact

**Author:** Yatish
**LinkedIn:** [linkedin.com/in/yatish](https://linkedin.com/in/yatish)
**Email:** \[[your-email@example.com](mailto:your-email@example.com)]

---

Let me know if you'd like this converted into a downloadable `README.md` file or if you'd like me to generate a nice project name or logo.
