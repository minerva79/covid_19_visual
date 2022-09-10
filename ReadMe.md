COVID-19 Visualisation
================
Adam Quek
2022-09-10

## Task

To create 3 informative visualizations about Covid-19 using Python in a Jupyter notebook, starting with the data set at https://www.kaggle.comdatasetssambelkacemcovid19-algeria-and-world-datasetcode.

## Data Set

Variables from downloaded data has been changed to code friendly format. The data are further split into 6 normalised tables and hosted within a SQLite3 database (using "RSQLite" packages).

The normalised tables include
-   "location" (Primary key: "Entity", contains the geographical information for the 104 countries)
-   "demographics" (Primary key: "Entity", contains demographic information for the 104 countries)
-   "economy" (Primary key: "Entity", contains another feature on GDP Per Capita)
-   "hospital" (Primary key: "Entity", contains features on Hospital Bed per 1000 People and Medical Doctors per 1000 People)
-   "temperature" (Primary key: "Entity", contains another feature on Average Temperature per year)
-   "covid" (Foreign key: "Entity", contains Number of Daily tests, cumulative number of COVID-19 Cases and Deaths)

## Visualisation

All visualisation are carried out in the single JuPyteR notebook in the repository. The visualisation consists of:

-   Choropleth on Total Number of COVID-19
    -- Graphical representation of distribution of COVID-19 cases across the 104 countries.

-   Relationship of COVID-19 Deaths with Percentage of Population Aged 65 and Over
    -- Graphical representation shows that the proportion of COVID-19 death (per capita) is correlated with the proportion of elderly population (per capita).
    -- An Ordinary Least Squares (OLS) regression trendline is added to aid identifying the relationship.

-   Relationship of COVID-19 Cases with GDP Per Capita
    -- Graphical representation shows that the proportion of COVID-19 cases (per capita) is correlated with the GDP of the nation.
    -- An Ordinary Least Squares (OLS) regression trendline is added to aid identifying the relationship.
