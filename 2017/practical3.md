# Computing in R - Practical 3

BIO309: Research Methods and Communication II

October 2017

## Introduction

This session will be a recap of what we saw in [practical1](https://wurmlab.github.io/SBC361-programming-in-R/practical1.html) and [practical2](https://wurmlab.github.io/SBC361-programming-in-R/practical2.html). You can also use this session to revisit the parts of the last practicals that are still not entirely clear.
**REMEMBER** The important thing for the exam is that you understand what you are doing. It is better to understand well a few exercises than finishing all exercises without entirely knowing what is going on.

## Recap questions
To get back into gear in terms of thinking about programming, we’ll start with a quick recap exercise of the material from the last weeks:

#### Intro Q1. What would be the outcome of the code `answer <- rep(x = c(42, 24), times = 42)`? And what would then be the outcome of the code `mean(answer)`?

#### Intro Q2. Use the preloaded R data set 'Indometh'. Subset this data to return only those rows for which the concentration is strictly between 1 and 2. What is the average (mean) concentration for this subset?

#### Intro Q3. Using regular expressions, how would you extract all the words except `antilope` in the vector `c("cameleopard", "eop4a", "kiloparsec", "antilope")`? In R, there are a few ways of getting a result. Find three ways to answer this question.

#### Intro Q4. Write a loop that iterates over the numbers 10 to 100 and stores this number in a separate vector. Can you explain the sequence of events that the computer goes through during, say, the 20th iteration?

#### Intro Q5-A. Write a loop that iterates over the numbers 16 to 49 and prints out the square root of the number each time through (you may have to search around for the square root function). Yes we *absolutely* want you to write a loop to do this.

#### Intro Q5-B. Make the loop from Intro Q5-A store the results to a separate vector called `my_square_roots` instead of just printing the results. What's the value of the 3rd iteration? What is the sum of the square roots of the numbers 16 to 49?

#### Intro Q6. Write a loop that iterates over all even numbers between 30 and 90. At each iteration, run your function to convert each of these even numbers from kilometres into miles (you created this function in Q2 from [practical2](https://wurmlab.github.io/SBC361-programming-in-R/practical2.html)). The loop should store the results in a separate vector.

#### Intro Q7. Numbers in Fibonacci's sequence are characterised by the fact that every number after the first two is the sum of the two preceding ones (e.g., 1, 1, 2, 3, 5,...). This seemingly simple sequence can be used to explain different biological patterns ranging from the arrangement of leaves on a stem or the flowering of an artichoke to the patterns of inheritance of X chromosomes. Write a `for` loop that calculates the first 20 numbers in a Fibonacci sequence strating from 1.

*Hint - we cannot use positions equal or lower than 0 in a vector. Start with a vector containing the 2 first numbers of the sequence (1 and 1 in this case) and run through a loop starting in position 3 of your sequence to calculate the rest*

#### Intro Q8. Create a function that can run this loop to generate a Fibonacci sequence of any size, starting from any given number. So for example, a sequence of length `x` from number `y`, where `x` and `y` are inputs to the function.

## Palindromic Sequences

Palindromes are arrangements of words or letters which read the same way whether you read them backwards or forwards, such as the phrase ‘Never odd or even’. In molecular biology, many restriction enzyme sites are palindromic.

#### Q1. Write a function that assesses whether a given word or phrase is a palindrome.
Before starting to code, think about the steps that you would need to go through in order to judge if something is a palindrome or not. Write these steps as comments in an R script window, then think about how you can tell the computer to execute those steps. Only start writing the code when you have a plan of what you want to do. Don’t be afraid to test lines independently in the console and to use easy test cases where you know the answer in order to check that your function works.

The bottom section of the R help sheets normally have examples of how a command can be used. Sometimes one of these examples will be a way to solve the problem that you are currently working on. The `strsplit` helpsheet is particularly interesting in relation to this question.

#### Q2. Palindromes in molecular biology work a little differently, in that the sequence is the same if read from 5’ to 3’ on one strand or from 5’ to 3’ on the complementary strand. For example, given the sequence ACCTAGGT, its complement would be:
```
5’ ACCTAGGT 3’
   ||||||||
3’ TGGATCCA 5’
```
#### Both ACCTAGGT and its complementary sequence TGGATCCA are identical if read from 5’ to 3’, that is, ACCTAGGT is a palindromic sequence. Write a function that assesses whether a DNA sequence is a palindrome. You will need to convert it to its reverse complement and then compare this to the original sequence. Again, there are commands which may help you in the ‘Working with DNA data’ section from the [last session](https://wurmlab.github.io/SBC361-programming-in-R/practical2.html).

## Open Reading Frames
Protein-coding regions in the genome can be predicted by detecting open reading frames. An open reading frame normally begins with the start codon ‘ATG’ and ends at one of three possible stop codons, ‘TGA’, ‘TAA’ and ‘TAG’. The sequence in between these two points is arranged in 3-base codons.

#### Q3. Write a function which uses regular expressions to detect if a given sequence contains an open reading frame. Test it on the following sequences:

*Hint - an open reading frame should always start with the start codon 'ATG' and end with one of the stop codons. Additionally, the length of the entire sequence should be a multiple of 3. If any of these features are not met, the sequence is not a functional open reading frame.*

```
ATGGATTTTTAG
ATGGATTTTCTAG
CTAATGGATTTTTGAAT
atgctaaactaa
TCGATTAA
```

#### Hacker Q4a. Instead of having the function return whether your sequence contains an open reading frame, have the function return a string containing the open reading frame if there is one and NULL if there is not (you will need to look up "if statements").

#### Hacker Q4b. This time, check both the forward and reverse strand for open reading frames. Return `"forward_only"` if there is an open reading frame only on the forward strand, `"reverse_only"` if only on the reverse, `"both"` if in both or "none" if in neither.

## Species names
Run the following line of code to import the `butterfly_sample` and the `butterfly_reference` data frames:

```R
butterfly_sam_url <- "http://wurmlab.github.io/SBC361-programming-in-R/butterfly_sample.csv"
butterfly_sample  <- read.csv(butterfly_sam_url, header = TRUE)

butterfly_ref_url   <- "http://wurmlab.github.io/SBC361-programming-in-R/butterfly_reference.csv"
butterfly_reference <- read.csv(butterfly_ref_url, header = TRUE)
```

The `butterfly_reference` data frame contains the species name and the common name of a number of butterflies.

The `butterfly_sample` data frame contains information on butterflies caught in sweep netting surveys in two locations under different pesticide treatments (locations A and B). This data was collected by multiple people, who have recorded the common names of the species that they encountered (without using a standard letter case). In order to be able to compare the diversity between the two different sites, you will need to standardise the names.

#### Q5 Write a function that adds a new column in the data frame that contains the correct Latin species name for each record in the `butterfly_sample`.

TIP: There are several ways to do this. Remember that R is case sensitive, so you will need to account for case differences in your function. `grep` and `gsub` both allow you to set an `ignore.case = TRUE` option. Alternately, you could use the R commands `toupper()` and `tolower()`. Use the help pages to see how these work, which you can access by typing a question mark before the command - `?toupper`.

#### Q6. From the data above, which location has the greatest number of different species?

#### Q7. Which genus has been caught the greatest number of times?

# Bonus hacker question

This question is an extension of the question Q5. Again, we will analyse a data frame containing the species of butterflies observed in two locations (A and B). This time, however, some of the people who did the sampling recorded the common name of the species, while others recorded the latin name (all with inconsistent letter case).

#### Q8 Write a script that adds a new column in the data frame that contains the correct Latin species name for each record in the data frame imported below.

```R
butterfly_sam_bonus_url <- "http://wurmlab.github.io/SBC361-programming-in-R/butterfly_sample_bonus.csv"
butterfly_sample_bonus  <- read.csv(butterfly_sam_url, header = TRUE)
```

One of the difficulties of this exercise is that you will have to perform a different process depending on whether the sample already has its Latin name or not. You may find that using `if` statements may be helpful (which you will have to look up). Alternatively, you may want to subset the data into the two groups (where the transformation is either from Latin to Latin or common to Latin), and do the transformation independently on each.

This question is not easy! But it is typical of the sort of thing researchers do from day to day and a very good test of all the things you have learned this year!
