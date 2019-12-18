
# this script is can before each chapter
# per bookdowns suggestion, clear everything before running
rm(list = ls(all = TRUE))

library(dplyr)

original_season <- 2012
current_date <- Sys.Date()
current_season <- lubridate::year(current_date)

# Membership and Roles ---------------------------------------------------------
members <- readr::read_csv("data-raw/member-info.csv")
members <- members %>%
  mutate(
    last_season = if_else(is.na(last_season), current_season, last_season)
  ) %>%
  group_by(name) %>%
  mutate(
    seasons = length(last_season:first_season) - seasons_missed
  ) %>%
  ungroup()

current_members <- members %>%
  filter(
    last_season == current_season
  )


current_commish <- "Noah Newport"
lord_of_the_council <- "Jesse Piburn"
senior_council_1 <- "Brack Brown"
senior_council_2 <- "Miles Collins"
senior_council_alt <- "Jordan Rudolph"


# Entry Fees  -----------------------------------------------------------------

entry_fee <- 140
entry_total <- 140 * nrow(current_members)
entry_fee_due_date <- paste0("August 23,", current_season)

payouts <- readr::read_csv("data-raw/payouts.csv") %>%
  mutate(
    payout_total = amount * payout_freq,
    note = if_else(is.na(note), "", note)
  )


# Rosters ----------------------------------------------------------------------
roster_spots <- 15
ir_spots <- 1
lineup <- readr::read_csv("data-raw/valid-lineup.csv") 


# Draft Info -------------------------------------------------------------------
draft_day <- "Saturday, August 1st"
draft_location <- "at a house on Chickamauga Lake in Decatur, TN"
draft_host <- 'Jordan "I Do" Rudolph'
auction_budget <- 200
min_bid <- 1


