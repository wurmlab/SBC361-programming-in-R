makeFakeORF <- function(number.of.codons) {

  # Stop if input argument is not a number
  if () {
    stop()
  }

  # Stop if input argument is not bigger than 2
  # (we want at least the start codon, one amino acid and a stop codon)
  if () {
    stop()
  }


  # read in codon frequency table for H. sapiens
  # retrieved and modified from http://www.kazusa.or.jp/codon/
  codon.freq.table <- read.csv('http://wurmlab.github.io/2014-MSc-SBSm032-stats_bioinformatics/coursework/data/codon_frequency_table.csv', h=T)

  ############################
  ## Middle of the ORF

  # We are going to use the function sample() to create vector of codons for the 'middle' portion of the ORF
  # This portions does not include the start or stop codon

  # The length of this portion is the input length - 2:
  length.of.orf.middle <-

  # Each codon is present in a given proportion (as given in codon.freq.table)
  # however, we want to remove the stop codons from the table, since we do not want them in the middle of the sequence:
  non.stop.codon.table <- #subset of codon.freq.table without the stop codons, c('UAA', 'UAG', 'UGA')

  # recode the frequency of the codons after removal of the stop codons (this may take a few steps):
   # (code goes here if needed)
   # (code goes here if needed)
  non.stop.codon.table$Frequency <-

  # sample
  orf.middle <- sample(x=non.stop.codon.table$Codon, size=length.of.orf.middle, prob=non.stop.codon.table$Frequency)
  ############################
  ## Stop codon

  # Sample one stop codon according to the frequency of each stop codon in the first table
  # stop codons are c('UAA', 'UAG', 'UGA')

  # This bit you have to do youself!
  # It is similar to the code above, except that you need to sample 1 codon only.

  ############################
  ## Start codon
  start.codon <- 'AUG'

  ############################
  ## Joining the start and stop codons to the rest of ORF

  # Add the start codon to the beggining of the orf.middle vector:
   # (code goes here)

  # Add the stop codon to the end of the orf.middle vector:
   # (code goes here)

  ############################
  ## U -> T

  # We need to output DNA and not RNA, so we need to change U to T
  # HINT: you may want to collapse the vector into a string and then use a regular expression!

  ############################
  ## Output

  # return a *string*! Its length will be 3 times the input length
  return()

}
