---
layout: page
title: Introduction to Regular Expressions in R
---

# Introduction to Regular Expressions in R

## Regular Expressions

Regular expressions are used to search for a specific pattern in a string. To understand them, we will take an example in which the actual names in our data file are incorrect, or inconsistent. Run the following line of code to import the a table into a data frame:

```R
reptiles <- read.table(file = "http://wurmlab.com/teaching/programming_in_r/reptiles.txt")
```

This data frame details the genus and species names of 16 endangered reptiles, along with the dates at which they were listed as endangered. You can load just the names into a separate variable by running the code

```R
names_ids <- row.names(reptiles)
```

Have a close look at these names. Notice that each reptile has a unique identification number next to its name (don't look these numbers up - they don't mean anything)! Also, we can see that some names were recorded incorrectly - the genus names for the *Liopholis* group are in lowercase, while we all know that genus names should be capitalized! All in all, this data appears quite "messy" and needs cleaning up.

**Regular expressions** are ideal for fixing this. "Regex" are at the center of a suite of tools that allow us to search for, locate, and replace characters or words within a data set. The really powerful thing about regular expressions is that we can do a "fuzzy" search, meaning the pattern we are searching for has some flexibility built into it.

### Basic find and replace

First of all we will search through the vector `names_ids` to find a list of the elements that contain the word "liopholis". The function that allows us to do this is `grep()`, which has two main arguments; `pattern` and `x`. The pattern is the actual word, or part of a word, that we are looking for. The argument `x`` describes the variable that we are searching through. In our case we want to evaluate the following code:

```R
# Search through names_ids for the word "liopholis", and output_positions
grep(pattern = "liopholis", x = names_ids)
```

The output of this code is a list of numbers. Each of these numbers describes the position of an element in the vector `names_ids` that matches the pattern - in this case the 12th and 13th elements. Make sure you fully understand where these numbers came from!

Sometimes it may be more useful to obtain the actual names within which the pattern was found, rather than a list of positions. We can do this by making use of the additional argument `value = TRUE` (see the help file for the `grep()` function for a complete list of possible arguments). The new code reads:

```R
# Search through names_ids for the word "liopholis", and output_names
grep(pattern = "liopholis", x = names_ids, value = TRUE)
```

Now we find that the output contains the actual elements of the vector that match the pattern, rather than just a list of positions. These names correspond exactly with the positions found in the previous example.

Finally, we may want to find and replace the pattern. This can be done using the function `gsub()`. The function `gsub()` takes arguments `pattern` and `x`, just like the function `grep()`, but it also has an additional argument `replacement`. The argument `replacement` describes the new word, or words, that we want to insert in place of pattern. For example, in the `reptiles` the word "liopholis" is a genus name, and so should be capitalized. Thus, we want to replace the word "liopholis" with "Liopholis", as follows:

```R
# Search through names_ids for the word "liopholis" and replace with the word "Liopholis".
names_ids_fixed <- gsub(pattern = "liopholis", replacement = "Liopholis", x = names_ids)
```

The output of this function is a new vector in which the desired replacement has been carried out. Notice that the code above stores this new vector in the variable `names_ids_fixed`.

Experiment with `grep()` and `gsub()` until you are confident at using them. Then answer the following questions:

#### Q1. How could you use regular expressions to find the only element in the vector `names_ids_fixed` that contains a lowercase "q"? What is the position of this element in the vector?

#### Q2. You want to import the `names_ids_fixed` data into excel, but are having problems due to the spaces between the words (a common problem). How could you use `gsub()` to replace each space with an underscore `_` `_`?

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

* by Googling (e.g. "Regexp cheat sheet for R")
* by typing: ?regex in R

These special characters can be used on their own, or in combination with one another. To help you out with understanding these symbols, here are a few examples:

* The pattern `.r` means any character, followed by the letter "r" (e.g. "er", "or", "tr", "3r").
* The pattern `...r` means any character, followed by any character, followed by any character, followed by the letter "r" (e.g. "beer", "deer", "zekr").
* The pattern `l*at` means zero or more copies of the letter "l", followed by the letters "at" (e.g. "at", "lat", "llllllllllat").
* The pattern `s.+s` means the letter "s", followed by one or more copies of any character, followed by the letter "s" (e.g. "sas", "sts", "sauces", "serendipities", but NOT "ss").
* The pattern `.* .*` means zero or more copies of any character, followed by a space, followed by zero or more copies of any character (any combination of two words, e.g. "test word").

Some of these examples might seem very confusing at first, but if you learn what each special character means on its own and then go through the pattern one at a time you should find that it makes sense.

As an example of how fuzzy searching can be useful, we will now use these special characters to remove the ID tags from the reptile names. Notice that the ID numbers are of different lengths, but they are always separated with a colon from the part that we are interested in. Therefore, we can remove these characters by searching for zero or more copies of any character, followed by a colon, and replacing this pattern with an empty string. The single line of code that achieves this is as follows:

```R
names <- gsub(pattern = ".*:", replacement = "", x = names_ids_fixed)
```
Have a look inside the variable `names`. We have successfully isolated the genus and species names away from the pesky ID tags, even though the exact format of the tags may vary between different entries. Tricks like this can save us a great deal of time - especially when our data set is thousands of lines long. In fact, we have only skimmed the surface of what regular expressions can do - I encourage anyone who is interested to take a deeper look.

#### Q3. What does the pattern "..x.." mean in a regular expression?

#### Q4. What does the pattern "e+" mean in a regular expression?

#### Q5a. How many reptile names in `names` contain a lowercase "o" or an uppercase "E"?

Hint - you should be able to identify the words containing these patterns using a single `grep` command. We have learnt how to search for a choice of two or more characters in class.

#### Q5b. How many reptile names in `names` contain "us" or "li"?

Hint - As before, use a single `grep` command to identify the words with these patterns.

#### Q6. Add three additional columns to the `reptiles` table:
* one containing only the identifier numbers (e.g. 1423 without the “ID”)
* one column containing only the genus (e.g. "Bellatorias")
* one containing only the species (excluding the genus name and the subspecies name, e.g. we want to read "tympanum")

Hint - try to decompose this task, the solution is not a “one-liner”. Make use of the functions you have just learnt and focus on extracting the numbers, genus, and species, rather than the “add new columns” bit.


# Extra section!

## Data input from files
Open source data plays an increasingly important role recently, so it is vital to know how to input the data with various formats into your program. Choosing the right way of importing data will save you time and boost your efficiency when cleaning the data. To test your abilities, download  [longevity_genes/longevity.csv](https://genomics.senescence.info/longevity/longevity_genes.zip) and [TableS2.xls](https://genomics.senescence.info/diet/TableS2.xls) and try loading them into R.

```R
longevity_genes_data  <- read.csv("input location/longevity.csv")
longevity_genes_data  <- read.csv(file.choose())                    # to choose the file
# try to figure out how to import Excel spreadsheets into R,
# which is an excessively discussed topic online.
# One way of doing it, is saving your Excel spreadsheet (TableS2.xls)
# as a tab delimited text file and loading it into R
read.delim("input location/file name.txt")
```

## Data output into various formats
Most of the time, as either a data recorder or a data analyst, knowing the best way to output data is important. Outputting data as a CSV file is recommended as it's compatible with both Excel and R.

```R
# write a new subsetted data frame (create this using your previous skills) into a CSV file
write.csv(your_subsetted_data_frame, file = "output_location/file_name.csv")
# create three variables, a, b, and c of any class and save them into a .RData file (What is this? When could it be useful?)
save(a, b, c, file = "output_location/file_name.RData")
```

#### Hacker Q7.  Download [this text file](http://wurmlab.com/teaching/programming_in_r/reptiles_lower.txt) and figure out how to “capture” the first letter of the genus, and transform it to make it uppercase. Do this in a generic manner (that would work on a table of thousands of species).
Hint - look into the help page of “gsub”, especially the explanation for the “replacement” parameter, as well as the examples at the bottom of the help page.
