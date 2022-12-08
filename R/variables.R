# this script is called before each chapter
# per bookdowns suggestion, clear everything before running
rm(list = ls(all = TRUE))

library(tidyverse)

# league info -------------------------------------------------------------
original_season <- 2012
league_size <- 12
current_date <- Sys.Date()
current_season <- lubridate::year(current_date)


# fees and payouts --------------------------------------------------------
entry_fee <- 225
entry_total <- entry_fee * league_size
entry_fee_due_date <- "before the start of the draft"

payouts <- tribble(
  ~payout,             ~amount,
  "1st Place",                               1000,
  "2nd Place",                               500,
  "3rd Place",                               200,
  "4th Place",                               80,
  "1v2 Showdown",                            50,
  "Weekly High Score (regular season)",      50,
  "Top Week on the Season (including playoffs and week 18)", 50,
  "Most Points For (regular season)",        50,
  "Most Points Against (regular season)",    20,
  "Week 18 High Score",                      100
) %>%
  mutate(
    total_amount = if_else(payout == "Weekly High Score (regular season)", amount * 13, amount)
  )

if (entry_total != sum(payouts$total_amount)) stop("Entry Fee's don't add up to total spent")


# roster ------------------------------------------------------------------
roster_spots <- 15
ir_spots <- 2
lineup <- readr::read_csv("data-raw/valid-lineup.csv")
faab_budget <- 200


# draft info --------------------------------------------------------------
draft_day <- "Aug 27th"
draft_location <- "Somewhere on a Lake in Georgia"
draft_host <- 'Eric'
auction_budget <- 200
min_bid <- 1


# members and roles -------------------------------------------------------
members <- readr::read_csv("data-raw/member-info.csv")
current_members <- filter(members, current_member == TRUE)

current_commish <- "Jesse Piburn"
lord_of_the_council <- "Brack Brown"
senior_council_1 <- "Miles Collins"
senior_council_2 <- "Jordan Rudolph"
senior_council_alt <- "Britt Elmore"


