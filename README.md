# Data Analysis Projects
Showcase of different Data Analysis Projects

---

<h1>International Student Mental Health: A SQL Analysis</h1>

A Japanese international university (Ritsumeikan Asia Pacific University) surveyed its students in 2018 to examine whether studying abroad affects mental health. The resulting study found that international students face elevated mental health risks compared to the general population, and that two factors are especially predictive of depression: **social connectedness** (the degree to which a student feels they belong) and **acculturative stress** (the stress that arises from adapting to a new cultural environment).

This project replicates and extends that inquiry using PostgreSQL, exploring how length of stay influences depression, social connectedness, and acculturative stress among international students, and whether the study's central claim holds up under scrutiny.

<h2>Key Findings</h2>

<ul>
  <li>First-year students, both international and domestic, already show rates of mild depression, consistent with claims of elevated baseline risk.</li>
  <li>Depression scores increase through year three, with a notable drop at year four that may reflect proximity to program completion.</li>
  <li>Domestic students average a higher overall PHQ-9 score (8.61 vs 8.04), complicating the claim that international students face greater depression risk.</li>
  <li>When filtered to moderate-to-severe depression (PHQ-9 ≥ 10), international students outnumber domestic more than 2.5:1 — suggesting the elevated risk is tied to severity rather than prevalence.</li>
</ul>

<h2>Tools & Skills</h2>

<table>
  <tbody>
    <tr>
      <td><strong>Tools</strong></td>
      <td>PostgreSQL, pgAdmin 4, Python (pandas, SQLAlchemy), VS Code (SQLTools), Microsoft Excel (Forecasting, Pivot Tables)</td>
    </tr>
    <tr>
      <td><strong>Skills</strong></td>
      <td>Data cleaning and wrangling, SQL aggregation, filtering, aliasing, GROUP BY, ORDER BY, forecasting, python scripting, output cross-validation, psychometric data interpretation</td>
    </tr>
  </tbody>
</table>

<details>
  <summary><h2>Methodology & Extended Analysis</h2></summary>

  <h3>Dataset</h3>

  The students table provided by DataCamp contains 286 survey records from a single university cohort across 51 columns, covering demographics, language proficiency, mental health diagnostic scores, and social support indicators such as relationship status and social network size. After removing 18 rows with missing or invalid classification data, the working dataset included 268 usable responses.

  <img width="1550" height="917" alt="Dataset overview" src="https://github.com/user-attachments/assets/22d16bfc-c105-4947-8e26-140787f1f497" />

  Three validated psychometric instruments served as outcome variables:

  <table>
    <tbody>
      <tr>
        <td><strong>Column</strong></td>
        <td><strong>Instrument</strong></td>
        <td><strong>Interpretation</strong></td>
      </tr>
      <tr>
        <td>todep</td>
        <td>PHQ-9 (Patient Health Questionnaire)</td>
        <td>Depression severity scored 0–27; higher scores indicate greater severity</td>
      </tr>
      <tr>
        <td>tosc</td>
        <td>SCS (Social Connectedness Scale)</td>
        <td>Sense of belonging; higher scores indicate stronger social connection</td>
      </tr>
      <tr>
        <td>toas</td>
        <td>ASISS (Acculturative Stress Inventory)</td>
        <td>Cultural adaptation stress; higher scores indicate greater difficulty adjusting</td>
      </tr>
    </tbody>
  </table>

  <h3>Setup</h3>

  After downloading the CSV from DataCamp, I installed PostgreSQL and set up a local database in pgAdmin 4. Rather than manually defining a 51-column table with <code>CREATE TABLE</code>, I wrote a short Python script using pandas and SQLAlchemy to import the CSV as a dataframe and push it directly to a local server. The script is included in the project files as <code>createTable.py</code> (note: requires the psycopg2 database adapter).

  I then connected to the server via SQLTools in VS Code and ran the completed code from the completed Data Camp project to confirm a successful setup. One adjustment was required, calling the AVG() function needed <code>::numeric</code> appended to the closing parenthesis, as several fields were imported as double precision types. Results were validated against DataCamp's expected output before proceeding with the extended analysis.

  <h3>Length of Stay — International Students</h3>

  Running the core query on international students, depression scores increase from year one through year three, then drop at year four. One plausible explanation is that year four students are nearing program completion and anticipating return home; an idea which is further supported by a decrease in social connectedness scores and increase in acculturative stress scores in the same year, potentially due to students beginning to mentally disengage from academic stress, new friends, and local customs. That said, this remains speculative given the lack of repeat surveys on individuals over time.

  Years five and above have one international participant each with year six being an outlier with 3, making trend analysis unreliable. To illustrate this, I modeled a forecast in <code>qaresults.xlsx</code> using two approaches: one using all available data forecasting to year 15, and one forecasting years five and six based only on years one through four. The constrained forecast predicted a year six PHQ-9 of 9.59 where the actual year six participants averaged 6.00.

  <h3>International vs. Domestic Comparison</h3>

  Running the same completed project query on domestic students produced an unexpected result: domestic students averaged a higher PHQ-9 (8.61) than international students (8.04). While the difference is unlikely to be statistically meaningful given the sample sizes, it creates some friction with the claim that international students face higher risk of depression.

  <img width="2559" height="1394" alt="SQL in VS Code showing Domestic Table PHQ, SCS, and ASISS scores by year" src="https://github.com/user-attachments/assets/09d4977a-b96d-45ab-b218-c66a1c2e919f" />

  When filtering to moderate-to-severe depression (PHQ-9 >= 10), international students account for 69 cases compared to 27 domestic, a ratio of more than 2.5:1. This suggests the claim about depression risk is better understood as international students facing elevated risk of significant depression, rather than depression in general. The difference is in severity, not prevalence.

  <h3>Project Files</h3>

  ```
  ├── README.md
  ├── analysis.sql                   # All queries with inline commentary
  ├── createTable.py                 # Python script to load CSV into PostgreSQL
  ├── qa.sql                         # SQL file of completed Data Camp Project
  ├── qaForecast.xlsx                # Forecast comparison and QA validation
  ├── qaresults.csv                  # CSV export of qa.sql
  └── studentSurveyData.csv          # Source data
  ```

</details>
