# Q1. Make a new variable, z, out of the values in x and y. You can choose any formula you want for z,
# as long as it contains both x and y.

x <- 5
y <- 225
z <- x/y


# Q2. Let us define the variable x <- 10. What will the outcome of the following expressions be?
# (x > 5) is T
# (x <= 10) is T
# (x != 10) is F
# (x < 5) & (x < 105) is F
# (x < 4) | (x > 14) | (x == 10) is T


# Q4. Given three variables (x, y and z), how would you write the following sentence in a logical expression?
# The variable x is less than variable y, or is it greater than variable z?
x < y | x > z

# Q5. What number would you obtain if you typed seq_vec1[3] in the console? (try working this out for yourself
#                                                                            before typing it into R)

7


# Q6. What happens when you type seq_vec2[1:5] in the console an hit return?
0.00 0.25 0.50 0.75 1.00


# Q7. How would you retrieve just the 8th, 13th and 21st elements of seq_vec2?
seq_vec2[c(8, 13,21)]


# Q8. Try evaluating combined_vec2 <- numeric_vec*seq_vec2 in the console. What happens? Why?
It does not work, because the longer object length is not a multiple of shorter object length.


# Q9. What do you type to find the length of a vector?
length()


# Q10. In fact, compatible does not mean that vectors have to be exactly the same length.
# Try evaluating combined_vec3 <- numeric_vec*rep_vec in the console, and look at the result.
# What is the reasoning behind the values produced?
Since the longer object length is not a multiple of shorter object length,
it will pick up each element of the larger vector and multiply
for the shorter, repeatly.


# Q11. What happens when you evaluate rbind(numeric_vec, seq_vec1)?
# What happens when you evaluate cbind(numeric_vec, seq_vec1)? Why?
one is sorted by row and the other by column.


# Q12. When you evaluate rbind(numeric_vec, seq_vec2) you get a warning message. Why?
Since they have different length, R will follow the large one and repeat the shorter accordingly with a warning.


# Q13. What happens when you evaluate rbind(numeric_vec, rep_vec)? Why?
Since they are multiple, R will follow the larger one and repeat the shorter accordingly.


# Q14. How do you retrieve the 2 column of mat2?
mat2[, 2]


# Q15. The variable mat1 describes a matrix produced by the following code:

mat1 <- matrix(data = 1:50, nrow = 10, ncol = 5)

# What number would we expect to see when we evaluate mat1[1, 2] (try to answer this without evaluating the code!)?
# Why not a different number?
11- because R sorts by column.

#Q14:
Fourth

#Q15:
# sort by column is default, otherwise you need to tell R for sorting by row through "byrow".
vec1     <- 1:50
vec2     <- vec1^2
vec3     <- vec1^3
mymatrix <- matrix(c(vec1, vec2, vec3), nrow = 3, ncol = 50, byrow = T, dimnames = list(c("vec1","vec2","vec3"), c(1:50)))

# Q16. Which of these commands would output the 2nd and 4th columns of mat1 only
# (again, try answering this without evaluating the code!)?
mat1[, c(2, 4)]


# Q17. Write your own (fully annotated) program for creating a matrix from three separate vectors.
# The first vector, vec1, should be 50 elements long, and should simply contain the numbers 1 to 50.
# The second vector, vec2, should contain the square of these numbers (i.e. vec1 raised to the power 2).
# The third vector, vec3, should contain the cube of these numbers (i.e. vec1 raised to the power 3).
# Finally, create a matrix, my_matrix, which has vec1 as the first row, vec2 as the second row, and vec3 as the third row.
vec1 <- 1:50
vec2 <- vec1^2
vec3 <- vec1^3
my_matrix <- rbind(vec1, vec2, vec3)


# Q18. How would you subset the variable puromycin_data to return only those fields for which the concentration
# is greater than 0.1?
subset(puromycin_data, subset = conc > 0.1)


# Q19. What is the average (mean) concentration for these cells?
mean(subset(puromycin_data, subset = conc > 0.1))


# Q20. How would you subset the variable puromycin_data to return only the fields for which the cells were not treated?
subset(puromycin_data, subset = state == "untreated")


# Q21. How would you subset the variable puromycin_data to return only the fields for which the concentration
# is less than 0.5 and the rate is greater than 100 (remember the "and" command from logical expressions)?
subset(puromycin_data, subset = conc < 0.5 & rate > 100)


# Q22. How would you subset the variable puromycin_data to return only the fields for which the concentration
# is greater than 0.2 and the cells have been treated?
subset(puromycin_data, subset = conc > 0.2 & state == "treated")


# Q23. How would you subset the variable puromycin_data to return only the fields for which the concentration
# is less than 0.1 or greater than 0.2?
subset(puromycin_data, subset = conc < 0.1 | conc > 0.2)


# Q24. How would you subset the variable puromycin_data to return only the fields for which the concentration
# is less than 0.2 and the rate is less than 70 and the cells have been treated?
subset(puromycin_data, subset = conc < 0.2 & rate < 70 & state == 'treated')



# Q26. How could you use regular expressions to find the only element in the vector reptile_names that contains
# a lowercase "q"? What is the position of this element in the vector?
reptile_data  <- read.table("http://wurmlab.github.io/teaching/2013sbc361/reptile_data.txt", row.names = 1)
reptile_names <- row.names(reptile_data)
grep(pattern = "q", x = reptile_names)


# Q27. You want to import the reptile_names data into excel, but are having problems due to the spaces between
# the words (a common problem). How could you use gsub() to replace all spaces with a period?
gsub(pattern = " ", x = reptile_names, replacement = ".")


# Q28. What does the pattern "..x.." mean in a regular expression?
Any character followed by any character, followed by X and followed by other two any characters.


# Q29. What does the pattern "e+" mean in a regular expression?
Any character preceded by an e.


# Q30. How many reptile names (genus or species) contain a lowercase "o" or an uppercase "E"?
length(grep(pattern = "(o|E)", x = reptile_names))


### Q31. Add three additional columns to the reptile_data table:

## one containing only the identifier numbers (e.g. 1423 without the “ID”)

id_numbers <- gsub(pattern = "(ID)|(:.*)", x = reptile_names, replacement = "")

# It is better doing in a more generic manner. By doing this you will be  able to
# use your script on a different data frames, which may contain different characters,
# but the same structure.

id_numbers <- gsub(pattern = "([A-z])|(:.*)", x = reptile_names, replacement = "")

# you can also decompose the script in two strings, ex:

id_numbers_temp <- gsub(pattern = "ID", x = reptile_names, replacement = "")

id_numbers      <- gsub(pattern = "(:.*)", x = id_numbers_temp, replacement = "")


## one column containing only the genus (e.g. Bellatorias)

only_genus    <- gsub(pattern = "(.+:)|( .+)", x = reptile_names, replacement = "")

# Generic manner. Also more readable.
only_genus    <- gsub(pattern = "([A-z]+[0-9]+:)|(\\s[A-z]+)", x = reptile_names, replacement = "")

# the pattern  for the gsub() above means: any letter (upper or lowercase), that
# repeats once or more times, followed by any number, that repeats once or more times,
# followed by a collon; or space followed by any letter (upper or lowercase),
# that repeats one or more times.

# or splitting in two strings:

only_genus_temp <- gsub(pattern = "([A-z]+[0-9]+:)", x = reptile_names, replacement = "")

only_genus      <- gsub(pattern = "(\\s[A-z]+)", x = only_genus_temp, replacement = "")


## one containing only the species (excluding the subspecies, e.g. tympanum)

only_species_temp <- gsub(pattern = "(.*:)", replacement = "", x = reptile_names)

only_species      <- gsub(pattern = "(^[A-z]+ )|( [A-z]+$)", x = only_species_temp, replacement = "")

# the pattern  for the gsub() above means: any letter at the beginning of the string
# (upper or lowercase), that repeats one or more times, followed by space; or
# space followed by any letter (upper or lowercase), that repeats one or more times
# at the end of the string.

# or

only_species_temp <- gsub(pattern = "([A-z]+[0-9]+:)", replacement = "", x = reptile_names)

only_species      <- gsub(pattern = "(^[A-z]+\\s)|(\\s[A-z]+$)", x = only_species_temp, replacement = "")

# or combining in one line.

only_species <- gsub(pattern = "(^[A-z]+[0-9]+:)([A-z]+\\s)|(\\s[A-z]+$)", x = reptile_names, replacement = "")

# the pattern  for the gsub() above means: any letter at the beginning of the string
# (upper or lowercase), that repeats one or more times, followed by any number that repeats
# one or more times followed by collon, followed by any letter (upper or lowercase), that
# repeats one or more times followed by space; or
# space followed by any letter (upper or lowercase), that repeats one or more times
# at the end of the string.


## Now you can add the columns to the reptile_data data frame:
reptile_data2 <- cbind(reptile_data, id_numbers, only_genus, only_species)


## Hacker Q32. Figure out how to “capture” the first letter of the species, and transform it to make it uppercase.
## Do this in a generic manner (that would work on a table of thousands of species).

gsub("(\\w+)\\s+(\\w)(\\w*)", replacement = "\\1 \\U\\2\\L\\3", reptile_names, perl = TRUE)

# the pattern  for the gsub() above means: any character (letter or number)
# that repeats one or more times, followed by space that repeats one or more times,
# followed by any character (letter or number), followed by any character that repeats
# zero or more times.

# the replacement for the gsub() above means: keep the first group (anything between parenthesis)
# the way it is, keep the space, captilize the second group, and put the third group in lowercase.

gsub(pattern = "([\\w|:]+\\s)(\\w)(.*)", x = reptile_names, replacement = "\\1\\U\\2\\L\\3", perl=TRUE)

# or by using sub(), which matches only once.

sub("(\\w+)\\s+(\\w)", replacement = "\\1 \\U\\2", reptile_names, perl = TRUE)
# Since sub matches only once, you need to describe in the pattern only the first part
# (ID(number):Genus_space, and the first letter of the second word.
