get_coordinates <- function() {

  # Download and read the tables
  data_dir <- 'http://wurmlab.github.io/2014-MSc-SBSm032-stats_bioinformatics/coursework/data/'
  solenopsis_invicta_collections     <- read.csv(file.path(data_dir, 'allantwebants-myrmicinaesolenopsis_invicta.csv'),   h=T)
  pheidole_obscurithorax_collections <- read.csv(file.path(data_dir, 'alabamaants-myrmicinaepheidole_obscurithorax.csv'), h=T)

  # Merge the two tables
  # Subset the table to a new one with only the rows that match the Genus provided by the argument of the function
  # Limit the new one to only the columns DateCollectedStart, LocLatitude and LocLongitude.
  # Remove rows that have NA values
  # return the resulting table
}
