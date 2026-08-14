###Soccer Capstone Project###
###Script 01: Importing and inspecting the raw datasets###
###Author: Michael Boateng###


# Importing raw Wyscout data###
events<- fromJSON('data/raw/events_England.json')
players<- fromJSON('data/raw/players.json')
teams<- fromJSON('data/raw/teams.json')


# Basic inspection
dim(events)
dim(players)
dim(teams)
