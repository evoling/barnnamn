# Annual updates

Each year the Swedish Statistiska Centralburån releases new name data at the end of January.

Steps for updating the barnnamn library for a new year.

## 1. Create a new branch in git

For example, 
```
  git checkout -b dev-2020
```

## 2. Download excel files with name data

The files should be available from the [SCB website](http://www.scb.se/hitta-statistik/statistik-efter-amne/befolkning/amnesovergripande-statistik/namnstatistik/). There are two files, one for male names, one for female names. The names for the 2019 data were `be0001namntab11_2019.xlsx` (girls' names) and `be0001namntab12_2019.xlsx` (boys' names). These can be a little inconsistent from year to year (underscore vs. hyphen, etc.).

## 3. Download demographic data

This isn't available as a pre-made file, so you have to do it as a database query. The page should be called [Befolkningsutvecklingen i riket efter kön. År 1749 - 2019](http://www.statistikdatabasen.scb.se/pxweb/sv/ssd/START__BE__BE0101__BE0101G/BefUtvKon1749/). Query options are:

region: riket  
moderns ålder: (no selection)  
kön: män, kvinnor  
år: 1998 to most most recent

Save as xslx format to the data-raw directory. The 2021 file is `data-raw/0000001H_20210225-152425.xlsx`

## 4. Update data-raw/barnnamn.R

To build the new data update `data-raw/barnnamn.R`:

- Update the file names for the three xlsx format data files
- Fix the year range in the `pivot_longer` function
- Check that the sheet names and column names are correct (they have been variously "Flickor" and "Flickor - Girls", "Namn" and "Namn/Name", etc.) and that the right number of lines are being skipped from the top of the file.
- Every year I have to change slightly the arguments for the `readxl` function to import the demographic data table. An easy way to do this is use the **File > Import Dataset > From Excel...** option in Rstudio to figure out what works.
- Tidy up by removing old raw data files
