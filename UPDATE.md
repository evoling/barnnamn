# Annual updates

Each year the Swedish Statistiska Centralburån releases new name data at the end of January.

Steps for updating the barnnamn library for a new year.

## 1. Create a new branch in git

For example, 
```
  git checkout -b dev-2023
```

Use the year that the branch was made (even though new data is from the year 
previous)

## 2. Download files with name data

The files should be available from the [SCB 
website](http://www.scb.se/hitta-statistik/statistik-efter-amne/befolkning/amnesovergripande-statistik/namnstatistik/), 
following the links to *Nyfödda*, then *Nyfödda, tilltalsnamn efter 
namngivningsår och kön. År 1998 - 2022*

In 2023 there was a limit to downloads of 150000 records. Just the 2022 data 
was 26270 records, so the workflow adds the current years data to the preexisting data files, rather than downloading everything afresh.
The data was downloaded as `tabbavgränsad utan rubrik` (tab delimited without 
header) and converted to utf-8 using the standard unix tool:

```
iconv -f iso-8859-1 -t utf-8 000004F5_20230427-104949.csv > namestats-2023.tsv
```

## 3. Update data-raw/barnnamn.R

- Pay attention to changes in filename and format. The `use_data` function 
  recreates `data/barnnamn.rda`
