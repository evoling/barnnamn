library(ggplot2)
library(dplyr)
library(devtools)
library(readxl)
library(testthat)
library(tidyr)
# This file creates the rData binary in the data directory

# Excel files from the Swedish Central Statistical Bureau, SCB
# http://www.scb.se/hitta-statistik/statistik-efter-amne/befolkning/amnesovergripande-statistik/namnstatistik/


# Section name: "Nyfödda – Tilltalsnamn, alfabetisk översikt"


girls <- read_excel("data-raw/be0001namntab11_2019.xlsx",
             sheet = "Flickor",
             skip = 4)  %>% mutate(sex = "F")
boys <- read_excel("data-raw/be0001namntab12_2019.xlsx",
             sheet = "Pojkar",
             skip = 4)  %>% mutate(sex = "M")
expect_equal(names(girls), names(boys))
barnnamn <- bind_rows(girls, boys) %>%
  pivot_longer(as.character(1998:2019), names_to="year", values_to="count") %>%
  mutate(year=as.integer(year), count=suppressWarnings(as.integer(count))) %>%
  filter(!is.na(count)) %>%
  rename(name=Namn, n=count) %>%
  arrange(year, name)

# To do this correctly we actually need the total number of births/sex/year
# totals <- barnnamn %>% group_by(year, sex) %>% summarise(total=sum(n))

# The following file was downloaded from the following:
# page name: Befolkningsutvecklingen i riket efter kön. År 1749 - 2019
# link: http://www.statistikdatabasen.scb.se/pxweb/sv/ssd/START__BE__BE0101__BE0101G/BefUtvKon1749/
# query options:
#     region: riket
#     moderns ålder: (no selection)
#     kön: män, kvinnor
#     år: 1998 to 2019
totals <- read_excel("data-raw/BE0101E2_20201213-170726.xlsx",
                     col_types = c("skip", "skip", "skip",
                                   "text", "numeric", "numeric",
                                   "numeric", "numeric", "numeric",
                                   "numeric", "numeric", "numeric",
                                   "numeric", "numeric", "numeric",
                                   "numeric", "numeric", "numeric",
                                   "numeric", "numeric", "numeric",
                                   "numeric", "numeric", "numeric",
                                   "numeric", "numeric"), skip = 2,
                     n_max = 2) %>%
  pivot_longer(as.character(1998:2019), names_to="year", values_to="total") %>%
  rename(sex=`...1`) %>%
  mutate(year=as.integer(year), total=as.integer(total)) %>%
  mutate(sex=if_else(sex=="kvinnor", "F", "M"))

barnnamn <- barnnamn %>%
  left_join(totals) %>%
  mutate(prop=n/total) %>%
  select(year, sex, name, n, prop)

use_data(barnnamn, overwrite=TRUE)
