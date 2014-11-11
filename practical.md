# Computing in R

## Regular Expressions
Regular expressions are used to search for a specific pattern in a string. To understand them, we will take an example the actual in our data file are incorrect, or inconsistent. Run the following line of code to import the collections data frame:
```
collections <- read.csv("http://yannick.poulet.org/teaching/2014msc/ant_collections.csv", row.names = 1)
```
This data frame details the genus and species names of some ants, along with the date at which they were collected and some extra stuff. Load just the names into a separate variable:
```
ant.names <- collections[,1:3]$ID.Genus_species
```
Have a close look at these names. Notice that some names have been recorded neglectfully. For example, the genus names for the Pheidole group are sometimes lowercase, and include spelling mistakes. This data needs cleaning up.

Regular expressions help us to deal with this sort of problem. They consist of a suite of tools that allow us to search for, locate, and replace characters or words within a data set. The really powerful thing about regular expressions is that we can do a "fuzzy" search, meaning the pattern we are searching for has some flexibility built into it.

### Basic find and replace
To start with we will consider a simple case of finding a pattern within a vector of names.  First of all we will search through the vector ant.names to find a list of the elements that contain the word "pheido". The function that allows us to do this is `grep()`, which has two main arguments; `pattern` and `x`. The pattern is the actual word, or part of a word, that we are looking for. The argument x describes the variable that we are searching through. In our case we want to evaluate the following code:
```
# Search through reptile.names for the word "pheido", and output positions
grep(pattern= "pheido", x=ant.names)
```
The output of this code is a list of numbers. Each of these numbers describes the position of an element in the vector `ant.names` that matches the pattern. Make sure you fully understand where these numbers came from!

Sometimes it may be more useful to obtain the actual names within which the pattern was found, rather than a list of positions. We can do this by making use of the additional argument `value = T` (see the help file for the `grep()` function for a complete list of possible arguments). The new code reads:
```
# Search through reptile.names for the word "pheido", and output names
grep(pattern= "pheido", x=ant.names, value=TRUE)
```
Now we find that the output contains the actual elements of the vector that match the pattern, rather than just a list of positions. These names should correspond exactly with the positions found in the previous example.

Finally, we may want to find and replace the pattern. This can be done using the function `gsub()`. The function `gsub()` takes `arguments`, `pattern` and `x`, just like the function `grep()`, but it also has an additional argument replacement. The argument replacement describes the new word, or words, that we want to insert in place of pattern. For example, in the ant.names the word "pheidole" is a genus name, and so should be capitalized. Thus, we want to replace the word "pheidole" with "Pheidole", as follows:
```
# Search through reptile.names for the word "pheidole" and replace with the word "Pheidole."
ant.names.better <- gsub(pattern="pheidole", replacement="Pheidole", x=ant.names)
```

The output of this function is a new vector in which the desired replacement has been carried out. Notice that the code above stores this new vector in the variable ant.names.better.

Experiment with `grep()` and `gsub()` until you are confident at using them. Then answer the following questions:

1. How could you use regular expressions to find the only element in the vector `ant.names` that contain lowercase "v"? What are the positions of this element in the vector?

2. You want to import the `ant.names` data into excel, but are having problems due to the spaces between the words (a common problem). How could you use `gsub()` to replace all spaces with a period?

### Using "fuzzy" searching
One of the most powerful features of regular expressions is the ability to perform "fuzzy" searching. Simply put, by using special characters we can introduce some flexibility into the pattern that we are searching for.
A slightly reduced list of special characters and their meanings is given below.

|Special Character | Meaning  |
|------------------|----------|
|.                 | Any character |
|?                 | The preceding item is optional and will be matched at most once. |
|*                 | The preceding item will be matched zero or more times. |
|+                 | The preceding item will be matched one or more times. |

Additional special characters can be found:

* by Googling (e.g., "Regexp cheat sheet for R")
* by typing ?regex in R

These special characters can be used on their own, or in combination with one another. To help you out with understanding these symbols, here are a few examples:

* The pattern ".r" means any character, followed by the letter "r" (e.g. "er", "or", "tr", "3r").
* The pattern "...r" means any character, followed by any character, followed by any character, followed by the letter "r" (e.g. "beer", "deer", "zekr").
* The pattern "l\*at" means zero or more copies of the letter "l", followed by the letters "at" (e.g. "at", "lat", "llllllllllat").
* The pattern "s.\+s" means the letter "s", followed by one or more copies of any character, followed by the letter "s" (e.g. "sas", "sts", "sauces", "serendipities", but NOT "ss").
* The pattern ".\* .\*" means zero or more copies of any character, followed by a space, followed by zero or more copies of any character (any combination of two words, e.g. "test word").


Some of these examples might seem very confusing at first, but if you learn what each special character means on its own and then go through the pattern one at a time you should find that it makes sense.

As an example of how fuzzy searching can be useful, we will now use these special characters to remove the ID tags from the ant names. Notice that the ID numbers are of different lengths, but they are always separated with a colon from the part that we are interested in. Therefore, we can remove these characters by searching for zero or more copies of any character, followed by a colon, and replacing this pattern with an empty string. The single line of code that achieves this is as follows:
```
ant.names.better.clean <- gsub(pattern=".*:", replacement="", x=ant.names.better)
```
Have a look inside the variable `ant.names.better.clean`. We have successfully isolated the genus and species names away from the pesky ID tags, even though the exact format of the tags may vary between different entries. Tricks like this can save us a great deal of time - especially when our data set is thousands of lines long. In fact, we have only skimmed the surface of what regular expressions can do - I encourage anyone who is interested to take a deeper look.

3. What does the pattern "..x.." mean in a regular expression?
4. What does the pattern "e+" mean in a regular expression?
5. How many names (genus or species) contain a lowercase "o" or an uppercase "E"?

Hint - you will have to combine your knowledge of regular expressions with your knowledge of logical expressions to answer this one!
Q6. Add three additional columns to the ant.data table:
one containing only the collection identifier numbers (e.g. 1423 without the "MB")
one column containing only the genus (e.g. Polyrhachis)
one containing only the species (excluding the subspecies, e.g. hemioptica)
Hint -the solution is not a "one-liner":  try to decompose this task into several steps. Make use of the functions you have just learnt and focus on extracting the numbers, genus, and species first. Only subsequently add the new columns.
Hacker Q7.  Figure out how to "capture" the first letter of the species, and transform it to make it uppercase. Do this in a generic manner (that would work on a table of thousands of species).
Hint - look into the help page of "gsub", especially the explanation for the "replacement’" parameter, as well as the examples at the bottom of the help page.
For more information on these species check Antweb (and create a field guide for your next trip! (example pdf)).

Functions

We start by taking a more detailed look at functions. You have already encountered a number of different functions, and should be quite familiar with their usage. For example, rbind(), subset(), grep() and gsub() are all functions that you have used already Although these functions all do different things, they have the same common structure to them. This structure is key to understanding how a function really works.

A function has three main parts:
Inputs
Main workings of the function
Outputs

The inputs are what go into the function. For example, in the case of grep() we were required to input a pattern that we were searching for, and a vector x within which to search. The main workings of the function are a set of rules or calculations describing what should be done using these inputs. Finally, the end result of these calculations is an output, or a series of outputs, that should be returned by the function. Figure 1 gives a rough schematic showing how a function works. Don't worry if this does not make perfect sense to you at this stage - hopefully it will do shortly!


Figure 1   Rough schematic of a function.


Now take a look at the following code. This code is designed to take a number in seconds, and convert it into hours, minutes and remaining seconds:

# Input raw number of seconds
number.of.seconds <- 19955

# Convert number.of.seconds into hours, minutes, and seconds
hours		<- floor(number.of.seconds /(60*60))
minutes	<- floor((number.of.seconds -hours*(60*60))/60)
seconds	<- number.of.seconds -((hours*60)+minutes)*60

# Create a single vector containing all three quantities
outputvec <- c(hours, minutes, seconds)

# Output the solution to the console
outputvec

Try to understand roughly what this code does, although don't worry too much about the calculations in the middle. Copy the code into a new script window, and run the script. You should find that the program outputs the solution, which in this case is 5 hours, 32 minutes, and 35 seconds.

Notice that there are three clearly identifiable parts to the code above:
- the inputs (the variable number.of.seconds),
- the main workings of the code (where the actual calculations are performed),
- the outputs (where the value of outputvec is returned).

So, we can see that this script already has some similarities with our definition of a function. But! Now imagine that we need to carry out this operation not just once on the value number.of.seconds=19955, but many hundreds of times, and each time with a different input. At the moment we would have no choice but to copy the entire code many times over, varying the input each time. This is clearly an extremely wasteful and time-consuming way to program, and is not a practical solution to the problem.
	A much better solution is to write this code as a function, rather than as a standalone script. A function takes the input value - in this case the raw time in seconds - performs all of the necessary calculations behind the scenes, and then simply returns the desired output. We will now work through the process of converting this example script into a working function, looking at each of the stages in turn.
Defining a function and its inputs
The first thing that we need is a name for our function. As with naming variables, this is not rocket science, and the name timeconverter will do fine here.



Note - there a many functions loaded into R by default. When coming up with a function name, make sure you are not overwriting one of these existing functions. Do this by searching the help for that function name. For example, if you wanted to call your function prod then type ?prod (in this example you will find that this function name is already taken).


Now we need to tell R that we want to create a new function called timeconverter. This can be done as follows:

timeconverter <- function(inputseconds) { }

(don't run this code on its own, as it will not do anything). The crucial part here, i.e. the part that cannot be fiddled with, is the word function(), which tells R that we want timeconverter to be a function, rather than an ordinary variable. The part that can be fiddled with is the text inside the curly brackets. This is where we write the name, or names, of the inputs to the function. These are often called the arguments of the function. You are already familiar with the arguments of several functions from previous work. For example, the function grep() has arguments pattern and x, as well as the optional arguments value and ignore.case. In the code above we are stating that our function timeconverter has a single argument, which is called inputseconds. So far so simple.

The main workings of a function
Once we have defined our function and stated the inputs, we can get stuck into the main body of the function. This section always opens with a squiggly bracket "{", and closes with another squiggly bracket "}".  These tell R where the function starts, and where is stops. The overall format should look like this:

timeconverter <- function(inputseconds) {

	# this is where the calculations go

}

Notice that I have indented everything inside curly brackets using the Tab key. This is not strictly required to make the function work, but is good coding practice as it makes it more obvious where the function starts and stops.
	In this example we want to paste into this section the code that actually performs the time conversion. The new code should look like this:


timeconverter <- function(inputseconds) {

	# Convert the inputseconds into hours, minutes, and seconds
	hours		<- floor(inputseconds/(60*60))
	minutes	<- floor((inputseconds-hours*(60*60))/60)
	seconds	<- inputseconds-((hours*60)+minutes)*60

	# Create a single vector containing all three quantities
	outputvec <- c(hours, minutes, seconds)

}

In the initial script we used the fixed variable number.of.seconds in our calculations. In the code above we have replaced this with the variable inputseconds, which is an argument of the function. The value of inputseconds can be different every time the function is run, while in the initial script we were stuck with the fixed value number.of.seconds=19845. In other words, by writing this as a function the user will be able to decide whatever value they want for the value of inputseconds.


Outputs
The only thing missing from the function above is the code for outputting the solution. At the moment the function simply takes the input, performs the calculations, and then keeps the solution to itself! This is no good.
	Telling a function which values to output is very simple. We simply need to use the command return() within the function, with the variable that we want to output written inside the brackets. For example, in this case we will write return(outputvec). The complete code should look like this:

timeconverter <- function(inputseconds) {

	# Convert the inputseconds into hours, minutes, and seconds
	hours		<- floor(inputseconds/(60*60))
	minutes	<- floor((inputseconds-hours*(60*60))/60)
	seconds	<- inputseconds-((hours*60)+minutes)*60

	# Create a single vector containing all three quantities
	outputvec <- c(hours, minutes, seconds)

	# Output the solution
	return(outputvec)

}

Copy this code over into a new script window, and run the script. Once this script has been evaluated you will have access to the function timeconverter(). Try typing timeconverter(345) in the console. You should find that all of the calculations required to convert this number into hours, minutes, and seconds, takes place behind the scenes, and just the final answer is output to the console.

	Remember that you can assign the output of a function to a new variable. For example, try typing converted<-timeconverter(345) in the console. The variable converted should now contain the desired output.

Returning to the beginning of this section, our initial problem was that we wanted to perform this time conversion many times over, and with different inputs each time. The unsatisfactory solution was to copy the entire script many times over, varying the input each time. We can now see that the way to solve this problem is as follows:
Define the function timeconverter() at the beginning of the script. Let the raw time in seconds be an argument to this function.
Use the function timeconverter()throughout the rest of the script whenever we need to perform a conversion.

When using this approach it is important that you remember to define the function at the beginning of the script. Otherwise when you load up R the next time, or when you try to run the script on a different machine, you will not have access to the function.

Q1. Write your own function for converting distances between different units. Your function should take the distance in kilometres as input, and return the distance in miles as output (8 kilometres is roughly equal to 5 miles). Remember to clearly annotate your code, and make appropriate use of white space.

More complex functions
Hopefully you can already see how functions can be very useful things. We can make them even more useful by considering some simple extensions.

	First, you can define multiple arguments to a function. For example, in the case of timeconverter() we might have another input - say, an additional number of hours that need to be added on to the solution. Lets call this argument additionalhours. This extra argument goes in at the point where we define the function, separated by a comma from the previous argument. The new code looks like this:

timeconverter <- function(inputseconds, additionalhours) {

	# Convert the inputseconds into hours, minutes, and seconds
	hours		<- floor(inputseconds/(60*60))
	minutes	<- floor((inputseconds-hours*(60*60))/60)
	seconds	<- inputseconds-((hours*60)+minutes)*60

	# Create a single vector containing all three quantities
	outputvec <- c(additionalhours+hours, minutes, seconds)

	# Output the solution
	return(outputvec)

}

The value of additionalhours has been included in the calculations, being added on to the existing solution. Run this code and have a go at using the function with some different input values. Remember that you will now have to specify values for both arguments when you run the function, i.e.

timeconverter(inputseconds=345, additionalhours=10).


Note that functions do not have to take single numbers as input. They can take vectors, matrices, data frames, or any other type of object, and they can also take character and logical data as well as numerical.

For example, the following function takes a vector of words as input, and outputs the number of characters in the longest word:

maxcharacters <- function(wordvec) {

	# Find the number of characters in the longest word
	characters		<- nchar(wordvec)
	largestvalue	<- max(characters)

	# Output the solution
	return(largestvalue)

}

Try creating  a vector of words and running it through this function. If you want to understand how this function actually works, simply copy the main workings of the function over into a new script and look at each command in turn (you may not have encountered the functions nchar() and max() yet).


Default values
Another neat thing that we can do is set default values for our arguments. Have another look at the timeconverter() function. This function will complain if you try to run it without setting a value for both the argument inputseconds and the argument additionalhours - for example, if we tried to run the line timeconverter(inputseconds=123) we would get an error message. This might become very annoying - especially if the vast majority of the time the value of additionalhours will be set to zero. We can set a default value for this argument when we define the function as follows:

timeconverter <- function(inputseconds, additionalhours=0) {

	# (the rest of the code)

}

Make this change to your function, and then try running the line timeconverter(inputseconds=123). You should find that this command goes through fine, using the value additionalhours=0 as the default.


Q2. This task is a bit more challenging! Go back to your function for converting kilometres to miles; make a copy with an appropriate new name. The new extended function you must create should:

take a distance in kilometres and a time in minutes as input.
convert the distance into miles, and the time into hours. It should then calculate a speed in miles per hour.
return the speed in miles per hour as output.

All of the skills required to complete this task this are given above. Take your time, and approach this problem one step at a time.

Loops
Intro to loops
One of the main things that computers are useful for is doing the same task over and over again many times. Something that may take hours to do manually might take seconds on a computer, just as long as we have the right code to do it. The programming tool that allows you to perform a task many times over is the loop.

Have a look at the following code. This code takes a particular time value, converts it to hours, minutes, and seconds using the function timeconverter(), and then prints the output in the console. It does this for a range of different time values, one after the other:

# Convert first time and print output
time <- 178
converted <- timeconverter(inputseconds=time, additionalhours=0)
print(converted)

# Convert second time and print output
time <- 179
converted <- timeconverter(inputseconds=time, additionalhours=0)
print(converted)

# Convert third time and print output
time <- 180
converted <- timeconverter(inputseconds=time, additionalhours=0)
print(converted)

# Convert fourth time and print output
time <- 181
converted <- timeconverter(inputseconds=time, additionalhours=0)
print(converted)

Notice that at each stage we are simply overwriting the value of the variables time and converted as we need to. Notice also that the script is very repetitive, with the same block of code being copied many times over. This is very wasteful in terms of the space it takes up, and the amount of time it takes to write. Now imagine doing it thousands of times rather than just four times!
	A loop solves this problem by creating a block of code that will be evaluated many times over automatically. As part of this process we create a single variable, called the index of the loop, that is overwritten with a different value each time the block is evaluated. As with functions, there is a standard syntax (way of writing) that must be used when defining a loop. A simple example of a loop is as follows:

possible.values <- 1:5
for (index in possible.values) {

	print(index)

}

Here I have used black text to show things that cannot be changed, and red text to show things that can be changed. To start with, the word "for" simply tells R that you are defining a for loop (the only type of loop that we will consider here). Then we write some round brackets. The first thing inside these brackets is the name of the index variable of the loop. Here I have called it index, although any valid variable name can be used. The index variable will take on a different value each time through the loop. Now we need to tell R what values to use for the variable index. These values are written after the word "in". Here I have used a simple vector of values going from 1 to 5. Thus, the first time through the loop the variable index will have a value 1, the second time through it will have a value 2, etc. Finally, we create a block using squiggly brackets, just as we did when defining a function. Everything inside of these brackets falls within the scope of the loop, and will be evaluated each time through. In this example I have written a simple command that prints the value of the index to the console.

Try running this code. You should see the numbers one to five output in the console. It is important to understand exactly where these numbers come from. The complete workings of the loop can be written out as follows:

First time through the loop. Set index=1. Evaluate code within squiggly brackets.
Second time through the loop. Set index=2. Evaluate code within squiggly brackets.
Third time through the loop. Set index=3. Evaluate code within squiggly brackets.
Fourth time through the loop. Set index=4. Evaluate code within squiggly brackets.
Fifth time through the loop. Set index=5. Evaluate code within squiggly brackets.

This is an extremely simple example, but its easy to see how this method can be put to good use. Going back to the problem stated at the outset, we can now write the code for converting a series of different time values in a much more compact way as follows:

time.values <- 178:181
for (time in time.values) {

	# Convert time and print output
	converted <- timeconverter(inputseconds=time, additionalhours=0)
	print(converted)

}

Notice that the index of the loop has been given a different name here, and the values that we are looping over have also changed. Run this code and look at the output. Really try to get your head around how the loop is operating at each iteration (each time through the loop), and how the output is being produced.


Slightly more complex loops
There are some interesting ways in which we can stretch our understanding of loops. First of all, it is important to recognise that the values that we are indexing over do not have to be sequential. The part where we write 178:181 in the example above really just specifies a vector that we are indexing over. Compare this with the following code:

loop.values <- c(15,5,2.3,100,16)
for (index in loop.values) {

	print(index)

}

Evaluate this code and look at the output. Notice that we have simply looped over the vector of values contained in loopvalues. We can even do away with numerical values altogether. Evaluate the following code:

loop.text <- c("How", "Now", "Brown", "Cow")
for (index in loop.text) {

	print(index)

}

Looking at the output we can see that this loop indexes over a series of character strings. This technique can be useful in some situations.
	Another important way of extending loops is to consider nested loops - in other words, loops within other loops! Have a look at the following code:

for (i in 1:5) {

	for (j in 7:9) {

		print(c(i,j))

	}

}

Here we have one loop (with index j) nested within another loop (with index i). I have also defined the values that i and j can take directly within the loops, rather than outside of the loops as in previous examples - this is simply a way of saving space. Evaluate this code and try to make sense of the output. Fiddle around with the different elements of this code until you are comfortable with nested loops. You could even try writing a third-degree nested loop (put another loop inside the j-loop)! If you plan to do this then keep in mind the following warning...


Warning - loops require your computer to perform many operations, and as such it is quite easy to crash R using loops. A simple block of code evaluated 100,000 times amounts to quite a big job. If you want to force R to exit a loop part way through, simply press Esc. Nested loops are particularly hazardous!


Once you are comfortable with loops, have a go at the following tasks:

Q5. Write a loop that iterates over the numbers 10 to 100, and prints out the index of the loop each time through.

Q6. Write a loop that iterates over the numbers 16 to 49, and prints out the square root of the index each time through (you may have to search around for the square root function).

Q7. Write a loop that iterates over all even numbers between 30 and 90. Each time round evaluate the function timeconverter() on the indexed value, and print the solution to the console.

Q8. Write a loop that calculates the product of all numbers from 1 to 10, and then subtracts the numbers 1 to 10 in turn.  i.e.  (product)-1, then (product)-2, followed by (product)-3…  etc).

Q9. Create a nested loop. The outer loop should be over the words "Angry", "Lazy" and "Happy". The inner loop should be over the words "birds", "dogs", and "cows". The code inside the inner loop should print out a vector containing the indexes of both loops (for example "Angry" and "birds" in the first instance).

Q10. Write a third-degree nested loop. Be careful not to loop over too many values or you will crash R!
Reshaping data using loops
One way in which you might find loops particularly useful is in reformatting data. By looping through all of the fields of a particular data set, and at each iteration dropping the relevant entry into a new data structure, it is possible to convert from one data format to another.
	The data set that we will use in this example is typical of the sort of data that you might be faced with in the future. Load the data by running the following line of code:

helianthus.data <- as.matrix(read.table("http://www.antgenomes.org/~yannickwurm/tmp/HelianthusData_num.txt ", header=T))

Each row in this data set represents a different strain of Helianthus annuus (sunflowers), grown under controlled conditions. The first column tells us the Strain (these are numbered 1 to 5). The remaining columns describe the number of plants found in the study area at six different points in time. For example, looking at the first row, we can see that strain 1 started out with 12 plants, but by the final time point contained 57 plants.
	We want to get this data into a new format - sometimes called long format - in which we have a matrix of three columns; the first column describes the strain, the second column describes the time point, and the third column describes the number of plants observed. The first few lines of this new data structure should look like this:

Strain	Time	Count
1	0	12
1	1	33
1	2	71
1	3	61
1	4	73
1	5	57
2	0	10
2	1	27
...

We can make the transition from the wide format of helianthus.data to the long format described above using a nested loop. But first, let us create an empty matrix, called long.data, which we will eventually fill with our new values. This matrix must have 3 columns, and 30 rows (the number 30 comes from the fact that we have five strains at six time points each). You should already know the code to produce this matrix. Have a go yourself before looking at the answer below...

# Create an empty matrix
long.data <- matrix(0, nrow=30, ncol=3)

What you might not know is how to name each of the columns of this matrix. This can be done as follows:

colnames(long.data) <- c("Strain", "Time", "Count")

With this empty matrix created we can move on to the next part of the problem - populating it with values. We want to look at each of the elements of helianthus.data one after the other, using a nested loop. The basic structure of this nested loop is as follows:

# Loop through all rows
for (myrow in 1:5) {

	# Loop through all columns except the first
	for (mycol in 2:7) {

		# This is where the main code goes.

	}
}

Here we are using loops to index through each of the rows of the matrix helianthus.data, and for each row we are indexing through columns 2 to 7 (as these are the columns that contain relevant data). At any point in the two loops, the value that we are focusing on is given by helianthus.data[myrow,mycol]. For example, the following script could be used to print out each of the values that we are interested in one after the other:

# Loop through all rows
for (myrow in 1:5) {

	# Loop through all columns except the first
	for (mycol in 2:7) {

		# Print out helianthus.data for this row and column
		print(helianthus.data[myrow,mycol])

	}

}

Hopefully you can already see that these are the exact values  we want to drop into the third column of our matrix long.data. However, we are presented with a problem - how do we drop these values one after the other into the right place in the matrix long.data? We cannot use the index myrow to help us, as this only goes through values 1:5. Similarly, we cannot use the index mycol, as this only goes through values 2:7. What we really need is a new index that goes all the way from 1 to 30, irrespective of the row or column that we are focusing on.
	If we want such an index then we will have to make it ourselves! Let us start by creating the variable myindex, and giving it a value of zero. Then, each time through the inner loop we want to increase the value of myindex by 1; this can be done using the simple command myindex <- myindex+1. This is called incrementing the variable myindex by a value of 1. At this point the script might look something like this:

# Create myindex
myindex <- 0

# Loop through all rows
for (myrow in 1:5) {

	# Loop through all columns except the first
	for (mycol in 2:7) {

		# Increment myindex by a value of 1
		myindex <- myindex+1

		# Print values of all three indexes
		print(c(myindex,myrow,mycol))

	}

}

This example code prints out the values of all three indices each time through the inner loop. Have a look at the output produced by this code, and make sure you can explain the pattern of numbers that you see (ask a demonstrator to explain if you do not).
	Now that we have three indices - one going through the rows of helianthus.data, one going through the columns of helianthus.data, and one simply going from 1 to 30 - we have all the ingredients we need to populate the matrix long.data. The adventurous among you might want to have a go at this yourselves! Otherwise, read on for the solution.
	 We have already seen that the values we want to drop into the third column of our matrix long.data are given by helianthus.data[myrow,mycol]. We have also created the variable myindex telling us the row of longdata that we want to drop into. Thus, the code we need at each iteration of the loop is the following:

long.data[myindex,3] <- helianthus.data[myrow,mycol]

This is fairly straightforward. We also want to drop the time point in the second column of long.data. Although we do not have a vector describing each of the time points, in fact the timings are very simply given by mycol minus two. For example, if we are looking at the fourth column then we are looking at the second time point. Therefore, we need the following line of code to extract the timings:

long.data[myindex,2] <- mycol-2

Finally, we want to drop the strain type into the first column of long.data. The strain type is given by the first element in every row, meaning it is given by helianthus.data[myrow,1]. Therefore, we need the following line of code to extract the strain types:

long.data[myindex,1] <- helianthus.data[myrow,1]

With the addition of these three lines of code we are finished! The final script should look something like this:

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

After running this code the matrix long.data should contain the same data as helianthus.data, but in long format rather than wide format.


If statements

Often, we may want to perform different operations depending on a condition.

OTHER SECTION.

Q11. Write a function that converts a short DNA sequence of 15 bases (eg ACCTGTCATCATCCC) to RNA, and splits the string into triplets. You will need to:

   		 1. replace T with U  ( thymine with uracil to convert DNA to RNA)
        		 2. use substring() to split the seqence into triplets, and  seq() within substring()
        		 3. return the RNA triplets string

Note substring() takes a "first" and "last" argument. The "first" would be seq() indicating where the beginning of your first triplet is and where the beginning of your last triplet is. The "last" argument would be seq() indicating where the end of your first triplet is, and the end of your last triplet.  In seq() you will also indicate you want triplets.  

   	 As an example:
dna.string<-c("AAATTT")
   				substring(dna.string, seq(1, 4, by=3), seq(3, 6, by=3))



Once you have created the function, see if you can modify the function to work for a sequence with any number of characters. Tip: you can use nchar() to create a variable such as "num.characters".

*Bonus question:

Q12. Write a function to obtain the reverse-complement of a DNA sequence. eg: "ATTACGACGCGATTCCCGGTTAATCGAATTCCCA" (complement of ATGC= TACG).  The tricky part here is reversing a single string of characters. Search around for strsplit.  You will need to:

replace bases with their complement
split the string of DNA bases into separate characters with strsplit. Note that strsplit returns a list, so you will need to use unlist() to obtain a string
reverse the sequence
remove the spaces to get your single string of DNA bases
return the reverse-complement sequence


*Hacker question:

Q13. Translate your triplet string from Q12 into amino acids. Note: depending on your method, you may not need to convert it to RNA first.  You can use a codon-to-amino-acid table and code the translation yourself. Alternatively, you could  search around and load a specific package for the manipulation of biological sequences.


Bringing it Together


2) Palindromic Sequences
Palindromes are arrangements of words or letters which read the same way whether you read them backwards or forwards, such as the phrase ‘Never odd or even’. In molecular biology, many restriction enzyme sites are palindromic.
Q3. Write a function that assesses whether a given word or phrase is a palindrome. There are some useful tools that might help you do this in the last section of last week’s practical, from ‘Working with DNA data’ onwards.
TIP: Before starting to code, think about the steps that you would need to go through in order to judge if something was a palindrome or not, write these steps as comments in an R script window, then think about how you can tell the computer to execute those steps. Only start writing the code when you have a plan of what you want to do. Don’t be afraid to test lines independently in the console and to use easy test cases where you know the answer in order to check that your function works.
TIP: The bottom section of the R help sheets normally have examples of how a command can be used. Sometimes one of these examples will be a way to solve the problem that you are currently working on. The strsplit helpsheet is particularly interesting in relation to this question.
Palindromes in molecular biology work a little differently, in that the sequence is the same if read 5’ to 3’ on one strand or 5’ to 3’ on the complementary strand. For example, ACCTAGGT is a palindromic DNA sequence as its complement is TGGATCCA.
BONUS Q4. Write a function which works out if a DNA sequence is a palindromic sequence. You will need to convert it to its reverse complement and then compare this to the original sequence. Again, there are commands which may help you in the ‘Working with DNA data’ section from the last session.
3) Open Reading Frames
Protein-coding regions in the genome can be predicted by detecting open reading frames. An open reading frame normally begins with the start codon ‘ATG’ and ends at one of three possible stop codons, ‘TGA’, ‘TAA’ and ‘TAG’. The sequence in between these two points is arranged in 3-base codons.
Q5. Write a function which uses regular expressions to detect if a given sequence contains an open reading frame. Test it on the following sequences:
ATGGATTTTTAG
ATGGATTTTCTAG
CTAATGGATTTTTGAAT
atgctaaactaa
Hacker Q6. Instead of having the function return whether your sequence contains an open reading frame, have the function return a string containing the open reading frame if there is one and NULL if there is not.
4) Species Names
Run the following line of code to import the butterfly.sample data frame:
butterfly.sample <- read.table("http://yannick.poulet.org/teaching/2014sbc361/ButterflySample.csv",sep = ",", header = T)
This data frame contains information on butterflies caught in sweep netting surveys in two locations (A and B). This data was collected by multiple people, and they have not recorded the species that they encountered the same way - some have used latin names for species and others common names, for example. In order to be able to compare the diversity between the two different sites, you will need to standardise the names.
Q7. Write a function that adds a new column in the data frame that contains the correct Latin species name for each record. You will also need to import the butterfly.reference data frame to help you do this:
butterfly.reference <- read.table("http://yannick.poulet.org/teaching/2014sbc361/ButterflyReference.csv",sep = ",", header = T)
TIP: There are several ways to do this. Remember that R is case sensitive, so you will need to account for case differences in your function. grep and gsub (which you met in the first week) both allow you to set an ‘ignore.case = T’ option. Alternately, you could use the R commands toupper() and tolower(). Use the help pages to see how these work, which you can access by typing a question mark before the command - ?toupper.
Q8. Which location has the greatest number of different species?
Q9. Which genus has been caught the greatest number of times?
If you finish these exercises before the exam, use the remaining time to review your notes from the last two sessions to make sure that everything is fresh in your mind.
