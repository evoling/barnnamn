library(tidyverse)
library(devtools)
library(readxl)
# This file creates the rData binary in the data directory

# Excel files from the Swedish Central Statistical Bureau, SCB
# http://www.scb.se/hitta-statistik/statistik-efter-amne/befolkning/amnesovergripande-statistik/namnstatistik/


# Section name: "Nyfödda – Tilltalsnamn, alfabetisk översikt"


girls <- read_excel("data-raw/be0001namntab11-2020.xlsx",
             sheet = "Flickor - Girls",
             skip = 8)  %>% mutate(sex = "F")
boys <- read_excel("data-raw/be0001namntab12-2020.xlsx",
             sheet = "Pojkar - Boys",
             skip = 8)  %>% mutate(sex = "M")
expect_equal(names(girls), names(boys))
barnnamn <- bind_rows(girls, boys) %>%
  pivot_longer(as.character(1998:2020), names_to="year", values_to="count") %>%
  mutate(year=as.integer(year), count=suppressWarnings(as.integer(count))) %>%
  filter(!is.na(count)) %>%
  rename(name=`Namn / Name`, n=count) %>%
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
#     år: 1998 to 2020
totals <-  read_excel("data-raw/0000001H_20210225-152425.xlsx",
                                        skip = 1, n_max = 3) %>%
  pivot_longer(as.character(1998:2020), names_to="year", values_to="total") %>%
  rename(sex=`...1`) %>%
  mutate(year=as.integer(year), total=as.integer(total)) %>%
  mutate(sex=if_else(sex=="kvinnor", "F", "M"))

barnnamn <- barnnamn %>%
  left_join(totals) %>%
  mutate(prop=n/total) %>%
  select(year, sex, name, n, prop)

use_data(barnnamn, overwrite=TRUE)
