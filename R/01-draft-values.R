library(tidyverse)
library(fantasypros)

df <- 
read_csv('data-raw/2020-draft-results.csv') %>%
  group_by(pos) %>%
  mutate(
    draft_as_rank = min_rank(desc(draft_amount)),
    rank_diff = pos_rank - draft_as_rank
  ) %>% transmute(
  draft_pick,
  draft_team,
  player,
  team,
  pos,
  tier,
  ranked_as = paste0(pos, pos_rank),
  drafted_as = paste0(pos, draft_as_rank),
  amount_paid = draft_amount,
  suggested_bid = value,
  draft_value = value - draft_amount,
  percent_paid = round((draft_amount / value) * 100, 2)
)

df %>% mutate(
  pos_group_num = (pos_rank %/% 12) + 1,
  pos_group = paste0(pos, pos_group_num)
) %>%
  group_by(
    pos_group, pos_group_num
  ) %>%
  summarise(
    avg_cost  = mean(value, na.rm = TRUE),
    median_cost  = median(value, na.rm = TRUE)
  ) %>%
  ungroup() %>%
  filter(
    pos_group_num <= 4
  ) %>%
  arrange(desc(avg_cost)) %>% View()


df %>% 
  ungroup() %>%
  mutate(
    flex_spot = if_else(pos %in% c("TE", "RB", "WR"), "FLEX", "NO-FLEX")
  ) %>%
  filter(
    flex_spot == "FLEX"
  ) %>%
  mutate(
    flex_rank = dense_rank(rank),
    pos_group_num = (flex_rank %/% 12) + 1,
    pos_group = paste0(flex_spot, pos_group_num)
  ) %>%
  group_by(
    pos_group, pos_group_num
  ) %>%
  summarise(
    avg_cost  = mean(value, na.rm = TRUE),
    median_cost  = median(value, na.rm = TRUE)
  ) %>%
  ungroup() %>%
  # filter(
  #   pos_group_num <= 7
  # ) %>%
  arrange(desc(avg_cost)) %>% View()



