
# Dependencies ------------------------------------------------------------


library(tidyverse)
library(DBI)


dat <- read_csv("Data.csv")

entity <- dat %>% select(Entity, Continent, Latitude, Longitude) %>%
  group_by(Entity, Continent) %>%
  summarise(Latitude = mean(Latitude), Longitude = mean(Longitude)) %>%
  ungroup

temperature <- dat %>% select(Entity, `Average temperature per year`) %>%
  group_by(Entity) %>%
  summarise(Temperature = mean(`Average temperature per year`)) %>% 
  ungroup

hospital <- dat %>% 
  select(Entity, `Hospital beds per 1000 people`, `Medical doctors per 1000 people`) %>%
  group_by(Entity) %>%
  summarise(Hospital_bed = mean(`Hospital beds per 1000 people`),
            Medical_doctors = mean(`Medical doctors per 1000 people`))

demographics <- dat[, c("Entity", "Population", "Median age", 
                        "Population aged 65 and over (%)")] %>%
  group_by(Entity) %>%
  summarise(Population = mean(Population), 
            Median_age = mean(`Median age`),
            Perc_elderly = mean(`Population aged 65 and over (%)`)) %>%
  ungroup

economy <- dat %>% select(Entity, `GDP/Capita`) %>%
  group_by(Entity) %>%
  summarise(GDP = mean(`GDP/Capita`)) %>%
  ungroup

covid <- dat %>% 
  select(Entity, Date, `Daily tests`, Cases, Deaths) %>%
  rename(Daily_tests = `Daily tests`)


merge_back <- covid %>% 
  left_join(entity) %>% 
  left_join(demographics) %>% 
  left_join(economy) %>% 
  left_join(temperature) %>% 
  left_join(hospital)

write_csv(entity, "location.csv")
write_csv(covid, "covid.csv")
write_csv(demographics, "demographics.csv")
write_csv(economy, "economy.csv")
write_csv(temperature, "temperature.csv")
write_csv(hospital, "hospital.csv")


# RSQlite -----------------------------------------------------------------

mydb <- dbConnect(RSQLite::SQLite(), "covid19_100ctry.db")
dbWriteTable(mydb, "covid", covid)
dbWriteTable(mydb, "location", entity)
dbWriteTable(mydb, "demographics", demographics)
dbWriteTable(mydb, "economy", economy)
dbWriteTable(mydb, "temperature", temperature)
dbWriteTable(mydb, "hospital", hospital)
dbDisconnect(mydb)

