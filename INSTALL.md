# Installation

The current default for `install_github`  [does not install the vignettes]() belonging to the package. If you want the vignettes (and honestly, why wouldn't you?) you should install from github using the command: 

```{r}
devtools::install_github("evoling/barnnamn", build = TRUE, build_opts = c("--no-resave-data", "--no-manual"))
```

To admire your new vignette, run `vignette("barnnamn")`.


