library(ggplot2)
library(dplyr)
library(devtools)
library(readxl)
library(testthat)
# This file creates the rData binary in the data directory

# Excel files from the Swedish Central Statistics Agency, SCB
# http://www.scb.se/hitta-statistik/statistik-efter-amne/befolkning/amnesovergripande-statistik/namnstatistik/

girls <- read_excel("data-raw/be0001namntab11-2018.xlsx",
             sheet = "Flickor",
             skip = 4)  %>% mutate(sex = "F")
boys <- read_excel("data-raw/be0001namntab12-2018.xlsx",
             sheet = "Pojkar",
             skip = 4)  %>% mutate(sex = "M")
expect_equal(names(girls), names(boys))
barnnamn <- bind_rows(girls, boys) %>%
  gather(year, count, as.character(1998:2018)) %>%
  mutate(year=as.integer(year), count=suppressWarnings(as.integer(count))) %>%
  filter(!is.na(count)) %>%
  rename(name=Namn, n=count) %>%
  arrange(year, name)

# To do this correctly we actually need the total number of births/sex/year
# totals <- barnnamn %>% group_by(year, sex) %>% summarise(total=sum(n))
totals <- read_excel("data-raw/BE0101E2.xlsx",
                     col_types = c("skip", "skip", "skip",
                                   "skip", "skip", "text", "numeric",
                                   "numeric", "numeric", "numeric",
                                   "numeric", "numeric", "numeric",
                                   "numeric", "numeric", "numeric",
                                   "numeric", "numeric", "numeric",
                                   "numeric", "numeric", "numeric",
                                   "numeric", "numeric", "numeric",
                                   "numeric", "numeric"), skip = 2,
                     n_max = 2) %>%
  gather(year, total, as.character(1998:2018)) %>%
  rename(sex=X__1) %>%
  mutate(year=as.integer(year), total=as.integer(total)) %>%
  mutate(sex=if_else(sex=="kvinnor", "F", "M"))

barnnamn <- barnnamn %>%
  left_join(totals) %>%
  mutate(prop=n/total) %>%
  select(year, sex, name, n, prop)

use_data(barnnamn, overwrite=TRUE)
