# covid-19-spatial-analysis

This blog post looks at different aspects of mental and social health during the 2020 Covid-19 pandemic across the United States. The pandemic has been, and continues to be, a great source of anxiety, depression, and other regressive emotions for individuals, due to but not limited to the need for quarantine, social distancing, and a cruel but necessary departure from normal, pre-pandemic life. It is important to examine how the pandemic has impacted mental and social health, in different ways — this will help us understand and respond to the pandemic as a country. This Shiny app explores spatial patterns of anxiety and depression, social media presence of Covid-19 across counties, stress related to state-mandated shutdowns, and social vulnerability, across the contiguous United States.

**Final Shiny app:** https://klingliu.shinyapps.io/blogproject/?_ga=2.184523502.911096917.1612080009-1049883942.1612080009

**The Full Blog Post:** https://stat231-f20.github.io/Blog-Theory-of-Mind/

# Data

**Dataset 1: CDC Anxiety/Depression Surveys**

- **Link:** https://www.cdc.gov/nchs/covid19/health-care-access-and-mental-health.htm
- **Description:** I used data from the household “pulse polls” that were created by the CDC and the U.S. Census Bureau in the early stages of the pandemic in the US, starting on April 23 and continues to the present. I focused on the “Anxiety and Depression” survey, which asked four questions about the frequency of depressive/anxious emotions in the past seven days.
- The data was broken down into different categories, including race, gender, age group, and education level. By examining the quantitative values associated with anxiety and depression from the survey, I can explore the ways that depressive/anxious symptoms change across different demographic groups.
- On their website, the CDC notes that this survey uses data collected in a somewhat unconventional manner, given the short duration between data collection and data analysis.


**Dataset 2:** ***The New York Times*** **Covid-19 Data**

- **Link:** https://github.com/nytimes/covid-19-data
- **Description:** This dataset was retrieved from *The New York Times* GitHub where they've made publicly available Covid-19 data that they have collected since January 2020. It contains information per week for how many current and probable cases and deaths there are in each county. I use only the information for confirmed current cases and have changed the time progression to monthly.


**Dataset 3: CDC 2018 Social Vulnerability Index**

- **Link:** https://www.atsdr.cdc.gov/placeandhealth/svi/data_documentation_download.html
- **Description:** The CDC has collected data through census tracts in 2000, 2010, 2014, 2016, and 2018 to investigate the social vulnerability of communities in the U.S. Natural disasters and infectious disease outbreaks, particularly Covid-19, pose threats to community health. Due to factors like socioeconomic status, household composition, minority identity, housing type, transportation limits, and disability, certain communities are even more socially vulnerable than others and at particularly high risk to these disasters.
- I've included this dataset in order to have a spatial view of how social vulnerability correlates with mental health factors and Covid-19 infection. The data has all the aforementioned variables on scales decided by the CDC; I use the cumulative value that assigns an overall score of vulnerability to every individual county in the contiguous United States. This data is temporally static, as it is a snapshot of community vulnerability at the time the last batch of census data was released in 2018.


**Dataset 4: Social Media Counts During Covid-19**

- **Link:** https://coronavirus-resources.esri.com/datasets/feb6280d42de4e91b47cf37344a91eae_0?page=4&showData=true
- **Description:** This dataset includes counts of social media posts that mention COVID-19 for each included county, though the central United States region suffers from a paucity of data as time progresses. This data is provided per week starting in January, 2020, and is updated through August, but I only use the data starting in April.
- I've included this dataset because social media in our modern era is inextricably entwined with mental health and self-expression. The dataset includes county locations, total posts per week, unique users per week, and sentiment analysis values. For our analysis I only use county locations and total posts per week, which I've changed into months.


**Dataset 5: State Actions and Mandates in Response to Covid-19**

- **Link:** https://www.arcgis.com/home/item.html?id=90a137c9e0494ecab29672bba8cb3ee0&sublayer=0#data
- **Description:** This dataset compiles information on how each state initially reacted to the pandemic around the month of March, 2020. The variables include written descriptions of what each state did in regard to curfew, masks, wage changes, non-essential business closures, limits on gathering, emergency declarations, travel restrictions, school closures, and more.
- I focused in on three variables — mask policy, curfew, and wage changes.

**Other Datasets**
These other datasets were used for the spatial visualizations, which required extra geographic information.

1. Cities and counties. Link: https://simplemaps.com/data/us-cities
2. County-level and state-level data from the `maps` package


# Spatial Analysis

The spatial visualizations depict the values of certain explanatory variables across the contiguous United States during the months of April 2020 to August 2020, from near the beginning of the Covid-19 pandemic in the U.S. to the current time. I've chosen to hone in on anxiety and depression through time, our main dataset; social media counts of how many times Covid-19 was mentioned per county, through time; the initial state mandates in response to Covid-19 such as lockdown procedures; and the CDC's 2018 Social Vulnerability Index. Looking at these variables together should give us an idea of how these social factors may interact with each other during the current crisis. In addition to these variables, the hardest-hit cities have been represented by green dots on the map, which are sized according the number of cases in that city; this should provide a view of how regions highly impacted by the pandemic are performing with respect to our main variables.


## Results

### Usage of Data

While the usage of the anxiety and depression, social media, and social vulnerability datasets were rather straightforward (directly used quantitative variables on predetermined scales), the usage of the state actions dataset was not. The state actions are, of course, not listed in numbers — the dataset only means to provide us a summary of every state's policies in words; so, I had to find a way to turn this dataset into something that *is* quantifiable for our maps.

I focused in on three variables — mask policy, curfew, and wage changes because I felt that these were generally the most representative for all the other variables in the dataset. Each variable was converted to a scale of 1 to 4 based on the policy. For example, for mask policy, the levels were "Recommendation", "Mandatory (for essential business employees)", "Mandatory (for essential business employees and patrons while on premises)", and "Mandatory". These were assigned values of 1, 2, 3, and 4, respectively, based on their perceived causative power for stress. In the end, a scale of 1-12 indicated the relative "stress" imposed by the state government onto the citizens on the basis of the pandemic.

Note that our stress scale does not necessarily correlate with a "good" or "bad" government, and even less so political affiliation. Even though there are certainly political factors that can lead to certain governments making "bad" decisions for public health, population is also an important factor that affects a state's policies. Even more importantly, in this pandemic certain "bad" decisions are the more relaxing ones while other "bad" decisions are more stressful. Take for example curfew; enforced curfew was assigned a 4 for stress but is considered a "good" government decision, while "no wage extension" was also assigned a 4 for stress but is considered a "bad" government decision.

### Trends

**Quick Overview**

*Covid-19 Cases*

- As the pandemic progressed, cases decreased in New England and increased everywhere else.
- This is relevant; please keep in mind for the other variables!

*Anxiety and Depression*

- Coastal and southern states tended to report higher levels of anxiety and depression than did the rest of the U.S. The northern central states and the Midwest were the least depressed.
- Anxiety and depression tended to increase as the pandemic progressed.

*Social Media Counts*

- Overall, the most urban areas had the highest counts of Covid-19 mentions.*
- Mentions of Covid-19 slowly increased from April to August.

*State Actions and Responses*

- It appears that the projected stress resulting from state responses was highest in the west, the south, and New England.**

*Social Vulnerability Index (SVI)*

- Communities arching along the Pacific coast and the south had higher SVI's than did the rest of the country, with the communities in the southern portion of the East Coast being the most socially vulnerable.
- The northern central states and the Midwest had the lowest SVI's.

**Relationships**

- Anxiety and depression rose at the quickest rate in the more socially vulnerable regions.
- Anxiety and depression were also highest where there were the most cases.*
- Higher stress values were associated with greater anxiety and depression.
- Cases were more prevalent in more socially vulnerable regions than in others.
- Social media counts were highest where there were the most cases.*

*See Limitations tab.
**As mentioned in the Usage of Data tab, this does not at all correlate with the perceived "healthiness" (public, physical, or mental) of the state's actions.

### Impact

The overall conclusion that this map seems to support is that urban areas *and* socially vulnerable populations are by far the most likely to fall victim to Covid-19 and experience mental health decline. This is interesting because social vulnerability was not necessarily at its highest in the urban coastal areas, though it was certainly higher there than in rural areas. Regardless of the overlap between urbanism and social vulnerability, the relationship between these two groups and health detriments appears to be quite strong as we look at these maps side by side.

Social media does not seem to have too high of a relationship with any of the other variables, and if it does, then social media activity's relationship to urbanism most likely eclipses any other relationships that may be able to appear. Interestingly, though, mentions of Covid-19 slowly increased from April to August; this is worth noting because, rather than becoming weary of discussing the pandemic, it seems that interest and concern steadily mounted as time continued.

State actions were also tricky to assess because too many underlying variables muddle the correlation between stress levels associated with state mandate and the other variables. This will be further discussed in the Limitations tab.

### Limitations

- The most obvious limitation is in the quantification of the state actions dataset. State actions are difficult to quantify fairly, as I would have to weigh each variable's importance in the production of "stress". Furthermore, the quantification may be able to be improved by incorporating more of the variables, but for this project it was too tricky of an operation to code, so I settled on picking the most representative variables.
- The most important limitation that is applicable to all the analysis is that there are many lurking variables behind our selected variables of interest. Political alignment, population size and density, urbanism, and ruralism all affect the truth behind the relationships that I *seem* to see in these maps. Political alignment, as discussed before in Usage of Data, heavily affects the state mandate-associated stress values. Population density is a cause of greater numbers of Covid-19 cases and may eclipse other reasons for having high case counts. Urbanism and ruralism are huge lurking variables, as urbanism tends to be associated with greater reports of anxiety and depression, whether this is because of lessened stigma in urban areas or greater stress in fast-moving cities. Urbanism also affects social vulnerability, as easier access to resources draws in vulnerable individuals while higher costs of living exacerbate many communities' situations. Nonresponse bias could also be a problem in rural areas because rural areas may be less likely or less able to respond.
- The city values for Covid-19 cases are not actually the values for those cities; rather, those are the values for the county that the city is in, and the city that is plotted was simply picked for being the most representative of that county (having the greatest population). This works well visually since I cannot tell which cities are which son the map, and the points are simply there for us to gauge the general presence of cases. Still, this is a limitation worth noting.
- In the social media data, more and more counties have missing data as time progresses.


# Conclusion

The overall conclusion that the map seems to support is that urban areas *and* socially vulnerable populations are by far the most likely to fall victim to Covid-19 and experience mental health decline. This is interesting because social vulnerability was not necessarily at its highest in the urban coastal areas, though it was certainly higher there than in rural areas. Regardless of the overlap between urbanism and social vulnerability, the relationship between these two groups and health detriments appears to be quite strong as I look at these maps side by side. Social media does not seem to have too high of a relationship with any of the other variables, and if it does, then social media activity's relationship to urbanism most likely eclipses any other relationships that may be able to appear. Interestingly, though, mentions of Covid-19 slowly increased from April to August; this is worth noting because, rather than becoming weary of discussing the pandemic, it seems that interest and concern steadily mounted as time continued.

State actions are difficult to quantify fairly, as I would have to weigh each variable's importance in the production of "stress". Furthermore, the quantification may be able to be improved by incorporating more of the variables. It would also be beneficial to perhaps look at a different quantification of social media activity. Another very important expansion would be to visualize level of urbanism across the country.


# Bibliography

1. Centers for Disease Control and Prevention/ Agency for Toxic Substances and Disease Registry/ Geospatial Research, Analysis, and Services Program. CDC Social Vulnerability Index 2018 Database US. https://www.atsdr.cdc.gov/placeandhealth/svi/data_documentation_download.html.
2. Centers for Disease Control and Prevention/ National Center for Health Statistics. NCHS Household Pulse Survey, Anxiety and Depression. 2020. https://www.cdc.gov/nchs/covid19/pulse/mental-health.htm
3. National Governors Association. COVID-19 State and Territory Actions Tracker. 2020. https://coronavirus-resources.esri.com/datasets/NGA2::covid19-state-and-territory-actions-download?showData=true
4. Preda, G. (2020, August). COVID19 Tweets, Version 24. Retrieved November 17, 2020 from https://www.kaggle.com/gpreda/covid19-tweets.
5. Simplemaps. United States Cities Database. 2020. https://simplemaps.com/data/us-cities
6. Spatial.ai & Datastory. COVID-19 Social Media Counts & Sentiment. 2020. https://coronavirus-resources.esri.com/datasets/feb6280d42de4e91b47cf37344a91eae_0?orderBy=current_fl&showData=true
7. *The New York Times*. Coronavirus (Covid-19) Data in the United States. 2020. https://github.com/nytimes/covid-19-data


