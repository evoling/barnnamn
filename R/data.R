#' Swedish Baby names.
#'
#' Baby name data provided by the Swedish Central Statistical Bureau. This includes all names with at
#' least 10 uses in a year.
#'
#' @format A data frame with four variables:
#' \describe{
#'   \item{\code{year}}{Year}
#'   \item{\code{sex}}{Names are listed separately by sex}
#'   \item{\code{name}}{Full given names according to the Swedish national register}
#'   \item{\code{n}}{Number of times name was used (by sex and year); names used less than 10 times have been excluded for privacy reasons}
#'   \item{\code{prop}}{Name as proportion of all names (by sex and year); includes names used than 10 times, so sum of proportions is < 1.0}
#' }
#' @source \url{https://www.scb.se/hitta-statistik/statistik-efter-amne/befolkning/amnesovergripande-statistik/namnstatistik/}
"barnnamn"
