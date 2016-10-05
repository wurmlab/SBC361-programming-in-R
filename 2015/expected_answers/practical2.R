# How to create a function ---------------------------------------------------------------------
# function for time converting
timeconverter <- function(inputseconds) {
  hours     <- floor(inputseconds/(60*60))
  minutes   <- floor((inputseconds-hours*(60*60))/60)
  seconds   <- inputseconds-((hours*60)+minutes)*60
  outputvec <- c(hours, minutes, seconds)
  return(outputvec)
}
time.values <- c(36000, 150000)
for (time in time.values) {
 converter<-timeconverter(inputseconds=time)
  print(converter)
}

# obtaining just even numbers ---------------------------------------------
c <- 1:1000
c[(c %% 2 == 0)] 

# Answers of the practicals ----------------------------------------------
##Practical 1
#Q1:
x <-15
y <-10
z <- x/y
z

#Q2:
# Assing each value to each rectangular side
length <-5
width  <-4
height <-3
# Calculate the volume of a rectangle by Multipling the three variables and assign the result to a variable called volume.
volume <-length*width*height
volume

#Q3:
T  T  F  T  F  T

#Q4:
x<y | x>z

#Q5:
vec1 <- c(1, 1, 2, 3, 5, 8)
vec2 <- 5:10
vec3 <- seq(0, 10, 0.25)
vec4 <- rep(2, 12)
vec5 <- c("How", "Now", "Brown", "Cow")
vec6 <- c(T, T, F, T, T, F)

#Q6:
0.00 0.25 0.50 0.75 1.00   #because I requested the first five numbers of the vector.

#Q7:
vec3[c(8, 13, 21)]

#Q8:
# the vector does not have the same length, therefore it will pick up each element of the larger vector and multiply for the shorter repeatly.
combine.vec2 <- vec1*vec3   

#Q9: the same thing than previous Question!

#Q10:
# one is sorting by row and the another one is doing by column.
rbind(vec1, vec2)
cbind(vec1, vec2)

#Q11:
# Since they have different length, R will follow the large one and repeat the smaller accordingly.
rbind(vec1, vec3)

#Q12: The same case of the previous question
cbind(vec1, vec3)

#Q13:
11 - because R sort by column.

#Q14:
Fourth

#Q15:
# sort by column is default, otherwise you need to tell R for sorting by row through "byrow".
vec1     <- 1:50
vec2     <- vec1^2
vec3     <- vec1^3
mymatrix <- matrix(c(vec1, vec2, vec3), nrow = 3, ncol = 50, byrow = T, dimnames = list(c("vec1","vec2","vec3"), c(1:50)))

#Q16:
subset(puromycin.data, subset = conc0.1)

#Q17:
x <- subset(puromycin.data, subset =c onc0.1)
y <- x$conc or mean(x$conc)
mean(y)
[1] 0.4573333


#Q18:
subset(puromycin.data, subset=state == "untreated") or subset(puromycin.data, subset=state != "treated")

#Q19:
subset(puromycin.data, subset = conc < 0.5 & rate100)

#Q20:  
subset(puromycin.data, subset = conc0.2 & state == "treated")

#Q21:
subset(puromycin.data, subset = conc < 0.1 | conc0.2)

#Q22:
subset(puromycin.data, subset = conc < 0.2 & rate < 70 & state == "treated")
 
#Q23:
reptile_data <- read.table("http://wurmlab.github.io/teaching/2013sbc361/reptile_data.txt", row.names = 1)
reptile_names <- row.names(reptile_data)
grep(pattern = "q", x = reptile.names, value = T)


#Q24:
gsub(pattern = " ", x = reptile.names2, replacement = ".")


#Q25:
Any character followed by any character, followed by X and followed by other two any characters.

#Q26:
Any character preceded by an e.

#Q27:
# or without value=T if you want the positions only.
grep(pattern = "o|E", x = reptile.names, value = T) 

#Q31:
#first:
id_numbers <- gsub(pattern = "([A-z])|(:.*)", x = reptile_names, replacement = "")


#second:
only_genus    <- gsub(pattern = "([A-z]+[0-9]+:)|( [A-z]+)", x = reptile_names, replacement = "")

#Third:
only_names    <- gsub(pattern = "(.*:)", replacement = "", x = reptile_names)
only_species  <- gsub(pattern = "(^[A-z]+ )|( [A-z]+$)", x = only_names, replacement = "")

or
species_names <- gsub(pattern = "(^[A-z]+[0-9]+:)([A-z]+ )|( [A-z]+$)", x = reptile_names, replacement = "")

#Then add the column to reptile.data:
reptile_data2 <- cbind(reptile.data, id_numbers, only_genus, species_names)

#Q32:
gsub("(\\w+)\\s+(\\w)(\\w*)", replacement = "\\1 \\U\\2\\L\\3", reptile_names, perl = TRUE)

or

sub(pattern = "([\\w|:]+ )(\\w)(.*)", x = reptile_names, replacement = "\\1\\U\\2\\L\\3", perl=TRUE)

# Answers for Practical 2 --------------------------------------------------

##Practical 2
#Q1
distconverter <- function(inputkilometres){
#convert inputkilometres into miles assinging it to miles
  miles       <- inputkilometres/1.6
    return(miles)
}

#Q2
distimeconverter  <- function(inputkilometres, inputminutes){
  #convert inputkilometres into miles assigning it to miles
  miles           <- inputkilometres/1.6
  hours           <- inputminutes/60
    milesperhours <- miles/hours
      return(milesperhours)
}

#Q3
retvolume <- function(length, width, height){
  volume  <- length*width*height
    return(volume)
}

#Q4
trueorfalse <- function(x, y){
  condition <- x > y
    return(condition)
}
## can use "if else" but it is much more complicated!
is.greater <- function(x, y){
  if (x > y){
    TRUE
  } 
  else{
    FALSE
  }
}

#Q5
for(index in 10:100){
  print(index)
}

#Q6
for(index in 16:49){
  squareroots <- sqrt(index)
   print(squareroots)
}

#Q7
for(index in 30:90){
  pair.numbers <- index[(index %% 2 == 0)] 
  evaluation   <- timeconverter(pair.numbers)
  print(evaluation)
}

## or try this easier one
pairs <- seq(30, 90, 2)
for(index in pairs){
  evaluation <- timeconverter(index)
    print(evaluation)
}

#Q8
## manually 
multiply <- function(vector){
  out    <- 1
  vector <- 1:10
  for(i in 1:length(vector)){
#first out is 1, then 1*1 and assing to out. Then 1*2 and assing to out.
#now out will be 2, therefore, 2*3 (the next vector[i]). Now out is 6.
#then 6*4 (the next vector[i]). Now out is 24, and so on...   
  out <- out*vector[i]
  }
  print(out)
} 

#easier way
input <- 1:10
for(i in input){
  product <- prod(input) 
    print(product)
}

#Q9
input <- 1:10
for(i in input){
  product <- prod(input)-i 
  print(product)
}

#Q10
#when you use a nest loop, you will do every step in the second loop
#in each step in the first loop. Here, the words "birds", "dogs", "cows"
#will be combined to Angry, then Lazy, then Happy. The more loops you have
#the more combination you get.
outer <- c("Angry", "Lazy", "Happy")
inner <- c("birds", "dogs", "cows")
for(index in outer){
  for(index2 in inner){
    print(c(index, index2))
  }
}


#Q11
v1 <- c(1:3)
v2 <- c(4:6)
v3 <- c(7:9)
for (index1 in v1){
  for(index2 in v2){
    for(index3 in v3){
      print(c(index1, index2, index3))
    }
  }
}

#Q12
DNA <- "ACCTGTCATCATCCC"
convert.rna <- function(DNA){
  RNA <- gsub("T", "U", DNA)
#for spliting in triplets you must use substring function. You need to tell
#the function the vector to be used, the initial and the final split point.
#in this case, from 1 to nchar(stands for number of characters), and then
#from 3 to final.
  Triplets <- substring(RNA, seq(1, nchar(RNA), by = 3),
                        seq(3, nchar(RNA), by = 3))
  return(Triplets)
}

#Q13
rev.comp <- function(DNA.string){
#use chartr for replacing characters, because it replaces each letter
#from the first argument for each letter from the second one. For example
#A by T, T by A... no matter the word, it treats as single characters.  
  dna <- chartr("ATGC", "TACG", DNA.string)
#since the rev function does not work properly for long characters
#use unlist(strsplit for spliting the only characters in several letters,
#not in list vector, but character instead (this what unlist means)
  dna.comp.split <- unlist(strsplit(dna, split = ""))
#use rev function to obtain the reverse for a vector content, since it is not
#a large character like a string, otherwise you will need to separate each charater.
#That's why the step above were required.
  dna.comp.split.rev <- rev(dna.comp.split)
#since gsub does not work here, use paste which is used for concatenating strings
#suitable for character vectors, when you determine a value for collapse, then
#paste will use the value specified for separating the vector content.
  dna.comp <- paste(dna.comp.split.rev, collapse = "")   
  return(dna.comp)
}
#here is the whole scritpt
rev.comp <- function(DNA.string){
  dna <- chartr("ATGC", "TACG", DNA.string)
  dna.comp.split <- unlist(strsplit(dna, split = ""))
  dna.comp.split.rev <- rev(dna.comp.split)
  dna.comp <- paste(dna.comp.split.rev, collapse = "")   
  return(dna.comp)
}
#Q14
#dumbest way
DNA <- "ACCTGTCATCATCCCAAATTT"
DNA.triplet <- substring(DNA,seq(1, nchar(DNA), by = 3), 
                         seq(3, nchar(DNA), by = 3)
                         )
first <- gsub("ACC", "T", DNA.triplet)
second <- gsub("TGT", "c", first)
third <- gsub("CAT", "H", second)
fourth <- gsub("CCC", "P", third)
fifth <- gsub("AAA", "K", fourth)
sixth <- gsub("TTT", "F", fifth)
DNA.translated <- paste(sixth, collapse = "")

#QMUL student's way
#asuming you have bioconductor, access the package Biostrings in order to
#run the function GENETIC_CODE.
library(Biostrings)
DNA.translation <- function(DNA){
  DNA.triplet <- substring(DNA,seq(1, nchar(DNA), by = 3), 
                           seq(3, nchar(DNA), by = 3))
  DNA.into.amino <- paste(GENETIC_CODE[DNA.triplet], collapse = "")
  return(DNA.into.amino)
                           
}