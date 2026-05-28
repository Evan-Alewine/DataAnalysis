import pandas as pd
from sqlalchemy import create_engine

df = pd.read_csv('studentSurveyData.csv')
engine = create_engine('postgresql://postgres:<passwordhere>@localhost:5432/mentalHealthStudy')
df.to_sql('students', engine, if_exists='replace', index=False)