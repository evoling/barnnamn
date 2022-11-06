library(tidyverse)
library(devtools)
# This file creates the rData binary in the data directory

# From the 2022 publication of data, names from 2004 onwards are available when
# n >= 2; in this release we filter for n >= 10 for backwards compatibility
barnnamn_2021 = read_tsv("namestats-2022.tsv") %>%
  mutate(year=2021) %>%
  mutate(sex=if_else(sex=="flickor", "F", "M")) %>%
  select(year, sex, name, n) %>%
  filter(n >= 10)

# Get births by year and sex to calcuation proportion
totals <- barnnamn_2021 %>% group_by(year, sex) %>% summarise(total=sum(n))

barnnamn_2021 <- barnnamn_2021 %>%
  left_join(totals) %>%
  mutate(prop=n/total) %>%
  select(year, sex, name, n, prop)

barnnamn = barnnamn %>% rbind(barnnamn_2021)

use_data(barnnamn, overwrite=TRUE)
