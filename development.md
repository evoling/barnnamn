Notes on development process

- devtools::load_all() from the barnnamn directory to simulate loading the library

- devtools::document() to generate the documentation (.rd) files from roxygen comments (the "' formatted lines at the beginning of .R files)

- Normally we don't put generated files into git, but in this case we want it to be possible to install the library using devtools::install_github(), so .rd files etc *should* be added to git.
