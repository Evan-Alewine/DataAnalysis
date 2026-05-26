# Data Analysis Projects
Showcase of different Data Analysis Projects

<details>
  <summary><h2>International Student Mental Health Inquiry: A SQL Analysis</h2></summary>
  Tools Used: <br> 
  <table><tbody><tr><td>Postgre SQL</td></tr></tbody></table> <br>
  Skills Demonstrated: <br> 
   <table><tbody><tr><td>Data Cleaning, Wrangling and Analysis, Data Aggregation using SQL, Filtering, Aliasing, GROUP BY, ORDER BY, Behavioral / Psychometric Data Interpretation</td></tr></tbody></table> <br>

  <h3>Background</h3>
  A 2018 survey conducted at a Japanese international university examined whether studying abroad affects student mental health. The resulting study found that international students face elevated mental health risks compared to the general population, and that two factors are especially predictive of depression.
  <ul>
    <li><strong>Social connectedness</strong>, the degree to which a student feels they belong</li>
    <li><strong>Acculturative stress</strong>, the stress that arises from adapting to a new cultural environment</li>
  </ul>
This project replicates and extends that inquiry using SQL to better understand if the length of stay in Japan influence the mental health outcomes of international students?
  
  <h3>Dataset</h3>
  The students table provided by Data Camp contains 286 survey records from a single university cohort, with 50 coluimns covering demographics, language proficiency, mental health diagnostic scores, and     social support indicators such as relationship status and how many friends they have. After removing 18 rows with missing or fautly classification data, the working dataset included 268 viable survey replies. 
  <img width="1550" height="917" alt="image" src="https://github.com/user-attachments/assets/22d16bfc-c105-4947-8e26-140787f1f497" />
  Further, the dataset included three validated psychometric instruments that were used as outcome variables:
<table><tbody>
  <tr>
    <td><strong>Column</strong></td>
    <td><strong>Instrument</strong></td>
    <td><strong>Interpretation</strong></td>
  </tr>
  <tr>
    <td>todep</td>
    <td>PHQ-9, a patient health questionnaire</td>
    <td>Depression severity score rated from 0 to 27</td>
  </tr>
  <tr>
    <td>tosc</td>
    <td>SCS, a social connectedness scale</td>
    <td>Belongingness score indicating how connected participants felt</td>
  </tr>
  <tr>
    <td>toas</td>
    <td>ASISS, acculturative stress inventory</td>
    <td>Stress score measuring participants' feelings of cultural misalignment or poor adaptation</td>
  </tr>
</tbody></table>

<h3>Interpretation</h3>

</details>
