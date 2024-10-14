---
layout: page
title: Programming in R
---


# Practical 0 - Introduction to basic data structures

October 2024

## Introduction

This practical series is aimed at teaching basic programming in R.  You may already be familiar with R from introductions to statistics, and so some of the material covered here should be fairly straightforward. However! The ultimate aim of these practicals differs from your previous work in that **the focus will be on creating, accessing, and manipulating data structures**. As this is often the first step in real scientific research, you will find that the skills you develop here will be invaluable to you later on in your studies!  It's also a general (though very simple) introduction to programming: the stuff we will be learning about exists in most other programming languages.

We will not be covering any stats in these practicals. However, do not relax too much, as these practicals will move fairly quickly, and you will need to stay focused in order to do well in the final exam. Make use of R’s help system (and [http://duckduckgo.com](http://duckduckgo.com), your neighbour, and if you're really stuck don't be afraid to ask a demonstrator.


## The environment

To start with, let us reacquaint ourselves with the R environment. First of all, launch R (or RStudio).

The main window you where you talk directly to R is called the **console**. This is where you run lines of code. Often, we prefer typing in a separate window in a separate file called a **script**. Try typing `1 + 2`` in this window and pressing return. Notice that no output is produced - the cursor just moves to the next line. This is because a script is fundamentally different from the console and in fact works just like any other **text editor**. In order to run the code that we have written in a script we need to select the line(s) that we want to run and hit Run, or type shift-enter or control-enter. This copies the selected line(s) over to the console and evaluates them in the order they are written. In this way we can create a long sequence of commands in a way that would not be possible by working directly in the console. Using a script also helps for keeping track of what we did. In general you should work mainly with scripts and limit your direct use of the console.

We strongly suggest that you write anything you want to keep in scripts and that you save these scripts somewhere. (Scripts are just text files; most people use up using other text editors, such as emacs, VS Code, TextWrangler, or they run R using RStudio; all these options make the code prettier and easier to read).

Also keep in mind that the R help is extremely good. Just put a question mark before any function that you do not understand (e.g. `?length`) to bring up the help file for that function. There are also many R websites and forums that you may find useful. The best way to learn any programming language is to fiddle - so please fiddle away with these tools to guide you!


## Variables
A variable is a symbolic way of storing a particular set of values and/or characters. For example, try typing

```R
x <- 5
y <- 225
```
into the console and hitting return. This assigns the number `5` to the symbol `x`. You can run operations on variables (e.g. `3*x^2`), create new variables from existing variables (e.g. `y <- 3*x^2`), and reassign existing variables to a new value (e.g.` x <- 3*x^2`; try running that a few times).

Please always use `<-` for assignment. When in doubt about how to write something, check the [tidyverse style guide](https://style.tidyverse.org); it provides standard guidelines which most R users do or should follow.

You can name variables almost anything you want. Try using descriptive names (avoiding `x` and `y`), and using "_" to separate words. As a rule of thumb, remember to make your code easily understandable for other people, including your future self.

Finally some variable names are not allowed. Typing `?make.names` in the console brings up a help file describing the important variable name restrictions.

#### Q1. Create a new variable, `z`, out of the values in `x` and `y`. You can choose any formula you want for `z`, as long as it contains both `x` and `y`.

## Data classes
There are several classes (or types) of data.  The class of your data tells you whether R interprets the data as numbers, letters, factors (i.e. categories), logical values or a number of alternatives. You can use the function `class()` to check the class of a variable.

You will probably have seen numeric (`x <- 5`) and character variables (`x <- "hello"`). An important class of data that you might not be familiar with is **logical data**. Simply put, logical data can only take one of two possible values: `TRUE` or `FALSE`. There are a number of different ways of arriving at a logical variable. The most obvious is to simply define a variable as true, for example:

```R
x <- TRUE
```

or false, for example

```R
x <- FALSE
```

Try creating a logical variable in this way and look at the class of the variable - if you have done it correctly it should read "logical" (keep in mind that R is case-sensitive, i.e. `x <- false` will throw an error).

However, this is not the way that logical variables tend to be used in programming. We often create logical variables through a particular type of calculation, called a **logical expression**. You can think of a logical expression as a statement (or a question) that we send to R, which may be a true statement, or it may be a lie! For example, try evaluating the code

```R
5 > 4
```

This statement is clearly true and accordingly R returns a value `TRUE`. The statement

```R
5 < 4
```
on the other hand, returns the value `FALSE`. We can assign this logical value to a variable by using the logical expression as input to the variable. This sounds complicated, but in practice it is very simple. Take the example

```R
x <- (5 > 4)
```

You can read the expression above as "the variable x is assigned the outcome of the logical expression 5 > 4". In this particular example the variable `x` will get the value `TRUE`. Notice that the logical expression itself is within parentheses. This is not strictly required, but is good coding practice as it avoids confusion between the assignment symbol and the logical expression.

The main logical operators that you should be familiar with are the following:

* `>` is greater than
* `<` is less than
* `>=` is greater than or equal to
* `<=` is less than or equal to
* `==` is equal to
* `!=` is not equal to

Play around with some of these operators in your own made-up logical expressions. Make sure you are comfortable assigning a logical value to a variable.

We can create more sophisticated logical expressions using the "and" command and the "or" command. The "and" command is written `&` and called ampersand (keyboard shortcut Shift+7), while the "or" command is written `|` and called a "pipe" or vertical bar (keyboard shortcut Shift+\ on a standard Windows keyboard). These "operators" can be placed between two or more logical expressions - exactly as you would do in a spoken sentence. For example, the expression

```R
(x > 5) & (x <= 10)
```
can be read "x is greater than five, and x is less than or equal to ten". Similarly, the expression

```R
(x < 6) | (x == 12)
```

can be read "x is less than six, or x is equal to twelve". By using a combination of these operators, while making good use of parentheses, it is possible to come up with some quite complex statements.


**A short note on classes:**

It's easy to get numeric and character data confused. For example, in `x <- "blue"`, `x` is of class "character", while in `x <- 4`, `x` is of class "numeric". The problem comes if you type:

```R
x <- "4"
```

In this case `x` is of class "character" because of the quotation marks. Try typing `class(x)` if you are confused. You can also type `is.numeric(x)` and `is.character(x)`.



#### Q2. Let us define the variable `x <- 10`. What will the outcome of the following expressions be?

* `(x > 5)`
* `(x <= 10)`
* `(x != 10)`
* `(x < 5) & (x < 105)`
* `(x < 4) | (x > 14) | (x == 10)`

#### Q3. Below are some of the rules that logical operators follow. Write in plain English what it means.

* `TRUE & TRUE` is `TRUE`
* `TRUE & FALSE` is `FALSE`
* `FALSE & TRUE` is `FALSE`
* `TRUE | FALSE` is `TRUE`
* `FALSE | TRUE` is `TRUE`

#### Q4. Given three variables (`x`, `y` and `z`), how would you write the following sentence in a logical expression?

*The variable `x` is less than variable `y`, or greater than variable `z`?*


## Types of Objects
### Scalars and vectors
Objects can be of different types. So far, we have looked at **scalar objects**, which contain a single variable (e.g. `x <- 3`). Another very common type of object is the **vector**, which is an object containing several elements:

```R
numeric_vec   <- c(1, 1, 2, 3, 5, 8)   # c is a function for combining values into a vector or list.
seq_vec2      <- seq(from = 0, to = 10, by = 0.25)
rep_vec       <- rep(x = 2, times = 12)
character_vec <- c("How", "Now", "Brown", "Cow")
logical_vec   <- c(TRUE, TRUE, FALSE, TRUE, TRUE, FALSE)
```

As you know by now, R is good at manipulating these vectors, with easy ways of accessing individual elements of a vector by using scalar objects as index (e.g. `x[3]`) and of applying simple operations on all elements of the vector (e.g. `vec1 * 3` or `vec1 * vec2` - *make sure you understand what R is doing here*). You can also use vectors to access a set of elements (e.g. `x[seq(from = 1, to = 5)]`) or specific elements (e.g. `x[c(2, 7, 9)]`) of a vector or variable. Remember that, for some calculations between different vectors, the vectors need to be compatible. This generally means they have lengths that are multiple of each other. Note that in R, the first position of a vector has the index 1, unlike in some other programming languages where the first position has the index 0.

#### Q5. What number would you obtain if you typed `seq_vec1[3]` in the console? (try working this out for yourself before typing it into R)

#### Q6. What happens when you type `seq_vec2[seq(from = 1, to = 5)]` in the console and hit return?

#### Q7. How would you retrieve just the 8th, 13th and 21st elements of `seq_vec2`?

Simple calculations can be performed on vectors, in which case the operation is applied to every element of the vector separately. For example, try typing

```R
numeric_vec_squared <- numeric_vec ^ 2
```

in the console. You will find that `numeric_vec_squared` contains values taken from `numeric_vec`, where each element has been squared individually. Similarly, you can create logical expressions that apply to the whole matrix, such as `numeric_vec > 3`

You can also perform operations involving several vectors, as long as the vectors have compatible lengths. For example, try typing

```R
combined_vec1 <- numeric_vec * seq_vec1
```

You will find that each of the elements of `combined_vec1` is equal to the product of the corresponding elements in `numeric_vec` and `seq_vec1`

#### Q8. Try evaluating `combined_vec2 <- numeric_vec * seq_vec2` in the console. What happens? Why?

#### Q9. What do you type to find the length of a vector?

#### Q10. In fact, compatible does not mean that vectors have to be exactly the same length. Try evaluating `combined_vec3 <- numeric_vec * rep_vec` in the console, and look at the result. What is the reasoning behind the values produced?

### Matrices
Another major type of object in R is the **matrix**. A matrix is simply a rectangular grid of values. One of the simplest ways of producing a matrix is by combining several vectors through the functions `rbind()` and `cbind()`. Try `rbind(numeric_vec, seq_vec1)`.

#### Q11. What happens when you evaluate `rbind(numeric_vec, seq_vec1)`? What happens when you evaluate `cbind(numeric_vec, seq_vec1)`? Why?
#### Q12. When you evaluate `rbind(numeric_vec, seq_vec2)` you get a warning message. Why?
#### Q13. What happens when you evaluate `rbind(numeric_vec, rep_vec)`? Why?

You can also create matrices directly in a number of different ways:

```R
matrix1 <- matrix(data = seq_len(length.out = 24), nrow = 6, ncol = 4)
matrix2 <- matrix(data = seq_len(length.out = 24), nrow = 6, ncol = 4, byrow = TRUE)
matrix3 <- diag(x = 5, nrow = 3, ncol = 2)
matrix4 <- outer(x = seq(from = 1, to = 5), y = seq(from = 4, to = 8))
matrix5 <- matrix(data = "Hello World", nrow = 2, ncol = 5)
```

As with vectors, you can get to the elements of a matrix using square brackets, but with a two-dimensional index, one for rows and another one for columns! For example:

 * `matrix1[4, 3]`
 * `matrix1[seq_len(length.out = 2), seq_len(length.out = 2)]`
 * `matrix1[seq_len(length.out = 2), ]`

#### Q14. How do you retrieve the 2nd column of `matrix2`?

You can perform simple calculations on matrices, in which case the calculation applies to each element separately:

```R
(matrix3 + 2) * 2
```
You can also combine the values in several matrices, as long as the dimensions of the matrices are compatible

```R
(matrix3 * 100) + mat4
```

Finally, you can create logical expressions that apply to an entire matrix. For example, try evaluating:

```R
(matrix1 > 10)
```

There are a number of useful functions that can be applied to matrices. Have a look at each of the following functions, and try to make sense of the output:

* `length()`
* `dim()`
* `t()`
* `colSums()`
* `summary()`

Keep in mind that if you ever need help in understanding a function, just bring up the help file for that function.

#### Q15. The variable `matrix1` describes a matrix produced by the following code:

```R
matrix1 <- matrix(data = seq_len(length.out = 50), nrow = 10, ncol = 5)
```

What number would we expect to see when we evaluate `matrix1[1, 2]`? Try to answer this without evaluating the code! Why not a different number?

#### Q16. Which of these commands would output the 2nd and 4th columns of matrix1 only (again, try answering this without evaluating the code!)?

```R
matrix1[2, 4]
matrix1(, (2, 4))
matrix1[c(2, 4), ]
matrix1[, c(2, 4)]
```
** Note that in most situations, we try to avoid using this type of column indication. This is because it is easy to make a mistake with the numbers. Instead, it is easier and less risky to use column names **

#### Q17. Write your own script for creating a matrix from three separate vectors. The first vector, `vec1`, should be 50 elements long, and should simply contain the numbers 1 to 50. The second vector, `vec2`, should contain the square of these numbers (i.e. `vec1` raised to the power 2). The third vector, `vec3`, should contain the cube of these numbers (i.e. `vec1` raised to the power 3). Finally, create a matrix, `my_matrix`, which has `vec1` as the first row, `vec2` as the second row, and `vec3` as the third row.

### Data frame
A very common type of object is the **data frame**. On the face of it, these look very similar to matrices. However, there are some important differences between data frames and matrices. The most important difference is that, in a matrix, all the elements need to be of the same class, while in a data frame, different classes are allowed. Several data frames are  loaded into R by default (e.g., `Puromycin`). Check the help to understand what this data includes: `?Puromycin`.

R allows you to get to specific columns using their name and the dollar sign: `Puromycin$rate`.  (it is also possible to use indices like in matrices, for example`Puromycin[1, 1]` or `Puromycin[, 2]`. But using indices is risky and should thus be avoided).

Note that, although the data frame is of class data frame, typing `Puromycin$rate` will return a vector of class numeric (try using the function `class()` to check this).

Normally, when R encounters columns with words in a data frame (rather than numbers), it automatically interprets them as data of a different type, the **factor** (this is true for R version 3, R version 4 interprets columns with words as data type **character**). This allows us to work with categorical data, by organising the data into discrete categories, known as levels (e.g., red, yellow and blue could be the levels of a column called ‘colour’). Type the following for an example:

```R
Puromycin$rate
class(Puromycin$rate)
class(Puromycin$state)
levels(Puromycin$state)
as.character(Puromycin$state)
```

### Lists
The last data type that is commonly seen in R is the **list**. A list is a bit like a complicated vector, where the elements can be objects of any type. For example, we can make a list of vectors:

```R
my_list <- list(a = c(1, 2, 3), b = c(5, 6, 7, 8, 9, 10), d = c('G', 'H'))
```

Again, we can access elements from the list using their index, with brackets `my_list[[1]]`, *but you should NOT do this!*. Instead, use the names whenever possible, either using the bracket notation (`my_list[['a']]`) or the dollar sign (`my_list$a`). Lists can get very complex, since there is no limits on the data type of the elements. Therefore, you can get lists of vectors, lists of lists, lists of vectors and lists, etc…

There are other types of data in R, with many being specific to particular libraries.

## Subsetting a data frame
We have already come across one way of subsetting through the use of square brackets. By typing, for example,

```R
Puromycin
Puromycin[c(1, 2, 3), ]  # this is acceptable
Puromycin[, 2]           # never do this: use the column's name instead
```
we can isolate certain rows of the data frame that we are interested in. Using numbers to access specific rows is ok, but we should never do this with columns. Instead, we can use `subset` (see below) or the dollar sign `$` to get a specific column:

```R
Puromycin$rate
```

We can isolate data easily by using the logical statements mentioned above. For example, we can check which rows have a rate that is less than 100:

```R
# returns TRUE or FALSE
Puromycin$rate < 100
# returns which elements are TRUE
which(Puromycin$rate < 100)
```

We can use the subset function to select the rows for which the statement is TRUE:

```R
# returns all the columns, but only the rows for which
# Puromycin$rate < 100 is TRUE
puromycin_sub <- subset(Puromycin, rate < 100)
```

We could subset by the "state" column:

```R
puromycin_treated <- subset(Puromycin, subset = state == "treated")
```

This will return all fields for which the state is equal to "treated". Notice that the factor must be written in quotation marks here, as R needs to know that it is looking for a particular set of characters, rather than a variable.

#### Q18. How would you subset the variable `Puromycin` to return only those fields for which the concentration is greater than 0.1?
#### Q19. What is the average (mean) concentration for these cells?
#### Q20. How would you subset the variable `Puromycin` to return only the fields for which the cells were not treated?
#### Q21. How would you subset the variable `Puromycin` to return only the fields for which the concentration is less than 0.5 and the rate is greater than 100 (remember the "and" command from logical expressions)?
#### Q22. How would you subset the variable `Puromycin` to return only the fields for which the concentration is greater than 0.2 and the cells have been treated?
#### Q23. How would you subset the variable `Puromycin` to return only the fields for which the concentration is less than 0.1 or greater than 0.2?
#### Q24. How would you subset the variable `Puromycin` to return only the fields for which the concentration is less than 0.2 and the rate is less than 70 and the cells have been treated?


## Good coding practice
Keep your code clean and tidy by making use of comments and white space and respecting the style guide.  Comments start with the character # (R simply does not interpret anything written between a comment sign and the end of the line. They  allow you to annotate your code, i.e. to write helpful notes in between all the raw program code. Notice also that white space such as empty lines, spaces and indentations (obtained by pressing the Tab key) are invisible to R. Making good use of white space helps keep your code readable, and so does using clear and descriptive variable names.

The following two examples make this point clear. Both programs do exactly the same thing, but one will make sense one year from now, and the other will not!

### Example 1
```R
boooom <-0.01
blah2          =0.005
    blah3<- 0.0036
bigblah                           = boooom+ blah2        + blah3
tadayeahmanfunky<-100*exp(bigblah*10)
tadayeahmanfunky
```

### Example 2

```R
#--------------------------------
# Program:     population_size.R
# Author:      Bob Verity
# Date:        2021-10-01
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

* length: 5m
* width: 4m
* height: 3m

The layout and design of the program are much more important than the calculations here!
