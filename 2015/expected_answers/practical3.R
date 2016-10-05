#Q1
#convert a seq of numbers in fraction of numerator 1 and sum all
#the elements of the vector.
counter <- 0
numbers <- 13:42
for(i in numbers){
  counter   <- counter + 1/i
}
print(counter)

#Q2

sum_fractions <- function(x, y){
counter       <- 0
seq_counter   <- seq(x, y, by = 1)
  for(number in seq_counter){
    counter   <- counter + 1/number
  }
  return(counter)
}

#Palindrome
#Q1
#if palindromic, return TRUE, otherwise FALSE.

Palin_check    <- function(phrase){
  lowercase    <- tolower(phrase)
  no.space     <- gsub(" ", "", lowercase)
  ind.char     <- unlist(strsplit(no.space, split = ""))
  reverse      <- rev(ind.char)
  comp.reverse <- paste(reverse, collapse = "")
  return(no.space == comp.reverse)
}

#Q2
DNA                  <- "ACCTAGGT"
rev_comp             <- function(DNA){
  dna                <- chartr("ATGC", "TACG", DNA)
  dna.comp.split     <- unlist(strsplit(dna, split = ""))
  dna.comp.split.rev <- rev(dna.comp.split)
  dna.comp           <- paste(dna.comp.split.rev, collapse = "")
  return(dna.comp == DNA)
}

#Q3
DNA_string    <- "ATGGATTTTTAG"
reading_frame <- function(DNA.string){
  orf_DNA     <- grepl("ATG([ATCG]{3})+(TGA|TAA|TAG)", x = DNA.string, ignore.case = T)
return(orf_DNA)
}

#Q4a
Orf_seq                <- function(DNA) {
  dna_upper            <- toupper(DNA)
  orf_position         <- grep("ATG([ATGC]{3})+(TGA|TAA|TAG)", ignore.case = T, dna_upper)
  if (length(orf_position) > 0) {
    orf_sequence       <- dna_upper
    #orf.sequence <- paste(orf.vector, collapse = "")
  } else {orf_sequence <- NULL
  }
  return(orf_sequence)
}


#Q5 new practical 3

butterfly_sam_url <- "http://wurmlab.github.io/SBC361-programming-in-R/ButterflySample.csv"
butterfly_sample  <- read.csv(butterfly_sam_url, header = T)

butterfly_ref_url   <- "http://wurmlab.github.io/SBC361-programming-in-R/ButterflyReference.csv"
butterfly_reference <- read.csv(butterfly_ref_url, header = T)

butterfly_sample$Latin.name <- NA
for (i in 1:nrow(butterfly_reference)) {
  pattern                   <- paste("^", common_name, "$", sep="")
  common.name               <- as.character(butterfly_reference$Common.name[i])
  latin.name                <- as.character(butterfly_reference$Latin.name[i])
  common.name.index         <- grep(common.name, butterfly_sample$Species, ignore.case=TRUE)
  latin.name.index          <- grep(latin.name, butterfly_sample$Species, ignore.case=TRUE)
  to.change                 <- c(common.name.index, latin.name.index)
  if (length(to.change) > 0) {
  butterfly_sample$Latin.name[to.change] <- latin.name}
}

#Another way to asnwer the question with a function

common_to_latin <- function(common_name, butterfly_reference) {
  pattern              <- paste("^", common_name, "$", sep="")
  common_name_position <- grep(pattern, butterfly_reference$Common.name, ignore.case=TRUE)
  latin_name           <- butterfly_reference$Latin.name[common_name_position]
  return(as.character(latin_name))
}


butterfly_sample$Latin.name <- NA
for (i in 1:nrow(butterfly_sample)) {
  common_name     <- as.character(butterfly_sample$Species[i])
  latin_sp_names  <- common_to_latin(common_name, butterfly_reference)
  butterfly_sample$Latin.name[i] <- latin_sp_names
}


#Q6 new practical 3
length(unique(butterfly_sample$Latin.name[grep('A', butterfly_sample$Location)]))

length(unique(butterfly_sample$Latin.name[grep('B', butterfly_sample$Location)]))


#Q7 new practical 3
table(gsub(pattern = " [A-z]+", replacement = "", x = butterfly_sample$Latin.name))



# Q8
butterfly_sam_url <- "http://wurmlab.github.io/SBC361-programming-in-R/ButterflySample.csv"
butterfly_sample  <- read.csv(butterfly_sam_url, header = T)

butterfly_ref_url   <- "http://wurmlab.github.io/SBC361-programming-in-R/ButterflyReference.csv"
butterfly_reference <- read.csv(butterfly_ref_url, header = T)


## Strategy:
# First check which names already are in latin (Make vector with TRUE and FALSE)
# Correct the values already in latin
# then correct the values with common species name
# Then make a single column for the data frame

## Vectors of the reference and sample
# REF: common names
ref_latin  <- as.character(butterfly_reference$Latin.name)
# REF: latin names
ref_common <- as.character(butterfly_reference$Common.name)
# Sample: all names
sample_vec <- as.character(butterfly_sample$Species)

# Subset - only te ones that are already in latin
# which_latin <- tolower(sample_vec) %in%  tolower(ref_latin)

# Give value 1 to values already in latin
# Give value 0 to values not in latin
in_latin_vec <- c()
for (sample_name in sample_vec) {
  in_latin     <- length(which(tolower(ref_latin) == tolower(sample_name)))
  in_latin_vec <- c(in_latin_vec, in_latin)
}

is_latin <- in_latin_vec == 1

# Get corrected latin name of the samples already in latin
latin_subset    <- sample_vec[is_latin]
latin_corrected <- latin_subset

for (i in 1:length(latin_subset)) {
  sample_name   <- latin_subset[i]
  # Which reference has the same latin name as the sample
  which_correct <- which(tolower(ref_latin) == tolower(sample_name))
  latin_corrected[i] <- ref_latin[which_correct]
}

# Subset - samples that are not already in latin
common_subset   <- sample_vec[!is_latin]
common_in_latin <- common_subset

for (i in 1:length(common_subset)) {
  sample_name        <- common_subset[i]
  # Which Reference has the sample name of the sample?
  which_correct      <- which(tolower(ref_common) == tolower(sample_name))
  # Latin name of that entry
  common_in_latin[i] <- ref_latin[which_correct]
}

# Make into a single vector
corrected_species <- sample_vec
corrected_species[is_latin]  <- latin_corrected
corrected_species[!is_latin] <- common_in_latin

butterfly_sample$latin.species <- corrected_species
