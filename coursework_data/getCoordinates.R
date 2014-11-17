getCoordinates <- function() {

  # Download and read the tables
  table1 <- read.csv('https://github.com/wurmlab/2014-MSc-SBSm032-stats_bioinformatics/tree/coursework/coursework_data/alabamaants-myrmicinaepheidole_obscurithorax.csv', h=T)
  table2 <- read.csv('https://github.com/wurmlab/2014-MSc-SBSm032-stats_bioinformatics/tree/coursework/coursework_data/allantwebants-myrmicinaesolenopsis_invicta.csv', h=T)

  # Merge the two tables
  # Subset the table to a new one with only the rows that match the Genus provided by the argument of the function
  # Limit the new one to only the columns DateCollectedStart, LocLatitude and LocLongitude.
  # Remove rows that have NA values
  # return the resulting table
}
