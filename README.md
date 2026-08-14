# English Premier League Attacking Event Analysis

## Project Overview

This capstone project analyzes event-level football data from the English Premier League using R.

The project examines attacking involvement across event types, passing sub-events, player positions, teams, and individual players. It also uses statistical analysis to investigate whether player position is associated with attacking event type.

For this project, attacking involvement is operationally defined using selected passes, shots, offsides, corners, free-kick crosses, free-kick shots, and penalties.

## Research Questions

1. What types of events make up the attacking-event dataset, and how frequently does each occur?
2. Which passing sub-events are most common?
3. How is attacking-event involvement distributed across player positions?
4. Which teams record the highest levels of attacking-event involvement?
5. Which players record the highest levels of attacking-event involvement?
6. Is there a statistically significant association between player position and attacking event type?
7. If an association exists, how strong is it, and which position-event combinations contribute most strongly to the relationship?

## Data Source

The project uses the Wyscout Soccer Match Event Dataset.

The data include event-level information such as passes, shots, free kicks, offsides, players, teams, match periods, and event times.

### Source Publication

Pappalardo, L., Cintia, P., Rossi, A., Massucco, E., Ferragina, P., Pedreschi, D., & Giannotti, F. (2019).  
*A public data set of spatio-temporal match events in soccer competitions.*  
Scientific Data, 6, 236.

## Software

The analysis was conducted using R.

### R Packages

- tidyverse
- jsonlite
- skimr
- stringi
- rcompanion
- plotly

## Project Structure

Michael_Boateng_EPL_Capstone/

- 01_Load_Packages.R
- 02_Import_Data.R
- 03_Clean_Data.R
- 04_EDA.R
- 05_Visualization_Statistics.R
- data/
  - raw/
    - events_England.json
    - players.json
    - teams.json
- outputs/
  - figures/
  - tables/
- report/
  - Michael_Boateng_Capstone_Report.pdf

## Analytical Workflow

The project follows the following workflow:

1. Data import
2. Initial data inspection
3. Data-quality assessment
4. Player-name cleaning
5. Integration of event, player, and team data
6. Construction of the attacking-event dataset
7. Exploratory data analysis
8. Data visualization
9. Chi-Square Test of Independence
10. Cramer's V
11. Standardized residual analysis
12. Interpretation and reporting

## Reproducing the Analysis

Run the R scripts in the following order:

1. `01_Load_Packages.R`
2. `02_Import_Data.R`
3. `03_Clean_Data.R`
4. `04_EDA.R`
5. `05_Visualization_Statistics.R`

The raw JSON files is stored inside:

`data/raw/`

Generated figures are saved inside:

`outputs/figures/`

Generated tables are saved inside:

`outputs/tables/`

## Key Findings

The final attacking-event dataset contained 342,225 observations.

- Passes accounted for 95.31% of the selected attacking events.
- Midfielders accounted for 43.44% of attacking-event involvement.
- Defenders accounted for 41.18%.
- Manchester City recorded the highest team-level attacking-event involvement.
- G. Xhaka recorded the highest individual attacking-event total.
- Player position and attacking event type were statistically associated.
- The Chi-Square Test produced X-squared = 14,592 with 9 degrees of freedom and p < 0.001.
- Cramer's V was 0.1192, indicating a relatively modest association.

Because passing dominates the constructed measure, attacking-event totals are interpreted as measures of attacking and build-up involvement rather than direct measures of attacking effectiveness.

## Author

Michael Boateng

Capstone Project
