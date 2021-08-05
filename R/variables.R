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
entry_fee <- 215
entry_total <- entry_fee * league_size
entry_fee_due_date <- paste0("Sept 1,", current_season)

payouts <- tribble(
  ~payout,             ~amount,
  "1st Place",                               1000,
  "2nd Place",                               500,
  "3rd Place",                               200,
  "1v2 Showdown",                            50,
  "Weekly High Score (regular season)",      50,
  "Top Week on the Season (including playoffs and week 18)", 50,
  "Most Points For (regular season)",        60,
  "Most Points Against (regular season)",    20,
  "Week 18 High Score",                      100
) %>%
  mutate(
    total_amount = if_else(payout == "Weekly High Score (regular season)", amount * 12, amount)
  )


# roster ------------------------------------------------------------------
roster_spots <- 15
ir_spots <- 2
lineup <- readr::read_csv("data-raw/valid-lineup.csv")
faab_budget <- 200


# draft info --------------------------------------------------------------
draft_day <- "TBD when in Costa Rica"
draft_location <- "5th floor of a Mansion in the Rain Forest"
draft_host <- 'The Beautiful Country of Costa Rica'
auction_budget <- 200
min_bid <- 1


# members and roles -------------------------------------------------------
members <- readr::read_csv("data-raw/member-info.csv")
current_members <- filter(members, current_member == TRUE)

current_commish <- "Noah Newport"
lord_of_the_council <- "Jesse Piburn"
senior_council_1 <- "Brack Brown"
senior_council_2 <- "Miles Collins"
senior_council_alt <- "Jordan Rudolph"




