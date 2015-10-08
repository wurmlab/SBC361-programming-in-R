# Computing in R - Practical 1

SBC361: Research Methods and Communication

October 2015

Yannick Wurm and Rodrigo Pracana (and Robert Verity)

## Introduction

This practical series is aimed at teaching basic programming in R.  You should already be familiar with R from your second year lectures and practicals, and so some of the material covered here should be fairly straightforward. However! The ultimate aim of these practicals differs from your previous work in that the focus will be on creating, accessing, and manipulating different data structures. As this is often the first step in real scientific research, you will find that the skills you develop here will be invaluable to you later on in your studies (keep that final year project in mind)!  It's also a general (though very simple) introduction to programming: the stuff we will be learning about exists, in one way or another, in most other programming languages.

You will be pleased to hear that we will not be covering any stats in these practicals (you should already have mastered stats by now). However, do not relax too much, as these practicals will move fairly quickly, and you will need to stay focused in order to do well in the final exam. Refer back to your notes from last year, make use of R’s help system (and Google), your neighbour, and if you're really stuck don't be afraid to ask a demonstrator.

The first practical has two parts. The first a short reminder of the basics of R that you covered last year. The second part is an introduction to regular expressions.

## The environment

To start with, let us reacquaint ourselves with the R environment. First of all, launch R (in the computer room, probably the “Bio version” if there are several to choose from; but any R install should be fine).

Once you have done this you should see a single window. This is called the console. The console is where you go to actually run lines of code. The other major way in which you will program in R is by writing code in a separate file called a script. Create a new script by going to File> New script. An empty window pops up, in which you can also type code. Try typing 1+2 in this window and pressing return. Notice that no output is produced - the cursor just moves to the next line. This is because a script is fundamentally different from the console and in fact works just like any other text editor. In order to run the code that we have written in a script we need to select the line(s) that we want to run and go to Edit>Run line or selection. This copies the selected line(s) over to the console and evaluates them in the order they are written. In this way we can create a long sequence of commands (i.e. a program) in a way that would not be possible by working directly in the console. In general you should work mainly with scripts and only use the console for small tasks like checking that your script is working as planned.

!Tip! - To run an entire script, first select all with the keyboard shortcut Ctrl+a, then run selected lines with the shortcut Ctrl+r (Windows only). This also works for just a single selected line.

We strongly suggest that you write anything you want to keep in scripts and that you save these scripts in your home directory or on a USB stick. (Scripts are just text files; most people use up using other text editors, such as SublimeText, TextWrangler, or they run R using RStudio; all these options make the code prettier and easier to read).

It is also worth keeping in mind that the R help is extremely good. Just put a question mark before any function that you do not understand (e.g. ?length) to bring up the help file for that function. There are also many R websites and forums that you may find useful. The best way to learn any programming language is to fiddle - so please fiddle away with these tools to guide you!


## Variables
A variable is a symbolic way of storing a particular set of values and/or characters. For example, try typing
```
x <- 5
y <- 225
```
into the console and hitting return. This assigns the number `5` to the symbol `x`. You can run operations on variables (e.g. `3*x^2`), create new variables from existing variables (e.g. `y <- 3*x^2`), and reassign existing variables to a new value (e.g.` x <- 3*x^2`).

The `=` symbol can also be used for assignment instead of `<-`, but this is frowned upon by most R users (it makes your code less readable). Thus please try to use `<-` . When in doubt about how to write something, check [Hadley Wickham style guide](http://adv-r.had.co.nz/Style.html); it provides standard guidelines which most R users follow.

You can name variables almost anything you want. Try using descriptive names (avoiding  x and y), but don’t make them too long! As a rule of thumb, remember to make your code easily understandable for other people, including your future self.

Finally some variable names are not allowed. Typing `?make.names` in the console brings up a help file describing the important variable name restrictions.

#### Q1. Make a new variable, `z`, out of the values in `x` and `y`. You can choose any formula you want for `z`, as long as it contains both `x` and `y`.

## Data classes
There are several classes of data.  In simple terms, the class of your data tells you whether R interprets the data as numbers, letters, factors, logical values or a number of alternatives. You can use the function `class()` to check the class of a variable.

You will probably have met variables of class numeric (`x <- 5`) and character (`x <- ‘hello’`). An important class of data that you might not be familiar with is logical data. Simply put, logical data can only take one of two possible values: `TRUE` or `FALSE`. There are a number of different ways of arriving at a logical variable. The most obvious is to simply define a variable as true, for example
```
x <- TRUE
```
or false, for example
```
x <- FALSE
```

Try creating a logical variable in this way and look at the class of the variable - if you have done it correctly it should read "logical" (keep in mind that R is case-sensitive, i.e. x <- false will throw an error). However, this is not the way that logical variables tend to be used in programming. More often than not we arrive at a logical variable through a particular type of calculation, called a logical expression. You can think of a logical expression as a statement that we send to R, which may be a true statement, or it may be a lie! For example, try evaluating the code

```
5 > 4
```

This statement is clearly true and accordingly R returns a value `TRUE`. The statement
```
5 < 4
```
on the other hand, returns the value `FALSE`. We can assign this logical value to a variable by using the logical expression as input to the variable. This sounds complicated, but in practice it is very simple. Take the example
```
x <- (5 > 4)
```
You can read this to mean "the variable x is assigned the outcome of the logical expression 5 > 4". In this particular example the variable x will be assigned the logical value `TRUE`. Notice that the logical expression itself has been placed within parentheses. This is not strictly required, but is good coding practice as it avoids confusion between the assignment symbol and the logical expression.

The main logical operators that you should be familiar with are the following:

* `>` is greater than
* `<` is less than
* `>=` is greater than or equal to
* `<=` is less than or equal to
* `==` is equal to
* `!=` is not equal to

Have a play around with some of these operators in your own made-up logical expressions. Make sure you are comfortable assigning a logical value to a variable.

We can create more sophisticated logical expressions using the "and" command and the "or" command. The "and" command is written `&` (keyboard shortcut Shift+7), while the "or" command is written `|` (keyboard shortcut Shift+\ on a standard Windows keyboard). These operators can be placed between two or more logical expressions - exactly as you would do in a spoken sentence. For example, the expression
```
(x > 5) & (x <= 10)
```
can be read "x is greater than five, and x is less than or equal to ten". Similarly, the expression
```
(x < 6) | (x == 12)
```
can be read "x is less than six, or x is equal to twelve". By using a combination of these operators, while making good use of parentheses, it is possible to come up with some quite complex statements.


**A short note on classes:**

It's easy to get numeric and character data confused. For example, in `x <- "blue"`, `x` is of class "character", while in `x <- 4`, `x` is of class "numeric". The problem comes if you type:
```
x <- "4"
```
In this case `x` is of class "character" because of the quotation marks. Try typing `class(x)` if you are confused. You can also type `is.numeric(x)` and `is.character(x)`.



#### Q2. Let us define the variable `x <- 10`. What will the outcome of the following expressions be?

* `(x > 5)`
* `(x <= 10)`
* `(x != 10)`
* `(x < 5) & (x < 105)`
* `(x < 4) | (x > 14) | (x == 10)`

#### Q3. Below are some of the rules that logical operators follow. Do you understand what each rule means?

* `TRUE & TRUE` is `TRUE`
* `TRUE & FALSE` is `FALSE`
* `FALSE & TRUE` is `FALSE`
* `TRUE | FALSE` is `TRUE`
* `FALSE | TRUE` is `TRUE`

#### Q4. Given three variables (`x`, `y` and `z`), how would you write the following sentence in a logical expression?

*The variable `x` is less than variable `y`, or is it greater than variable `z`?*


## Types of Objects
### Scalars and vectors
Objects can be of different types. So far, we have looked at scalar objects, which contain a single variable (e.g. `x <- 3`). Another very common type of object is the *vector*, which is an object containing several elements:
```
numeric_vec   <- c(1, 1, 2, 3, 5, 8)   # c is a function for combining values into a vector or list.
seq_vec1      <- 5:10
seq_vec2      <- seq(from = 0, to = 10, by = 0.25)
rep_vec       <- rep(x = 2, times = 12)
character_vec <- c("How", "Now", "Brown", "Cow")
logical_vec   <- c(TRUE, TRUE, FALSE, TRUE, TRUE, FALSE)
```
As you know by now, R is good at manipulating these vectors, with easy ways of accessing individual elements of a vector by using scalar objects as index (e.g. `x[3]`) and of applying simple operations on all elements of the vector (e.g. `vec1*3` or `vec1*vec2`). You can also use vectors to access a set of elements (e.g. `x[1:5]`) or specific elements (e.g. `x[c(2, 7, 9)]`) of a vector or variable. Remember that, for some calculations between different vectors, the vectors need to be compatible. This generally means they have lengths that are multiple of each other. Note that in R, the first position of a vector has the index 1, unlike in some other programming languages where the first position has the index 0.

#### Q5. What number would you obtain if you typed `seq_vec1[3]` in the console? (try working this out for yourself before typing it into R)

#### Q6. What happens when you type `seq_vec2[1:5]` in the console an hit return?

#### Q7. How would you retrieve just the 8th, 13th and 21st elements of `seq_vec2`?

Simple calculations can be performed on vectors, in which case the operation is applied to every element of the vector separately. For example, try typing
```
numeric_vec_squared <- numeric_vec^2
```
in the console. You will find that `numeric_vec_squared` contains values taken from `numeric_vec`, where each element has been squared individually. Similarly, you can create logical expressions that apply to the whole matrix, such as `numeric_vec > 3`.

You can also perform operations involving several vectors, as long as the vectors have compatible lengths. For example, try typing
```
combined_vec1 <- numeric_vec*seq_vec1
```
You will find that each of the elements of `combined_vec1` is equal to the product of the corresponding elements in `numeric_vec` and `seq_vec1`

#### Q8. Try evaluating `combined_vec2 <- numeric_vec*seq_vec2` in the console. What happens? Why?

#### Q9. What do you type to find the length of a vector?

#### Q10. In fact, compatible does not mean that vectors have to be exactly the same length. Try evaluating `combined_vec3 <- numeric_vec*rep_vec` in the console, and look at the result. What is the reasoning behind the values produced?

### Matrices
Another major type of object in R is the matrix. A matrix is simply a rectangular grid of values. One of the simplest ways of producing a matrix is by combining several vectors through the functions `rbind()` and `cbind()` (try `rbind(numeric_vec, seq_vec1)`).

#### Q11. What happens when you evaluate `rbind(numeric_vec, seq_vec1)`? What happens when you evaluate `cbind(numeric_vec, seq_vec1)`? Why?
#### Q12. When you evaluate `rbind(numeric_vec, seq_vec2)` you get a warning message. Why?
#### Q13. What happens when you evaluate `rbind(numeric_vec, rep_vec)`? Why?

You can also create matrices directly in a number of different ways:
```
mat1 <- matrix(data = 1:24, nrow = 6, ncol = 4)
mat2 <- matrix(data = 1:24, nrow = 6, ncol = 4, byrow = T)
mat3 <- diag(x = 5, nrow = 3, ncol = 2)
mat4 <- outer(X = 1:5, Y = 4:8)
mat5 <- matrix(data = "Hello World", nrow = 2, ncol = 5)
```
As with vectors, you can get to the elements of a matrix using square brackets, but with a two-dimensional index, one for row and another one for columns! (`mat1[4, 3]`, `mat1[1:4, 1:2]`, `mat1[1:3, ]`).

#### Q14. How do you retrieve the 2 column of `mat2`?

You can perform simple calculations on matrices, in which case the calculation applies to each element separately:
```
(mat3 + 2)*2
```
You can also combine the values in several matrices, as long as the dimensions of the matrices are compatible
```
(mat3*100) + mat4
```

Finally, you can create logical expressions that apply to an entire matrix. For example, try evaluating:
```
(mat1 > 10)
```

There are a number of useful functions that can be applied to matrices. Have a look at each of the following functions, and try to make sense of the output:
* `length()`
* `dim()`
* `t()`
* `colSums()`
* `summary()`
Keep in mind that if you ever need help in understanding a function, just bring up the help file for that function.

#### Q15. The variable `mat1` describes a matrix produced by the following code:
```
mat1 <- matrix(data = 1:50, nrow = 10, ncol = 5)
```
What number would we expect to see when we evaluate `mat1[1, 2]` (try to answer this without evaluating the code!)? Why not a different number?

#### Q16. Which of these commands would output the 2nd and 4th columns of mat1 only (again, try answering this without evaluating the code!)?
```
mat1[2, 4]
mat1(, (2, 4))
mat1[c(2, 4), ]
mat1[, c(2, 4)]
```
#### Q17. Write your own (fully annotated) program for creating a matrix from three separate vectors. The first vector, `vec1`, should be 50 elements long, and should simply contain the numbers 1 to 50. The second vector, `vec2`, should contain the square of these numbers (i.e. `vec1` raised to the power 2). The third vector, `vec3`, should contain the cube of these numbers (i.e. `vec1` raised to the power 3). Finally, create a matrix, `my_matrix`, which has `vec1` as the first row, `vec2` as the second row, and `vec3` as the third row.

### Data frame
A very common type of object is the data frame. On the face of it, these look very similar to matrices. However, there are some important differences between data frames and matrices. The most important difference is that, in a matrix, all the elements need to be of the same class, while in a data frame, different classes are allowed. Several data frames are  loaded into R by default (`puromycin_data <- Puromycin`). Like in matrices, you can access different elements of the data frame using indices (`puromycin_data[1, 1]`). While you can get to specific columns using an index (`puromycin_data[, 2]`), R allows you to get to specific columns using their name and the dollar sign: `puromycin_data$rate`. Note that, although the data frame is of class data frame, typing `puromycin_data$rate` will return a vector of class numeric (try using the function `class()` to check this).

Normally, when R encounters columns with words in a data frame (rather than numbers), it automatically interprets them as data of a different type, the factor. This allows us to work with categorical data, by organising the data into discrete categories, known as levels (e.g., red, yellow and blue could be the levels of a column called ‘colour’). Type the following for an example:
```
puromycin_data$rate
class(puromycin_data$rate)
levels(puromycin_data$rate)
as.character(puromycin_data$rate)
```

### Lists
The last data type that is commonly seen in R is the list. A list is a bit like a complicated vector, where the elements can be objects of any type. For example, we can make a list of vectors:
```
my_list <- list(A = c(1, 2, 3), B = c(5, 6, 7, 8, 9, 10), D = c('G', 'H'))
```
Again, we can access elements from the list using their index. However, using a single bracket `[]` will return a list (`my_list[1]`), while using the double bracket will return an object of the same type as the element of the list (`my_list[[1]]` will return a vector of numeric elements). We can get specific elements by their names using the bracket notation (`my_list[['A']]`) or the dollar sign (`my_list$A`). Lists can get very complex, since there is no limits on the data type of the elements. Therefore, you can get lists of vectors, lists of lists, lists of vectors and lists, etc…

There are other types of data in R, with many being specific to particular libraries.

## Subsetting a data frame
We have already come across one way of subsetting through the use of square brackets. By typing, for example,
```
puromycin_data <- Puromycin
puromycin_data[1:3, ]
puromycin_data[, 2]
```
we can isolate certain rows of the data frame that we are interested in. We can use the dollar sign `$` to get a specific column:
```
puromycin_data$rate
```

We can isolate data easily by using the logical statements mentioned above. For example, we can check which rows have a rate that is less than 100:
```
#returns TRUE or FALSE
puromycin_data$rate < 100
#returns which elements are TRUE
which(puromycin_data$rate < 100)
```

We can use the subset function to select the rows for which the statement is TRUE:
```
# returns all the columns, but only the rows for which
# puromycin_data$rate < 100 is TRUE
puromycin_sub <- subset(puromycin_data, rate < 100)
```

We could subset by the "state" column:
```
puromycin_treated <- subset(puromycin_data, subset = state == "treated")
```

This will return all fields for which the state is equal to "treated". Notice that the factor must be written in quotation marks here, as R needs to know that it is looking for a particular set of characters, rather than a variable.

#### Q18. How would you subset the variable `puromycin_data` to return only those fields for which the concentration is greater than 0.1?
#### Q19. What is the average (mean) concentration for these cells?
#### Q20. How would you subset the variable `puromycin_data` to return only the fields for which the cells were not treated?
#### Q21. How would you subset the variable `puromycin_data` to return only the fields for which the concentration is less than 0.5 and the rate is greater than 100 (remember the "and" command from logical expressions)?
#### Q22. How would you subset the variable `puromycin_data` to return only the fields for which the concentration is greater than 0.2 and the cells have been treated?
#### Q23. How would you subset the variable `puromycin_data` to return only the fields for which the concentration is less than 0.1 or greater than 0.2?
#### Q24. How would you subset the variable `puromycin_data` to return only the fields for which the concentration is less than 0.2 and the rate is less than 70 and the cells have been treated?


## Good coding practice
Keep your code clean and tidy by making use of comments and white space and respecting the style guide.  Comments start with the character # (R simply does not interpret anything written between a comment sign and the end of the line. They  allow you to annotate your code, i.e. to write helpful notes in between all the raw program code. Notice also that white space such as empty lines, spaces and indentations (obtained by pressing the Tab key) are invisible to R. Making good use of white space helps keep your code readable, and so does using clear and descriptive variable names.

The following two examples make this point clear. Both programs do exactly the same thing, but one will make sense one year from now, and the other will not!

```
Example 1
boooom <-0.01
blah2          =0.005
    blah3<- 0.0036
bigblah                           = boooom+ blah2        + blah3
tadayeahmanfunky<-100*exp(bigblah*10)
tadayeahmanfunky
```

```
Example 2

#--------------------------------
# Program:        PopSize.R
# Author:        Bob Verity
# Date:        01/10/2013
# Purpose:
# Works out the size of a population under a simple model of exponential growth.
# The growth rate is assumed to be equal to the sum of the nutrient content (% sugars),
# the temperature (centigrade above 20), and the humidity (%).
# Other parameters include the starting population size (number of individuals)
# and the time allowed to grow (hours).
#--------------------------------

# Define input parameters
nutrients     <- 0.01
temperature   <- 0.005
humidity      <- 0.0036
starting_size <- 100
grow_time     <- 10

# Calculate total growth rate
growth_rate <- nutrients + temperature + humidity

# Calculate population size at the end of the time period
end_size <- starting_size * exp(growth_rate * grow_time)

# Return end population size in the console
end_size
#--------------------------------
```

#### Q25. Write  your own well annotated and fully functional script for calculating the volume of a rectangular room with the following dimensions:
length: 5m
width: 4m
height: 3m
The layout and design of the program are much more important than the calculations here!

## Regular Expressions (New stuff!)

Regular expressions are used to search for a specific pattern in a string. To understand them, we will take an example the actual in our data file are incorrect, or inconsistent. Run the following line of code to import the collections data frame:
```R
reptile_data <- read.table("http://wurmlab.github.io/teaching/2013sbc361/reptile_data.txt", row.names = 1)
```
This data frame details the genus and species names of 16 endangered reptiles, along with the date at which they were listed as endangered. You can load just the names into a separate variable by running the code
```
reptile_names <- row.names(reptile_data)
```

Have a close look at these names. Notice that each reptile has been given a unique identification number next to its name (don't look these numbers up - they don't mean anything)! Also, we can see that some names have been recorded incorrectly - the genus names for the *Liopholis* group have been recorded in lowercase, while we all know that genus names should be capitalized! All in all, this data appears quite "messy" and needs cleaning up.

The tools that allow us to deal with this sort of problem fall under the heading regular expressions. These consist of a suite of tools that allow us to search for, locate, and replace characters or words within a data set. The really powerful thing about regular expressions is that we can do a "fuzzy" search, meaning the pattern we are searching for has some flexibility built into it.

### Basic find and replace
First of all we will search through the vector reptile_names to find a list of the elements that contain the word "liopholis". The function that allows us to do this is `grep()`, which has two main arguments; `pattern` and `x`. The pattern is the actual word, or part of a word, that we are looking for. The argument x describes the variable that we are searching through. In our case we want to evaluate the following code:
```
# Search through reptile_names for the word "liopholis", and output positions
grep(pattern = "liopholis", x = reptile_names)
```

The output of this code is a list of numbers. Each of these numbers describes the position of an element in the vector `reptile_names` that matches the pattern - in this case the 12th and 13th elements. Make sure you fully understand where these numbers came from!

Sometimes it may be more useful to obtain the actual names within which the pattern was found, rather than a list of positions. We can do this by making use of the additional argument `value = T` (see the help file for the `grep()` function for a complete list of possible arguments). The new code reads:
```
# Search through reptile_names for the word "liopholis", and output names
grep(pattern = "liopholis", x = reptile_names, value = T)
```

Now we find that the output contains the actual elements of the vector that match the pattern, rather than just a list of positions. These names should correspond exactly with the positions found in the previous example.

Finally, we may want to find and replace the pattern. This can be done using the function `gsub()`. The function `gsub()` takes arguments `pattern` and `x`, just like the function `grep()`, but it also has an additional argument replacement. The argument replacement describes the new word, or words, that we want to insert in place of pattern. For example, in the `reptile_data` the word "liopholis" is a genus name, and so should be capitalized. Thus, we want to replace the word "liopholis" with "Liopholis", as follows:

```
# Search through reptile_names for the word "liopholis" and replace with the word "Liopholis."
reptile_names2 <- gsub(pattern = "liopholis", replacement = "Liopholis", x = reptile_names)
```

The output of this function is a new vector in which the desired replacement has been carried out. Notice that the code above stores this new vector in the variable reptile_names2.
Experiment with `grep()` and `gsub()` until you are confident at using them. Then answer the following questions:

#### Q26. How could you use regular expressions to find the only element in the vector `reptile_names` that contains a lowercase "q"? What is the position of this element in the vector?

#### Q27. You want to import the `reptile_names` data into excel, but are having problems due to the spaces between the words (a common problem). How could you use `gsub()` to replace all spaces with a period?

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
* in the slides for our course (from slide 45): http://www.slideshare.net/yannickwurm/2014924sbc361researchmethcomm
* by typing: ?regex in R

These special characters can be used on their own, or in combination with one another. To help you out with understanding these symbols, here are a few examples:

* The pattern `.r` means any character, followed by the letter "r" (e.g. "er", "or", "tr", "3r").
* The pattern `...r` means any character, followed by any character, followed by any character, followed by the letter "r" (e.g. "beer", "deer", "zekr").
* The pattern `l*at` means zero or more copies of the letter "l", followed by the letters "at" (e.g. "at", "lat", "llllllllllat").
* The pattern `s.+s` means the letter "s", followed by one or more copies of any character, followed by the letter "s" (e.g. "sas", "sts", "sauces", "serendipities", but NOT "ss").
* The pattern `.* .*` means zero or more copies of any character, followed by a space, followed by zero or more copies of any character (any combination of two words, e.g. "test word").
Some of these examples might seem very confusing at first, but if you learn what each special character means on its own and then go through the pattern one at a time you should find that it makes sense.

As an example of how fuzzy searching can be useful, we will now use these special characters to remove the ID tags from the reptile names. Notice that the ID numbers are of different lengths, but they are always separated with a colon from the part that we are interested in. Therefore, we can remove these characters by searching for zero or more copies of any character, followed by a colon, and replacing this pattern with an empty string. The single line of code that achieves this is as follows:
```
reptile_names3 <- gsub(pattern = ".*:", replacement = "", x = reptile_names2)
```
Have a look inside the variable reptile_names3. We have successfully isolated the genus and species names away from the pesky ID tags, even though the exact format of the tags may vary between different entries. Tricks like this can save us a great deal of time - especially when our data set is thousands of lines long. In fact, we have only skimmed the surface of what regular expressions can do - I encourage anyone who is interested to take a deeper look.

#### Q28. What does the pattern "..x.." mean in a regular expression?

#### Q29. What does the pattern "e+" mean in a regular expression?

#### Q30. How many reptile names (genus or species) contain a lowercase "o" or an uppercase "E"?
Hint - you will have to combine your knowledge of regular expressions with your knowledge of logical expressions to answer this one!

#### Q31. Add three additional columns to the `reptile_data` table:
* one containing only the identifier numbers (e.g. 1423 without the “ID”)
* one column containing only the genus (e.g. Bellatorias)
* one containing only the species (excluding the subspecies, e.g. tympanum)
Hint - try to decompose this task, the solution is not a “one-liner”. Make use of the functions you have just learnt and focus on extracting the numbers, genus, and species, rather than the “add new columns” bit.

#### Hacker Q32.  Figure out how to “capture” the first letter of the species, and transform it to make it uppercase. Do this in a generic manner (that would work on a table of thousands of species). 
Hint - look into the help page of “gsub”, especially the explanation for the “replacement” parameter, as well as the examples at the bottom of the help page.


# Extra section!

## Data input from files
Open source data plays an increasingly important role recently, so it is vital to know how to input the data with various formats into your program. Choosing the right way of importing data will save you time and boost your efficiency when cleaning the data. To test your abilities, download  [longevity_genes/longevity.csv](http://genomics.senescence.info/longevity/longevity_genes.zip) and [TableS2.xls](http://genomics.senescence.info/diet/TableS2.xls) and try loading them into R.
```
longevity_genes_data  <- read.csv("input location/longevity.csv")     
longevity_genes_data  <- read.csv(file.choose())                    # to choose the file
# try to figure out how to import Excel spreadsheets into R,
# which is an excessively discussed topic online. 
# One way of doing it, is saving your Excel spreadsheet (TableS2.xls) 
# as a tab delimited text file and loading it into R
read.delim("input location/file name.txt")
```

## Setting the working directory
Setting directory is a highly intensely used function which helps group your code and your data, and access to different paths. For example, if you want to save a series of graphs that were generated by accessing data outside the current folder in a loop, it saves you time by grouping data for you.
```
# set the working directory
setwd(“C:/Users/Public/Documents”)   # or use the equivalent menu options
# get all the file names in the current directory
list.files(path = ".")
# get the current working directory
getwd()
```

## Data output into various formats
Most of the time, as either a data recorder or a data analyst, knowing the best way to output data is important. The reason to export data into various formats is to make work easier when switching data analysis software (e.g. from R to Excel and back).
```
# write a new subsetted data frame (create this using your previous skills) into a CSV file
write.csv(your subsetted data frame, file = "output location/file name.csv")
# import your subsetted data frame into Excel
write.table(your subsetted data frame, file = "output location/file name.xls", sep = "\t")
# create three variables, a, b, and c of any class and save them into a .RData file (What is this? When could it be useful?)
save(a, b, c, file = "output location/file name.RData")
```
