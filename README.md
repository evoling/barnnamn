# barnnamn

Swedish babynames

This is a Swedish equivalent to the babynames package. Anything you do with babynames you should be able to do with barnnamn instead. The two datasets have the same columns in the same order, so they use also be easy to combine:

```{R}
library(barnnamn)
library(babynames)

# annotate each dataset with country of origin
barnnamn$country = "Sweden"
babynames$country = "USA"

# join them and plot something for the years for which both datasets have data
babynames %>% 
  bind_rows(barnnamn) %>% 
  filter(year >= 1998, year <= 2015) %>%
  filter(name=="Anna", sex=="F") %>%
  ggplot(aes(x=year, y=prop, linetype=country)) + geom_line()
```

The Swedish names data comes from the Statistiska centralbyrån (Central Statistical Bureau), which provides data from 1998 to 2018.
