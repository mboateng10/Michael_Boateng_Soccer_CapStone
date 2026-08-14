#### SECTION 6.1: ATTACKING EVENT DISTRIBUTION ####
# Research Question:
# What are the most common attacking-event types in the EPL?

event_summary <- attacking_events %>%
  count(eventName, sort = T)%>%
  mutate(percentage = round(100*n/sum(n), 2))

event_summary


#### SECTION 6.2: PASSING SUB-EVENT DISTRIBUTION ####
# Research Question:
# Which passing sub-events are most frequently used?

pass_summary <- passing_events %>%
  count(subEventName, sort = T) %>%
  mutate(
    Percentage = round(100 * n / sum(n), 2)
      )

pass_summary


#### SECTION 6.3: PLAYER POSITION ####
# Research Question:
# How is attacking involvement distributed across player positions?

position_summary <- attacking_events %>%
  filter(!is.na(role_name)) %>%
  count(role_name, sort = T) %>%
  mutate(
    Percentage = round(100 * n / sum(n), 2))

position_summary


#### SECTION 6.4: TEAM ANALYSIS ####
# Research Question:
# Which EPL teams recorded the highest attacking-event involvement?

team_summary <- attacking_events %>%
  group_by(team_name) %>%
  summarise(
    Attacking_Events = n(), .groups = 'drop'
  ) %>%
  arrange(desc(Attacking_Events)) %>%
  mutate(
    Percentage = round(
      100 * Attacking_Events / sum(Attacking_Events),2)
  )

team_summary



#### SECTION 6.5: PLAYER ANALYSIS ####
# Research Question:
# Which players recorded the highest attacking involvement, and what teams and 
#positions do they represent?

top_players_details <- attacking_events %>%
  filter(!is.na(shortName)) %>%
  group_by(
    shortName,
    team_name,
    role_name
  ) %>%
  summarise(
    Attacking_Events = n(), .groups = 'drop'
  ) %>%
  arrange(desc(Attacking_Events)) %>%
  slice_head(n = 20)

top_players_details


# Create tables folder if it does not exist
dir.create('tables', showWarnings = F)

# Export summary tables
write.csv(
  event_summary,
  'tables/event_summary.csv',
  row.names = F
)

write.csv(
  pass_summary,
  'tables/pass_summary.csv',
  row.names = F
)

write.csv(
  position_summary,
  'tables/position_summary.csv',
  row.names = F
)

write.csv(
  team_summary,
  'tables/team_summary.csv',
  row.names = F
)

write.csv(
  top_players_details,
  'tables/top_20_players.csv',
  row.names = F
)



