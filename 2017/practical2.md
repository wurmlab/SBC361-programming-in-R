# Computing in R - Practical 2

BIO309: Research Methods and Communication

October 2017

In this session we will build on some of the skills learned in the previous practical and will move on to consider some more advanced ways of controlling program flow. Today we will be exploring **functions** and **loops**, two important features of R that are also present in most other programming languages. We will also be doing a few exercises with DNA/RNA strings. As before, you will want to refer frequently to the R help files and your own notes when exploring these new concepts.

To get your brains warmed up, here a few questions on the material from last week (try to think of the answer before evaluating the R code):

#### Intro Q1. What would be the outcome of the code `answer <- rep(x = c(42, 24), times = 42)`? And what would then be the outcome of the code `mean(answer)`?

#### Intro Q2. Use the preloaded R data set 'Indometh'. Subset this data to return only those fields for which the concentration is strictly between 1 and 2. What is the average (mean) concentration for this subset?

#### Intro Q3. What is the regular expression that corresponds to one or more copies of the letter "e", followed by one or more copies of the letter "z"?

## Functions

Functions are pieces of code that are made to take an input (generally known as arguments), do something with it, and give back an output. They are interesting because they allow you to run the same piece of code multiple times without having to rewrite it every time you need to run it. The general construct of a function looks like this:

```R
function_name <- function(input) {

  ### the "body" of the function

  # code that performs some calculation on the input
  # possibly other lines of code that perform calculations

  # returning an output vector:
  return(output)

}
```

The `function_name` is the name of your function. You can choose whatever name you want. After the `<-`, the word `function` lets R know that you are writing a new function. The `input` will be what the calculations in the `body` of the function are based on. Between the curly brackets `{}` is the main code of your function, where the calculation(s) happen. At the end it is important to produce an output vector, otherwise the function will compute the code but it won't return anything! Note that the `return` command can only handle a single argument.

To take a self-explanatory example:

```R
x <- c(2, 3, 4, 5)
mean(x)
```

You just used the `mean` function, one of many functions loaded by default in R. The point of this function is that you can calculate the mean of any vector without explicitly writing the formula for the mean each time. The interesting thing about R is that it is possible to create your own functions. Let's create our own function to do some calculations:

```R
## Define function named 'my_first_function'

my_first_function <- function(my_input) {
  ## Do some calculations
  total       <- 50000
  calculation <- my_input / total
  output      <- calculation * 100

  ## Return the output
  return(output)
}

## Now run the function with some data:
my_first_function(my_input = 123)

```

What we did here is to create a function that computes the percentage of a given number (`my_input`) of a constant total number (50,000). We split the calculation in two, just to show that you can have many lines of code in the body of a function. The only input this function receives, is a whole number (`my_input`) and all the calculations are based on this. In the end we return the result of the second calculation (`output`).

Nothing much happens after loading the function `my_first_function` into R (you always have to evaluate the entire code of the function from `function_name` to the closing curly brackets `}` if you made changes to the code). We need to use it as well to actually produce an output. This is done by typing `my_first_function(my_input = 123)` (of course you can use other numbers instead of "123" as well). The number "123" will be used as `my_input` in the function and the output is simply the result of `(123 / 50000) * 100`.

Now take a look at the following lines of code. This code is designed to take a number in seconds and convert it into hours, minutes, and remaining seconds (don't worry too much about the computation in the middle):

```R
# Input raw number of seconds
number_of_seconds <- 19955

# Convert number_of_seconds into hours, minutes, and seconds
hours   <- floor(number_of_seconds / (60 * 60))
minutes <- floor((number_of_seconds - hours * (60 * 60)) / 60)
seconds <- number_of_seconds - ((hours * 60) + minutes) * 60

# Create a single vector containing all three quantities
output_vec <- c(hours, minutes, seconds)

# Output the solution to the console
output_vec
```

#### Q1. Modify the code above to make it into a function called `time_converter`. This function should take a single number as an argument (the number of seconds we want to convert). This function should also include the three lines of code that covert `number_of_seconds` into `hours`, `minutes`, and `seconds`, the line of code that merges these three variables into one vector, and a line returning this vector as the output of the function. Once you created the function and loaded it into R, run it on the numbers 5, 50000, and 10000000 seconds. Remember to indent any code inside the curly brackets.

#### Q2. Write your own function for converting distances between different units. Your function should take the distance in kilometres as input and return the distance in miles as output (1 kilometre is roughly 0.62 miles). Note: `floor` won't be needed in the calculations here. Remember to clearly comment/annotate your code and make appropriate use of whitespace including indentation and newlines.

### More complex functions

Hopefully you can already see how functions can be useful. We will now consider a hypothetical experiment in which we are measuring the flight speed of bees through flight tunnels.

We would like to measure the flight speed of the bees in meters per second. Annoyingly, the timer we used gave readings with the format `hours:minutes:seconds`, rather than just the total number of seconds.

Fortunately, functions in R can take more than one argument:

```r

my_function <- function(input1, input2, ...) {
    #code including input1, input2, ...
    return(something)
}

```

We would like to make a function that takes `hours`, `minutes` and `seconds` as inputs, and outputs the total number of seconds:

```r
# Input hours, minutes and seconds
hours   <- 3
minutes <- 23
seconds <- 51

# Convert to seconds
total_seconds <- hours*3600 + minutes*60 + seconds
total_seconds

```
#### Q3. Transform the previous code into a function. Make sure it has three arguments and a descriptive name. Test the function with a range of times.

In our experiment, most bees flew through the test tunnel in under an hour, and it is time consumming to include the argument `hours = 0` every time we call the function we just created.

A neat thing about functions is that we can set default values for any argument, using the syntax:

```r
my_function <- function(input1, ..., input15 = default) {
  # code including input1, input2, ..., input15
  return(something)
}
```

The default argument(s) is generally placed at the end of the argument list.

#### Q4. Make the `hours` and `minutes` arguments be defined as 0 by default in your function. Run the function without supplying these two arguments. Now run it again with using a range of `hours` and `minutes`.

Finally, we would like to create a function to measure the flight speed of the bees in meters per second. This function should:

* Take the tunnel length (in meters), hours, minutes and seconds as arguments
* Use your previous function to convert hours, minutes and seconds to seconds
* Calculate the speed of the bees in meters per second
* Returns the speed of the bees

#### Q5. Create this function, and test it with the following values:

Distance (m) | Time (hours:minutes:seconds)
---------|------
10 |00:00:20
10 |00:00:43
150 |00:07:20
150 |00:13:41
500 |00:48:21
500 |01:03:23

All of the skills required to complete this task are given above. Take your time and approach this problem one step at a time. Also, don't hesitate to ask for help!

### Functions with other types of input

Note that functions do not have to take single numbers as input. They can take vectors, matrices, data frames, or any other type of object, and they can also take character and logical data as well as numerical. For example, the `mean` function we used earlier took the vector `x <- c(2, 3, 4, 5)` as input, which is a single vector with four numbers.

#### Q6. Write a function that takes a vector of words as input and outputs the number of characters in the longest word. Hint: you are going to need to find out how R counts the number of characters in words and how it finds the maximum value in a vector - use Google!

## Loops
Imagine you need to run the function `time_converter` on different numbers. You could type `time_converter` many different times, each time with a different number. But now imagine you had to type that thousands of times. It would be impossible.

Fortunately, computers were built to perform same tasks over and over again many times. They do this using a construct called a *loop*. Although there are several types of loops, we are going to learn about the 'for loop'. It works this way:

```R
## For loop example
for (seconds in c(1000, 2000, 3000)) {
  time_in_hours <- time_converter(number_of_seconds = seconds)
  print(time_in_hours)
}
```

The loop will run 3 times. Each time, it will define the variable `seconds` as a different number from the vector `(1000, 2000, 3000)`. It will compute a new time in hours and print it for every number in the vector.

### Slightly more complex loops
There are some interesting ways in which we can stretch our understanding of loops. First of all, it is important to recognise that the values that we are iterating over can be anything that goes in a vector. The vector can be defined outside the loop definition line:

```R
## Non-sequential loop values
loop_values <- c(1:50)
for (value in loop_values) {
 	print(value)
}

## The same as writing:
for (value in 1:50) {
 	print(value)
}

## Sequential loop values
my_favourite_numbers <- c(42, 3.14, 7, 69, 6.626e-34, 1024, 4, 2.718281828, 666 , 1.61803398, 99)
for (value in my_favourite_numbers) {
  print(paste(value, "is my favourite number"))
}

## Character based loop values
greetings <- c("Hey", "Hi", "Hello", "Aloha", "Howdy", "Yooooo!", "Wassup", "What's shakin?", "yello!", "Greetings",  "Dude, wake up!")
for (word in greetings) {
  print(word)
}

## Looping through the positions of each element of the vector (the index, or position)
colour_vec <- c("red","green","blue","yellow","orange","purple","pink")
for (position in 1:length(colour_vec)) {
  current_colour <- colour_vec[position]
  print(current_colour)
}

```

### Storing loop results

You will often want to do more than just print the loop results. For example, you may want to keep them in a separate variable. Check the following example. What's does `phrase_vec` look like after the 4th iteration?

```R
## Vector to loop through
practical_attribute_vec <- c("great", "boring", "very long", "amazeballs!", "informative", "fun")

## Empty vector to store the loop results in
phrase_vec <- c()

for (practical_attribute in practical_attribute_vec) {
 	phrase <- paste("This practical is", practical_attribute)
 	# Add the loop result to end of the vector of results
 	phrase_vec <- append(phrase_vec, phrase)
}
```

A different way of approaching a for loop is to loop through the indexes of a vector, rather than the vector itself. In the following code, we also create a vector for the result with the same length as the vector we are looping through and we use the index to 'populate' it:

```R
## Vector to loop through
practical_attribute_vec <- c("great", "boring", "very long", "amazeballs!", "informative", "fun")

## Vector with empty elements (as long as practical_attribute_vec)
phrase_vec <- rep("", times = length(practical_attribute_vec))

## Loop through the index rather than the vector
for (index in 1:length(practical_attribute_vec)) {

  ## Create phrase, getting attribute from practical_attribute_vec[i]
  phrase        <- paste("This practical is", practical_attribute_vec[index])

  ## Add phrase to the right index of the results vector
  phrase_vec[index] <- phrase

}
```

Once you are comfortable with loops, have a go at the following tasks:

#### Q7: Write a loop that iterates over the colours red, green, blue, yellow, orange, purple, pink and prints out the index (ie the position of the colour in the vector) and the colour itself. This should be done in human-readable format (i.e. "the colour red is in position 1 in the vector", "the colour blue is in position 2 in the vector", and so on). Make sure to indent the code appropriately between the curly brackets.

#### Q8. Write a loop that iterates over the numbers 10 to 100 and stores this number in a separate vector. Can you explain the sequence of events that the computer goes through during, say, the 20th iteration?

#### Q9-A. Write a loop that iterates over the numbers 16 to 49 and prints out the square root of the number each time through (you may have to search around for the square root function). Yes we *absolutely* want you to write a loop to do this.

#### Q9-B. Make the loop from Q9-A store the results to a separate vector called `my_square_roots` instead of just printing the results. What's the value of the 3rd iteration? What's the sum of the square roots of the numbers 16 to 49?

#### Q10. Write a loop that iterates over all even numbers between 30 and 90. At each iteration, run your function to convert each of these even numbers from kilometres into miles (you created this function in Q2). The loop should store the results in a separate vector.

#### Q11. Write a loop that calculates the population size depending on the reproduction rate over a period of 20 years. Store the population value for each iteration of the loop in a separate vector.

* Use a starting population size of 1000.
* Create a vector containing the reproduction rate for each year: `reproduction_rate <- rnorm(20, mean = 1, sd = 0.2)`.
* Loop through the reproduction rate vector and update the population size value accordingly.
* In addition, store each year's population and plot or just print it against the year (1 to 20).

### Nested Loops

Another important way of extending loops is to consider nested loops - in other words, loops within other loops! Have a look at the following code:

```R
for (i in 1:5) {
  for (j in 7:9) {
    print(c(i, j))
  }
}
```

Here we have one loop (with index j) nested within another loop (with index i). We have also defined the values that i and j can take directly within the loops, rather than outside of the loops as in previous examples - this is simply a way of saving space. With a pen and paper, determine what is the 1st line printed, and then what is the 10th line printed? Evaluate this code and try to make sense of the output. Fiddle around with the different elements of this code until you are comfortable with nested loops. Warning - loops require your computer to perform many operations, and as such it is quite easy to crash R using loops. A simple block of code evaluated 100,000 times amounts to quite a big job. If you want to force R to exit a loop part way through, simply press 'Esc'. Nested loops are particularly hazardous!

#### Q12-A. Create a nested loop. The outer loop should iterate over the words "Angry", "Lazy", and "Happy". The inner loop should iterate over the words "birds", "dogs", and "horses". The code inside the inner loop should print out a vector containing the values of both loops (for example "Angry" and "birds" in the first instance).

#### Q12-B. Look again at the code you wrote in Q12-A. Did you sufficiently indent your code (like in the example of a nested loop above), so that it is easy to see which lines of code are executed at which point of the different loops? If not, DO IT NOW! And continue doing it for the next questions as well.

#### Q13. Write a third-degree nested loop (i.e. a loop within a loop within a loop). Be careful not to loop over too many values or you will crash R!

(if you're short of ideas, you could for example add `practical_attribute_vec` qualifiers to Q12...)

### Using loops to reformat a data set

Loops are particularly useful to reformat data sets. By looping through all of the fields of a particular data set and at each iteration saving the relevant entry into a new data structure, it is possible to convert from one data format into another.

The data set that we will use in this example is typical of the sort of data that you might be faced with in the future. Load the data by running the following line of code:

```R
helianthus_data <- as.matrix(read.table("https://wurmlab.github.io/SBC361-programming-in-R/HelianthusData_num.txt", header = TRUE))
```

Each row in this data set represents a different strain of *Helianthus annuus* (sunflowers), grown under controlled conditions. The first column tells us the Strain (these are numbered from 1 to 5). The remaining columns describe the number of plants found in the study area at six different points in time. For example, looking at the first row, we can see that strain 1 started out with 12 plants in the first time point and ended up with 57 plants in the last time point.

We want to get this data into a new format - sometimes called long format - in which we have a matrix of three columns; the first column describes the strain, the second column describes the time point, and the third column describes the number of plants observed. It turns out that researchers often need to do this! For example, plotting using `ggplot` (and many analysis packages) require long format. The first few lines of this new data structure should look like this:

Strain | Time | Count
-------|------|------
1 |0 |12
1 |1 |33
1 |2 |71
1 |3 |61
1 |4 |73
1 |5 |57
2 |0 |10
2 |1 |27
...|...|...

We can make the transition from the wide format of `helianthus_data` to the long format described above using a nested loop. But first, let us create an empty matrix, which we will eventually fill with our new values.

#### Q14-A. Create an empty matrix, called `long_data`. This matrix must have 3 columns and 30 rows (the number 30 comes from the fact that we have five strains at six time points each). Name the columns `c("Strain", "Time", "Count")`.

With this empty matrix created, we can move on to the next part of the problem - populating it with values. We want to look at each of the elements of helianthus_data one after the other, using a nested loop. The basic structure of this nested loop is as follows:

```R
# Loop through all rows of helianthus_data
for (my_row in 1:5) {
  # Loop through all columns of helianthus_data except the first
  for (my_col in 2:7) {

    # This is where the main code goes (populating long_data with values).

  }
}
```

Here we are using loops to index through each of the rows of the matrix `helianthus_data`, and for each row we are indexing through columns 2 to 7 (as these are the columns that contain relevant data). At any point in the two loops, the value that we are focusing on is given by `helianthus_data[my_row, my_col]`.

Hopefully you can already see that these are the exact values we want to drop into the third column of our matrix `long_data`. However, we are presented with a problem - how do we drop these values one after the other into the right place in the matrix `long_data`? We cannot use the index `my_row` to help us, as this only goes through values 1 to 5. Similarly, we cannot use the index `my_col`, as this only goes through values 2 to 7. What we really need is a new index that goes all the way from 1 to 30, irrespectively of the row or column that we are focusing on.

#### Q14-B. Change the for loop above to include a variable `my_index`. This variable should be defined as being 0 before the loop starts. At every iteration of the inner loop, you should add 1 to it. What are the values of `my_row` and `my_col` when `my_index` is 3? Add a line to check the indices each time through.

It should look something like this:

```R
# my_index defined as 0 before the loop starts
my_index <- 0

# Loop through all rows
for (my_row in 1:5) {
  # Loop through all columns except the first
  for (my_col in 2:7) {

    ## Change my_index here:
    # make my_index equal to my_index plus one

    # Print all the indices here to check that you are doing the right thing
  }
}
```

Now that we have three indices - one going through the rows of `helianthus_data`, one going through the columns of `helianthus_data`, and one simply going from 1 to 30 - we have all the ingredients we need to populate the matrix `long_data`. The code we need at each iteration of the loop is the following:

```R
# Get Count
long_data[my_index, 3] <- helianthus_data[my_row, my_col]
```

This is fairly straightforward. We also want to drop the time point in the second column of `long_data`. Although we do not have a vector describing each of the time points, in fact the timings are very simply given by 'my_col minus two'. For example, if we are looking at the fourth column then we are looking at the second time point. Therefore, we need the following line of code to extract the timings:

```R
# Get Time
long_data[my_index, 2] <- my_col - 2
```

Finally, we want to drop the strain type into the first column of `long_data`. The strain type is given by the first element in every row, meaning it is given by `helianthus_data[my_row, 1]`. Therefore, we need the following line of code to extract the strain types:

```R
# Get Strain
long_data[my_index, 1] <- helianthus_data[my_row, 1]
```

#### Q14-C. Bring all of this together to finish the for loop, and run it!
To check what you've done, you can print the start and end of long_data:

```R
head(long_data)
tail(long_data)
```

#### Q14-D. What can you do to reduce the risks of things going wrong if there is a chance you may want to rerun this loop on a similar but slightly different dataset?

## Working with DNA data

#### Q15-A. Write a function that converts a short DNA sequence of 15 bases (e.g. "ACCTGTCATCATCCC") to RNA and splits the string into codon triplets. You will need to:

  * load the data into R: `dna_string <- scan("https://wurmlab.github.io/SBC361-programming-in-R/sequence.txt", what = character())`
  * replace T with U  (thymine with uracil to convert DNA to RNA)
  * use `substring()` to split the sequence into triplets and `seq()` within `substring()`
  * return the RNA triplets string

Note `substring()` takes a 'first' and 'last' argument. The 'first' would be a sequence indicating where the beginnings of your triplets are. The 'last' argument would be a sequence indicating where the ends of your triplets are.  In `seq()` you will also indicate you want triplets.

As an example:

```R
dna_string <- c("AAATTT")
substring(dna_string, seq(1, 4, by = 3), seq(3, 6, by = 3))
```

#### Q15-B. Once you have created the function, see if you can modify it to work for a sequence with any number of characters. Tip: you can use `nchar()` to create a variable such as `num_characters`.

#### Q16. (Bonus question). Write a function to obtain the reverse-complement of a DNA sequence.

You can use this sequence (copy and paste it into R): `"ATTACGACGCGATTCCCGGTTAATCGAATTCCCA"`. As an example, the reverse-complement of ATGC is GCAT.

The tricky part here is reversing a single string of characters. Search around for `strsplit`.  You will need to:

* replace bases with their complement (you can use `gsub`, judiciously replacing uppercase characters with lowercase characters (or vice-versa)).
* split the string of DNA bases into separate characters with `strsplit`. Unfortunately, `strsplit` confusingly returns a list, so you will need to use `unlist()` to obtain a string again
* reverse the sequence
* remove the spaces to get your single string of DNA bases (look into the help files for the `paste()` function)
* return the reverse-complement sequence

#### Q17. (Mastermind question). Translate your triplet string from Q15 into amino acids.
Note: depending on your method, you may not need to convert it to RNA first.  You can use a codon-to-amino-acid table and code the translation yourself. Your solution could include a function calling a function. Alternatively, you could search around and load a specific package for the manipulation of biological sequences.

## Bringing it all together

Well done for making it this far! Now try to bring all of your knowledge together. Have another look over your previous notes and make sure these ideas are still fresh in your mind. Have a go at writing your own scripts, preferably combining a number of different concepts (for example, you could try making a function that acts on a matrix and then using this function within a loop). Another good idea would be to come up with a problem that you want to solve (either for fun or for other coursework) and then write a function that solves it.

Many of the ideas presented in this and the last session are designed to challenge you. Do not expect to understand them from a single read through the material. Rather, you will have to play around with many different examples and applications before the penny drops completely. On the plus side, structures such as loops and functions are common to almost all programming languages, and so once you understand these concepts the world of programming is your oyster!
