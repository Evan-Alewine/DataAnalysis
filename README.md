# Data Analysis Projects
A showcase of different Data Analysis Projects

---

<h1>International Student Mental Health: A SQL Analysis</h1>

DataCamp's SQL Fundamentals track includes a bonus project built on a 2018 survey from a Japanese international university. Its framing tells learners that the study behind the data found <em>"international students have a higher risk of mental health difficulties than the general population"</em> and that social connectedness and acculturative stress predict depression (DataCamp, accessed 2026).

This project locally replicates and extends that exercise, uncovering how small changes across multiple handoffs can accumulate into misrepresentative claims.

## Key Findings
- On average, students in this survey scored in the mild range of the PHQ-9 scale, regardless of international status or year. Only three year-groups averaged above the moderate threshold, and each contained one or two students.
- Domestic students average a higher overall PHQ-9 score and cross the clinical threshold more often, yet fewer of them meet the symptom criteria for a depressive disorder. The three measures disagree, and none of the gaps is large enough to be reliable.
- DataCamp's exercise claims that international students face higher risk of mental health difficulties than the general population, oversimplifying the original study's claim, and when taken with the accompanying instructions leads learners to false assumptions.

## Tools and Skills
<table>
  <tbody>
    <tr>
      <td><p><strong>Tools</strong></p></td>
      <td><p>PostgreSQL, pgAdmin 4, Python (pandas, SQLAlchemy), VS Code (SQLTools), Microsoft Excel (Forecasting, Pivot Tables, Analysis ToolPak)<p></td>
    </tr>
    <tr>
      <td><p><strong>Skills</strong></p></td>
      <td><p>Data cleaning and wrangling, SQL aggregation, filtering, aliasing, GROUP BY, ORDER BY, hypothesis testing, forecasting, python scripting, output cross-validation, source verification, psychometric data interpretation.</p></td>
    </tr>
  </tbody>
</table>

<details>
  <summary><h1>Full Walkthrough</h1></summary>

  <details><summary><h3>Datacamp's Exercise</h3></summary>

  The students table provided by Datacamp contains 286 survey records from a single university cohort across 51 columns, covering demographics, language proficiency, mental health diagnostic scores, and social support indicators such as relationship status and social network size. Of those, 18 records carry missing or invalid classification data and drop out of any grouped query, leaving 268 usable responses: 201 international and 67 domestic. Yet the exercise itself only asks for a single table describing how the length of stay relates to average mental health scores among international students.
  <img width="1550" height="917" alt="Datacamp's Student Table" src="https://github.com/user-attachments/assets/22d16bfc-c105-4947-8e26-140787f1f497" />
 The following is the SQL and resulting table for Datacamp's exercise:
<table>
    <tr>
        <td>stay</td>
        <td>count_int</td>
        <td>average_phq</td>
        <td>average_scs</td>
        <td>average_as</td>
    </tr>
    <tr>
        <td>10</td>
        <td>1</td>
        <td>13.00</td>
        <td>32.00</td>
        <td>50.00</td>
    </tr>
    <tr>
        <td>8</td>
        <td>1</td>
        <td>10.00</td>
        <td>44.00</td>
        <td>65.00</td>
    </tr>
    <tr>
        <td>7</td>
        <td>1</td>
        <td>4.00</td>
        <td>48.00</td>
        <td>45.00</td>
    </tr>
    <tr>
        <td>6</td>
        <td>3</td>
        <td>6.00</td>
        <td>38.00</td>
        <td>58.67</td>
    </tr>
    <tr>
        <td>5</td>
        <td>1</td>
        <td>0.00</td>
        <td>34.00</td>
        <td>91.00</td>
    </tr>
    <tr>
        <td>4</td>
        <td>14</td>
        <td>8.57</td>
        <td>33.93</td>
        <td>87.71</td>
    </tr>
    <tr>
        <td>3</td>
        <td>46</td>
        <td>9.09</td>
        <td>37.13</td>
        <td>78.00</td>
    </tr>
    <tr>
        <td>2</td>
        <td>39</td>
        <td>8.28</td>
        <td>37.08</td>
        <td>77.67</td>
    </tr>
    <tr>
        <td>1</td>
        <td>95</td>
        <td>7.48</td>
        <td>38.11</td>
        <td>72.80</td>
    </tr>
</table>
   <details><summary>The SQL Query</summary>  
   
   ```sql
    SELECT
      stay,
        COUNT(inter_dom) AS count_int,
        ROUND(AVG(todep), 2) AS average_phq,
        ROUND(AVG(tosc), 2) AS average_scs,
        ROUND(AVG(toas), 2) AS average_as
      FROM students
      WHERE stay IS NOT NULL
        AND inter_dom LIKE 'Inter'
      GROUP BY stay
      ORDER BY stay DESC;
  ```
 </details>
  The initial dataset and exercise solution can also be found in the `qa.sql`, `qaresults.csv` files.
  Breaking down the results table, we see that it shows the survey responses of international students by year, the number of students in that year, followed by three scores that serve as outcome variables.
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
  Yet, this is where the Datacamp project ends.
  </details>

  <details><summary><h3>Setting up locally</h3></summary>
    To work past the assigned query I moved the dataset onto my own machine. I installed PostgreSQL, created a database in pgAdmin 4, and rather than hand-writing a 51-column table definition with <code>CREATE TABLE</code>, I wrote a short Python script to read the CSV into a data frame and load it to the server directly; that script can be found in `createTable.py` (note: requires psycopg2).
  I connected to my new local server through VS Code using the SQLTools extension, and re-ran the original solution to confirm the local copy matched. 
  After a brief delay, I found that my `AVG()` functions required the inclusion of <code>::numeric</code>, since several fields imported as floating point. The output matched exactly, so I moved forward onto the next step.
  </details>
  <details><summary><h3>Initial Querying</h3></summary>
    The claim in the exercise singles out international students, implying that domestic students are at less of a risk than their international counterparts: since, if both scores were about the same, it would be more accurate to say that students in general are at greater risk than the general population.
    The dataset contains both groups, so testing it meant changing one word in the query: 'Inter' to 'Dom', a merged table for side by side comparison is provided below, as well as in `analysis.sql`
  <table>
    <tr>
        <td>stay</td>
        <td>inter_pop</td>
        <td>inter_phq</td>
        <td>dom_pop</td>
        <td>dom_phq</td>
    </tr>
    <tr>
        <td>1</td>
        <td>95</td>
        <td>7.48</td>
        <td>20</td>
        <td>8.70</td>
    </tr>
    <tr>
        <td>2</td>
        <td>39</td>
        <td>8.28</td>
        <td>13</td>
        <td>9.46</td>
    </tr>
    <tr>
        <td>3</td>
        <td>46</td>
        <td>9.09</td>
        <td>23</td>
        <td>8.43</td>
    </tr>
    <tr>
        <td>4</td>
        <td>14</td>
        <td>8.57</td>
        <td>9</td>
        <td>7.00</td>
    </tr>
    <tr>
        <td>5</td>
        <td>1</td>
        <td>0.00</td>
        <td>2</td>
        <td>11.50</td>
    </tr>
    <tr>
        <td>6</td>
        <td>3</td>
        <td>6.00</td>
        <td>0</td>
        <td></td>
    </tr>
    <tr>
        <td>7</td>
        <td>1</td>
        <td>4.00</td>
        <td>0</td>
        <td></td>
    </tr>
    <tr>
        <td>8</td>
        <td>1</td>
        <td>10.00</td>
        <td>0</td>
        <td></td>
    </tr>
    <tr>
        <td>10</td>
        <td>1</td>
        <td>13.00</td>
        <td>0</td>
        <td></td>
    </tr>
</table>
    <details><summary>The SQL Query</summary>
      
  ```sql
    --Breakdown of PHQ-9 by year & group
    SELECT stay,
      COUNT(*) FILTER (WHERE inter_dom = 'Inter')                        AS inter_pop,
      ROUND((AVG(todep) FILTER (WHERE inter_dom = 'Inter'))::numeric, 2) AS inter_phq,
      COUNT(*) FILTER (WHERE inter_dom = 'Dom')                          AS dom_pop,
      ROUND((AVG(todep) FILTER (WHERE inter_dom = 'Dom'))::numeric, 2)   AS dom_phq
    FROM students
    WHERE inter_dom IN ('Inter', 'Dom')
      AND stay IS NOT NULL
        GROUP BY stay
        ORDER BY stay;
  ```
  </details>
Looking closer at that table, the last five rows describe almost nobody. Years 7, 8, and 10 contain one student each, year 5 contains one, and year 6 contains three. Year 5 reads 0.00 because a single student scored zero. Those rows carry the same visual weight as year 1 with its 95 students, and any trend drawn through them is being set by individuals.

To show how badly that behaves, I built two forecasts in qaForecast.xlsx. The first projects out to year 15 using every year available. The second projects years 5 and 6 using only years 1 through 4, then compares the prediction against what those years actually contain. The constrained forecast predicted a year 6 average of 9.59. The three students actually in year 6 averaged 6.00, an overshoot of roughly 60%.

The exercise asks for a nine-row table and gets one. Four of those rows are a single respondent.

At this point it occurred to me that the domestic PHQ-9 scores seem to be slightly higher than the international ones, directly contradicting the implied claim that international students are at higher risk than domestic ones. So, I created another table to compare their average scores directly.

<table>
    <tr>
        <td>inter_dom</td>
        <td>n</td>
        <td>mean_phq9</td>
        <td>sd_phq9</td>
        <td>mean_scs</td>
        <td>mean_as</td>
    </tr>
    <tr>
        <td>Inter</td>
        <td>201</td>
        <td>8.04</td>
        <td>4.90</td>
        <td>37.42</td>
        <td>75.56</td>
    </tr>
    <tr>
        <td>Dom</td>
        <td>67</td>
        <td>8.61</td>
        <td>5.12</td>
        <td>37.64</td>
        <td>62.84</td>
    </tr>
</table>
<details><summary>The SQL Query</summary>

```sql
--Inter_Dom descriptive statistics, population size, averages of psychometrics and standard deviation for PHQ-9
SELECT inter_dom,
       COUNT(*)                              AS n,
       ROUND(AVG(todep)::numeric, 2)         AS mean_phq9,
       ROUND(STDDEV_SAMP(todep)::numeric, 2) AS sd_phq9,
       ROUND(AVG(tosc)::numeric, 2)          AS mean_scs,
       ROUND(AVG(toas)::numeric, 2)          AS mean_as
FROM students
WHERE inter_dom IN ('Inter', 'Dom')
  AND stay IS NOT NULL
GROUP BY inter_dom;
```
</details>
This table clearly showed that domestic students had a mean PHQ-9 score .57 points higher than the international students on a 27 point scale. Yet that small of a gap is not statistically significant, verified Welch's t-Test found in `t-Test.xlsx` using Excel's Analysis ToolPak. 

So if the average PHQ-9 was not higher, it may be that the authors meant frequency. Given that the PHQ-9 is typically scored in bands, seen [here](https://phq-9.org/blog/phq-9-score-guide-understanding-your-depression-score) I set the cutoff at 10 points indicating "moderate levels of depression". 
<table>
    <tr>
        <td>inter_dom</td>
        <td>n</td>
        <td>mod_or_greater</td>
        <td>%</td>
    </tr>
    <tr>
        <td>Inter</td>
        <td>201</td>
        <td>69</td>
        <td>34.33</td>
    </tr>
    <tr>
        <td>Dom</td>
        <td>67</td>
        <td>27</td>
        <td>40.30</td>
    </tr>
</table>
<details><summary>The SQL Query</summary>

  ```sql
  -- Shows survey responses with PHQ-9 results >= 10 as a percent for inter_dom.
SELECT inter_dom,
       COUNT(*)                                        AS n,
       COUNT(*) FILTER (WHERE todep >= 10)             AS mod_or_greater,
       ROUND(100.0 * COUNT(*) FILTER (WHERE todep >= 10)
             / COUNT(*), 2)                            AS "%"
FROM students
WHERE inter_dom IN ('Inter', 'Dom')
  AND stay IS NOT NULL
GROUP BY inter_dom;
  ```
</details>
When we look at quantity of students with PHQ-9 scores >= 10, it seems that international students out number domestic students nearly 2.5:1. However, that does not account for the sample size difference between the two groups. When expressed as a percentage to show frequency of higher PHQ-9 scores, we see that domestic students actually show a higher frequency than international students.

To verify, I ran a chi-square test of independence on the counts, also included in `t-Test.xlsx`. The observed values against those expected if the two groups behaved identically:

<table>
    <tr>
        <td></td>
        <td>Scored &gt;= 10</td>
        <td>Scored &lt; 10</td>
    </tr>
    <tr>
        <td>International (observed)</td>
        <td>69</td>
        <td>132</td>
    </tr>
    <tr>
        <td>International (expected)</td>
        <td>72</td>
        <td>129</td>
    </tr>
    <tr>
        <td>Domestic (observed)</td>
        <td>27</td>
        <td>40</td>
    </tr>
    <tr>
        <td>Domestic (expected)</td>
        <td>24</td>
        <td>43</td>
    </tr>
</table>

Excel's `CHISQ.TEST` returns a p-value of 0.38, meaning a split this uneven would turn up by chance nearly two times in five. The frequency difference is no more reliable than the difference in averages.

At this point, we have two indicators that domestic students are at higher risk than international students, and neither survives testing. Taking a closer look at the `t-Test.xlsx` we see the following:
<table>
    <tr>
        <td>x</td>
        <td>Variable 1</td>
        <td>Variable 2</td>
    </tr>
    <tr>
        <td>Mean</td>
        <td>8.611940299</td>
        <td>8.044776119</td>
    </tr>
    <tr>
        <td>Variance</td>
        <td>26.18046133</td>
        <td>24.05298507</td>
    </tr>
    <tr>
        <td>Observations</td>
        <td>67</td>
        <td>201</td>
    </tr>
    <tr>
        <td>Hypothesized Mean Difference</td>
        <td>0</td>
        <td></td>
    </tr>
    <tr>
        <td>df</td>
        <td>109</td>
        <td></td>
    </tr>
    <tr>
        <td>t Stat</td>
        <td>0.793862084</td>
        <td></td>
    </tr>
    <tr>
        <td>P(T&lt;=t) one-tail</td>
        <td>0.214500299</td>
        <td></td>
    </tr>
    <tr>
        <td>t Critical one-tail</td>
        <td>1.658953458</td>
        <td></td>
    </tr>
    <tr>
        <td>P(T&lt;=t) two-tail</td>
        <td>0.429000599</td>
        <td></td>
    </tr>
    <tr>
        <td>t Critical two-tail</td>
        <td>1.98196749</td>
        <td></td>
    </tr>
</table>

As a part of our `t-Test.xlsx` we found our <strong>p-value</strong> in cell B12, which asks if there really is a difference in two sets of data. Typically, a p-value of 0.05 is used to justify distinguishing two groups, meaning our value of .43 is far too large to say our international and domestic student groups are meaningfully different enough to be separated.

In plain terms, the study's domestic students are no worse off than the international ones. Neither the severity nor the frequency gap was large enough to show anything conclusively. That returns us to the argument made at the top of this section: if both groups score about the same, then whatever elevated risk exists belongs to students generally, not to international students specifically.

Yet, searching the university's name alongside some key words turned up the open access data set found [here](https://www.mdpi.com/2306-5729/4/3/124). While reviewing the dataset's publication (Nguyen et al., 2019b) I found the original study that the data was produced for (Nguyen et al., 2019a). In that study the authors produced a table showing the prevalence of depression, showing that international students have higher rates of depression by almost 8%.

<img width="1010" height="903" alt="image" src="https://github.com/user-attachments/assets/9134dc14-ca48-4ed7-8d5d-3b6b194cab23" />

Sadly the exact process of creating this table was not spelled out, but there was a clue in the statistical analysis section where the authors state that <em>"People who suffered from major or other depressive disorder were considered as being depressed"</em> (Nguyen et al., 2019a). Given that the deptype column only contains entries of "no", "major", and "other", I was able to reproduce the values on the table using the count of non-no entries from that column by international status. 

<table>
    <tr>
        <td>inter_dom</td>
        <td>n</td>
        <td>deptype</td>
        <td>%</td>
    </tr>
    <tr>
        <td>Inter</td>
        <td>201</td>
        <td>76</td>
        <td>37.81</td>
    </tr>
    <tr>
        <td>Dom</td>
        <td>67</td>
        <td>20</td>
        <td>29.85</td>
    </tr>
</table>

<details><summary>The SQL Query</summary>
  
  ```sql
  -- Review of deptype frequency
    SELECT inter_dom,
           COUNT(*)                                                     AS n,
           COUNT(*) FILTER (WHERE deptype IN ('Major', 'Other'))        AS deptype,
           ROUND(100.0 * COUNT(*) FILTER (WHERE deptype IN ('Major', 'Other'))
                 / COUNT(*), 2)                                         AS "%"
    FROM students
    WHERE inter_dom IN ('Inter', 'Dom')
      AND stay IS NOT NULL
    GROUP BY inter_dom;
  ```
</details>

  The results from the latest table match the table produced by the original study, indicating that the author used depression type as the basis for determining depression rather than the PHQ-9 scores.

  That leaves three measures of the same construct, drawn from the same questionnaire and the same 268 students, giving two different answers:

<table>
    <tr>
        <td>Measure</td>
        <td>International</td>
        <td>Domestic</td>
        <td>Higher</td>
    </tr>
    <tr>
        <td>Average PHQ-9 score</td>
        <td>8.04</td>
        <td>8.61</td>
        <td>Domestic</td>
    </tr>
    <tr>
        <td>Rate scoring 10 or above</td>
        <td>34.33%</td>
        <td>40.30%</td>
        <td>Domestic</td>
    </tr>
    <tr>
        <td>Rate meeting diagnostic criteria</td>
        <td>37.81%</td>
        <td>29.85%</td>
        <td>International</td>
    </tr>
</table>
  </details>

  <details><summary><h3>Solution and Discussion</h3></summary>
  Both columns, "deptype" and "depsev", measures exactly 96 of the 268 students, yet they disagree about which 96.
  
  The original authors describe both procedures in their measures section (Nguyen et al., 2019a). The severity score treats all nine items equally: each is scored from 0 for not at all to 3 for nearly every day, summed to a range of 0 to 27, then banded into minimal, mild, moderate, moderately severe, and severe at cutoffs of 4, 9, 14, and 19. Any combination of symptoms reaching 10 lands in the moderate band.
  
  The diagnostic classification works differently. It counts only symptoms present at least more than half the days, requires five of them for major depressive disorder or two for other depressive disorder, and requires that one of those be depressed mood or anhedonia.
  
  That last requirement is what separates the two. A student reporting poor sleep, exhaustion, low appetite and trouble concentrating can pass 10 comfortably and still fail the diagnostic rule, because neither required symptom is present. Another student reporting persistent hopelessness and little else can meet the rule while scoring below the cutoff.
  
  The two measures answer different questions. One asks how much distress a student reported. The other asks whether that distress matches a clinical definition. In this cohort, more domestic students carried heavy symptom loads, and more international students carried the specific pattern the diagnostic rule looks for. 
  
  Still, neither difference is large enough to be reliable, which is why the original authors used both, matched to different questions. The diagnostic classification answered their prevalence question and served as the outcome in their logistic regression, which requires a yes-or-no variable. The continuous score served as the outcome in their correlation and regression work on connectedness and acculturative stress.
  
  It is worth noting that only the "todep" column appears in the exercise's data description. The column related to the claim being tested is present in the file but never mentioned.
  
  Similarly, in the original article, the authors referenced another study stating that depression is more prevalent among university students than the general population (Ibrahim et al., 2013, as cited in Nguyen et al., 2019a).
  
  Gaining access to Ibrahim et al.'s 2013 study, we have a quote one level higher showing more of the complete picture:
  
  "The current review included studies published between January 1990 and October 2010 and reporting on depression among undergraduate university students including medical students. According to this current review the average depression prevalence is 30.6%, a higher rate than the 9% found in the general population rates of the US (range 6-12%)" (Gonzalez et al., 2010, as cited by Ibrahim et al., 2013). 
  
  Referenced by Nguyen et al.'s 2019a study as
  
  "Depression is more prevalent in university students compared to the general population (Ibrahim et al., 2013), even in Japan" (Nguyen et al., 2019a)
  
  To the dataset's publication (Nguyen et al., 2019b)
  
  "University students, especially international students, possess a higher risk of mental health problems" (Nguyen et al., 2019b)
  
  Finally arriving at Datacamp's claim
  
  "international students have a higher risk of mental health difficulties than the general population" (DataCamp, accessed 2026)
  
  Each step is defensible on its own. Ibrahim et al.'s citation compares university students to the general public and never separates international from domestic. Nguyen et al. repeat that correctly, then add their own finding about international students relative to domestic ones. The dataset's abstract compresses both into a single sentence. The exercise credits the result to one study, drops the qualifier, and hands the learner a column that returns the opposite direction.
  
  While the claims are not false anywhere in the citation chain, each citation loses a little bit of nuance leading to misleading claims, especially in later contexts. Combining the two studies, international students at this university are more depressed than the general population, but so are the domestic students sitting next to them. The claim is true of both groups and distinguishes neither, and the single depression score the exercise points to cannot reproduce it.
    
<h3>Project Files</h3>

```
    ├── README.md
    ├── analysis.sql                   # All queries with inline commentary
    ├── createTable.py                 # Python script to load CSV into PostgreSQL
    ├── qa.sql                         # SQL file of completed Data Camp Project
    ├── qaForecast.xlsx                # Forecast comparison and QA validation
    ├── t-Test.xlsx                    # Welch's t-test and chi-square test
    └── studentSurveyData.csv          # Source data
```
  <h3>References</h3>
  DataCamp. Analyzing Students' Mental Health [bonus project, SQL Fundamentals track]. Accessed 2026.
  
  Ibrahim, A. K., Kelly, S. J., Adams, C. E., & Glazebrook, C. (2013). A systematic review of studies of depression prevalence in university students. Journal of Psychiatric Research, 47(3), 391–400. https://doi.org/10.1016/j.jpsychires.2012.11.015
  
  Nguyen, M. H., Le, T. T., & Meirmanov, S. (2019a). Depression, acculturative stress, and social connectedness among international university students in Japan: A statistical investigation. Sustainability, 11(3), 878. https://doi.org/10.3390/su11030878
  
  Nguyen, M. H., Ho, M. T., Nguyen, Q. T., & Vuong, Q. H. (2019b). A dataset of students' mental health and help-seeking behaviors in a multicultural environment. Data, 4(3), 124. https://doi.org/10.3390/data4030124
  
  </details>
