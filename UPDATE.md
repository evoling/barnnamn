# Annual updates

Each year the Swedish Statistiska Centralburån releases new name data at the end of January.

Steps for updating the barnnamn library for a new year.

## 1. Create a new branch in git

For example, 
```
  git checkout -b dev-2023
```

## 2. Download excel files with name data

Use the year that the branch was made (even though new data is from the year 
previous)

## 3. Download demographic data

The files should be available from the [SCB 
website](http://www.scb.se/hitta-statistik/statistik-efter-amne/befolkning/amnesovergripande-statistik/namnstatistik/). 

In 2019–2021 there were two files, one for male names, one for female names. 
The names for the 2019 data were `be0001namntab11_2019.xlsx` (girls' names) and 
`be0001namntab12_2019.xlsx` (boys' names). These were a little inconsistent 
from year to year (underscore vs. hyphen, etc.). In 2022 the format changed and 
the boys' and girls' names could be downloaded in a single search. With a bit 
of manual fiddling I got this data into tab-delimited utf-8 format, with 
headers name, sex, count. File is saved as `data-raw/namestats-2022.tsv`.

##3. Update data-raw/barnnamn.R

- Pay attention to changes in filename and format. The `use_data` function 
  recreates `data/barnnamn.rda`
