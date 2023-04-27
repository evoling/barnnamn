library(tidyverse)
library(devtools)
library(barnnamn)
# This file creates the rData binary in the data directory

# From the 2022 publication of data, names from 2004 onwards are available when
# n >= 2; in this release we filter for n >= 10 for backwards compatibility
barnnamn_2022 <- read_tsv("namestats-2023.tsv", col_types="cci", na="..") %>%
  mutate(name=tilltalsnamn, sex=kön, n=`2022`) %>%
  mutate(year=2022) %>%
  mutate(sex=if_else(sex=="flickor", "F", "M")) %>%
  select(year, sex, name, n) %>%
  filter(n >= 10)

# Get births by year and sex to calcuation proportion
totals <- barnnamn_2022 %>% group_by(year, sex) %>% summarise(total=sum(n))

barnnamn_2022 <- barnnamn_2022 %>%
  left_join(totals) %>%
  mutate(prop=n/total) %>%
  select(year, sex, name, n, prop)

barnnamn <- barnnamn %>% bind_rows(barnnamn_2022)

use_data(barnnamn, overwrite=TRUE)
