library(tidyverse)
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

#View(barnnamn)
use_data(barnnamn, overwrite=TRUE)
