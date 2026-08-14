#### SECTION 6.1: ATTACKING EVENT DISTRIBUTION ####

graph_events_summary<- ggplot(event_summary,aes(x = reorder(eventName, n), 
                                                y = n))+
                                                 
  geom_col(position = 'dodge', fill = 'steelblue', width = 0.7)+
  labs(
    title = 'Distribution of Attacking Event Types in EPL',
    subtitle = 'English Premier League (EPL) Event Data',
    caption = 'Source: Wyscout English Premier League Event Data',
    x = 'Attacking Event Type',
    y = 'Number of Events (Log Scale)'
  )+
  scale_y_log10()+
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    legend.position = 'none',
    plot.title = element_text(face = 'bold', size = 16),
    plot.subtitle = element_text(size = 12)
  )

graph_events_summary
ggplotly(graph_events_summary)


#### SECTION 6.2: PASSING SUB-EVENTS ####

graph_pass_summary<- ggplot(pass_summary, aes(x = reorder(subEventName, n), 
                                              y = n))+
  geom_col(position = 'dodge', fill = 'forestgreen', width = 0.7)+
  labs(
    title = 'Distribution of Passing Sub-Events',
    subtitle = 'English Premier League Event Data',
    caption = 'Source: Wycout English Premier League Event Data ',
    x = 'Passing Sub-Event',
    y = 'Number of Events'
      )+
  theme(panel.grid = element_blank())+
  theme(legend.position = 'none')+
  scale_y_continuous(labels = scales::comma)

graph_pass_summary
ggplotly((graph_pass_summary))



#### SECTION 6.3: PLAYER POSITION ####

graph_position_summary<- ggplot(position_summary, aes (x = reorder(role_name,n),
                                                       y = n))+
  geom_col(position = 'dodge', fill = 'dodgerblue3', width = 0.7 )+
  labs(
    title = 'Attacking Events by Player Position',
    subtitle = 'English Premier League Event Data',
    x = 'Player Position',
    y = 'Number of Attacking Events',
    caption = 'Source: Wyscout English Premier League Event Data')+
  theme_minimal()+
  theme(panel.grid = element_blank(),
        (legend.position = 'none')+
  scale_y_continuous(labels = scales::comma)
  )
graph_position_summary
ggplotly(graph_position_summary)


#### SECTION 6.4: TEAM ANALYSIS ####

graph_team_summary<- ggplot(team_summary,
       aes(x = reorder(team_name, Attacking_Events),
           y = Attacking_Events)) +
  geom_col(fill = 'steelblue', width = 0.7) +
  coord_flip() +
  geom_text(
    aes(label = scales::comma(Attacking_Events)),
    hjust = -0.1,
    size = 3.5
  ) +
  labs(
    title = 'Attacking Events by Team',
    subtitle = 'English Premier League Event Data',
    x = 'Team',
    y = 'Number of Attacking Events',
    caption = 'Source: Wyscout English Premier League Event Data'
  ) +
  theme_minimal(base_size = 13) +
  theme(
    legend.position = 'none',
    plot.title = element_text(face = 'bold', size = 16),
    axis.title = element_text(face = 'bold')
  )+
  scale_y_continuous(
    labels = scales::comma,
    expand = expansion(mult = c(0, 0.12))
  ) 
graph_team_summary


#### SECTION 6.5: TOP 20 PLAYERS ####

Graph_top_player_details<- ggplot(
  top_players_details,
  aes(
    x = reorder(shortName, Attacking_Events),
    y = Attacking_Events,
    fill = role_name
  )
) +
  geom_col(width = 0.7) +
  coord_flip() +
  geom_text(
    aes(label = scales::comma(Attacking_Events)),
    hjust = -0.1,
    size = 3.5
  ) +
  scale_y_continuous(
    labels = scales::comma,
    expand = expansion(mult = c(0, 0.15))
  ) +
  labs(
    title = 'Top 20 Players by Attacking Events',
    subtitle = 'Player involvement by position in the English Premier League',
    x = 'Player',
    y = 'Number of Attacking Events',
    fill = 'Position',
    caption = 'Source: Wyscout English Premier League Event Data'
  ) +
  theme_minimal(base_size = 13) +
  theme(
    plot.title = element_text(face = 'bold'),
    axis.text.y = element_text(size = 10)
  )
Graph_top_player_details


#### SECTION 7.1: CHI-SQUARE TEST ####
#Research Questions: Is there a statistically significant association 
#between player position and attacking event type?

##Create the Contingency Table
position_event_table <- table(
  attacking_events$role_name,
  attacking_events$eventName
)

position_event_table


##Run Chi-Square Test
chi_result <- chisq.test(position_event_table)
chi_result

#### SECTION 7.2: CRAMER'S V ####
# Research Question: 
# How Strong is the Association between Position and 

cramerV(position_event_table)


#### SECTION 7.3: STANDARDIZED RESIDUALS ####
# Research Question:
# how strong is it, and which player-position and attacking-event combinations 
# contribute most strongly to the relationship?

as.data.frame(chi_result$stdres)
round(chi_result$stdres, 2)


