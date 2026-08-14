###Soccer Capstone Project###
###Script 02: Data Cleaning###
###Author: Michael Boateng###


### 1. INITIAL DATA QUAILITY CHECKS ###

# Missing values in raw event data
sum(is.na(events))
colSums(is.na(events))

# Duplicate rows
sum(duplicated(events))


# Inspect nested list columns
str(events$tags[1:5])
str(events$positions[1:5])

### 2. CHECK CATEGORICAL CONSISTENCY ###
events%>%
  count(eventName, sort = T)

events%>%
  count(matchPeriod, sort=T)

events%>%
  count(subEventName, sort=T)


### 3. CHECK EVENT TIME ###
summary(events$eventSec)

##Investigating maximum eventSec (3476.8 seconds)
events%>%
  filter(eventSec==max(eventSec))

#Result:Even though the value exceeds the standard 45 minutes soccer time
#       of half, it is likely to caused by stoppage time. Since we do not
#       have enough evidence indication error in observation, we retain it 
#       for analysis.


### 4. CLEAN PLAYER NAMES ###
players <- players %>%
  mutate(
    across(
      c(shortName, firstName, middleName, lastName),
      ~ .x %>%
        stringi::stri_unescape_unicode() %>%
        stringi::stri_unescape_unicode()
    ),
    across(
      c(shortName, firstName, middleName, lastName),
      ~ stringr::str_remove_all(.x, '\u00AD')
    )
  )

players %>%
  filter(
    str_detect(
      shortName,
      'Mati|Kant|Doucour|bregas'
    )
  ) %>%
  select(shortName)


# verify that no escaped Unicode codes remain
players %>%
  filter(str_detect(shortName, fixed('\\u'))) %>%
  distinct(shortName)

### 5. JOIN EVENTS WITH PLAYER DATA###

events_players<- events%>%
  left_join(
    players, by=c('playerId'='wyId'))

# Extract player position from nested role column

events_players <- events_players %>%
  mutate(
    role_name = role$name
  )

  
#### 6. INVESTIGATE PLAYER INFORMATION ####

sum(is.na(events_players$shortName))

events_players %>%
  filter(is.na(shortName)) %>%
  count(eventName, sort = TRUE)

events_players %>%
  count(role_name, sort = TRUE)

### 7. INSPECT CANDIDATE ATTACKING EVENTS

events_players%>%
  filter(eventName %in% c('Pass', 'Shot', 'Free Kick', 'Offside'))%>%
  count(eventName, subEventName, sort = T)
 
### 8. CREATE FINAL ATTACKING_EVENT DATASET ###
attacking_events<- events_players%>%
  filter(eventName == 'Pass' & 
           subEventName %in% c('Simple pass', 'Smart pass', 'Cross',
                               'High pass', 'Head pass', 'Launch') |
  (eventName == 'Shot') | (eventName == 'Offside') | (eventName == 'Free Kick'
                                                      & subEventName %in% 
                                                        c('Corner',
                                                          'Free kick cross',
                                                          'Free kick shot',
                                                          'Penalty')))


### 9. ADD TEAM NAMES ###

attacking_events <- attacking_events %>%
  left_join(
    teams %>%
      select(
        wyId, team_name = name),
    by = c('teamId' = 'wyId')
  )

names(attacking_events)


### 10. CREATE SPECIALIZED DATASETS ###

passing_events<-attacking_events%>%
  filter(eventName == 'Pass')


set_piece_events<-attacking_events%>%
  filter(eventName == 'Free Kick')


### 11. FINAL DATA QUALITY CHECK ###

# Dimensions
dim(attacking_events)

# Duplicated records
sum(duplicated(attacking_events))

# Missing analytical variables
attacking_events %>%
  summarise(
    missing_eventName = sum(is.na(eventName)),
    missing_subEventName = sum(is.na(subEventName)),
    missing_playerId = sum(is.na(playerId)),
    missing_teamId = sum(is.na(teamId)),
    missing_role_name = sum(is.na(role_name)),
    missing_shortName = sum(is.na(shortName)),
    missing_team_name = sum(is.na(team_name)),
    missing_eventSec = sum(is.na(eventSec))
  )

# Verify final attacking_event categories
attacking_events%>%
  count(eventName,
        subEventName, sort=T)

# Final event distribution
attacking_events %>%
  count(eventName, sort = T)

# Final position distribution
attacking_events %>%
  count(role_name, sort = T)


# Dataset overview
attacking_events %>%
  select(
    eventId,
    eventName,
    subEventName,
    playerId,
    matchId,
    teamId,
    matchPeriod,
    eventSec,
    shortName,
    role_name
  ) %>%
  skim()

