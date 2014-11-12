# Answer sheet

#### Q7.
```
timeConverter <- function(number.of.seconds) {

  # Convert number.of.seconds into hours, minutes, and seconds
  hours		<- floor(number.of.seconds /(60*60))
  minutes	<- floor((number.of.seconds - hours*(60*60))/60)
  seconds	<- number.of.seconds - ((hours*60)+minutes)*60

  # Create a single vector containing all three quantities
  output.vec <- c(hours, minutes, seconds)

  # Output the solution to the console
  return(output.vec)

}
```

#### Q9.
```
timeConverter <- function(number.of.seconds, additional.hours) {

  # Convert number.of.seconds into hours, minutes, and seconds
  hours		<- floor(number.of.seconds /(60*60))
  minutes	<- floor((number.of.seconds - hours*(60*60))/60)
  seconds	<- number.of.seconds - ((hours*60)+minutes)*60

  # Add additional hours to hours
  hours <- hours + additional.hours

  # Create a single vector containing all three quantities
  output.vec <- c(hours, minutes, seconds)

  # Output the solution to the console
  return(output.vec)

}
```

#### Q10
```
maxcharacters <- function(word.vec) {

  # Find the number of characters in the longest word
  characters		<- nchar(word.vec)
  largest.value	<- max(characters)

  # Output the solution
  return(largest.value)

}
```

#### Q20
```
timeConverter <- function(number.of.seconds, additional.hours=0) {

  # Convert number.of.seconds into hours, minutes, and seconds
  hours		<- floor(number.of.seconds /(60*60))
  minutes	<- floor((number.of.seconds - hours*(60*60))/60)
  seconds	<- number.of.seconds - ((hours*60)+minutes)*60

  # Add additional hours to hours
  hours <- hours + additional.hours

  # Create a single vector containing all three quantities
  output.vec <- c(hours, minutes, seconds)

  # Output the solution to the console
  return(output.vec)

}
```

#### Q11

# Create an empty matrix
long.data           <- matrix(0, nrow=30, ncol=3)
colnames(long.data) <- c("Strain", "Time", "Count")

# Create myindex
myindex <- 0

# Loop through all rows
for (myrow in 1:5) {

  # Loop through all columns except the first
  for (mycol in 2:7) {

    # Increment myindex by a value of 1
    myindex <- myindex+1

    # Drop the appropriate values into long.data
    long.data[myindex,1] <- helianthus.data[myrow,1]
    long.data[myindex,2] <- mycol-2
    long.data[myindex,3] <- helianthus.data[myrow,mycol]

  }

}
