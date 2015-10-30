# Computing in R - Practical 3

SBC361: Research Methods and Communication

October 2015

## Introduction

This session will be divided into two halves. For the first 90 minutes, we will continue to practice and recap the skills learned in the first two sessions. The second half of this session will be the exam. You are encouraged to use your notes from the earlier sessions, the internet and the R help sheets during the practice half of the session and are also allowed to make use of them during the exam - though note that you are not allowed to use chat or forums to ask questions on the internet during the exam. You will be provided with the link to the exam when it is time to move on to it. The exam will need to be sat on one of the university PCs; it is recommended that you do this practice session on the same computer so that you can get used to the particular R interface.

## Recap questions
To get back into gear in terms of thinking about programming, we’ll start with a quick recap exercise of the material from last week:

#### Intro Q1. Write a `for` loop that calculates the sum of 1/13 + 1/14 + 1/15… all the way up to 1/32. Note that R will not create the correct vector if you tell it ‘1/13:1/32’!

*It is possible to get the answer to this exercise without writing a loop, by using `sum()`. However, the idea of this exercise is to practice writing `for` loops - so write a `for` loop.*

#### Intro Q2. Create a function that can run this loop between any two denominators (so from `1/x` to `1/y`, where `x` and `y` are inputs to the function).

## Palindromic Sequences

Palindromes are arrangements of words or letters which read the same way whether you read them backwards or forwards, such as the phrase ‘Never odd or even’. In molecular biology, many restriction enzyme sites are palindromic.

#### Q1. Write a function that assesses whether a given word or phrase is a palindrome.
Before starting to code, think about the steps that you would need to go through in order to judge if something is a palindrome or not. Write these steps as comments in an R script window, then think about how you can tell the computer to execute those steps. Only start writing the code when you have a plan of what you want to do. Don’t be afraid to test lines independently in the console and to use easy test cases where you know the answer in order to check that your function works.

The bottom section of the R help sheets normally have examples of how a command can be used. Sometimes one of these examples will be a way to solve the problem that you are currently working on. The `strsplit` helpsheet is particularly interesting in relation to this question.

#### Q2. Write a function that assesses whether a DNA sequence is palindrome. You will need to convert it to its reverse complement and then compare this to the original sequence. Again, there are commands which may help you in the ‘Working with DNA data’ section from the last session.

Palindromes in molecular biology work a little differently, in that the sequence is the same if read 5’ to 3’ on one strand or 5’ to 3’ on the complementary strand. For example, ACCTAGGT is a palindromic DNA sequence as its complement is TGGATCCA.

## Open Reading Frames
Protein-coding regions in the genome can be predicted by detecting open reading frames. An open reading frame normally begins with the start codon ‘ATG’ and ends at one of three possible stop codons, ‘TGA’, ‘TAA’ and ‘TAG’. The sequence in between these two points is arranged in 3-base codons.

#### Q3. Write a function which uses regular expressions to detect if a given sequence contains an open reading frame (ORF). Test it on the following sequences:

```
ATGGATTTTTAG
ATGGATTTTCTAG
CTAATGGATTTTTGAAT
atgctaaactaa
```

#### Q4. (hacker question). Instead of having the function return whether your sequence contains an open reading frame, have the function return a string containing the open reading frame if there is one and NULL if there is not (you will need to look up "if statements").

## Species names
Run the following line of code to import the `butterfly_sample` and the `butterfly_reference` data frames:

```R
butterfly_sam_url <- "http://wurmlab.github.io/SBC361-programming-in-R/ButterflySample.csv"
butterfly_sample  <- read.csv(butterfly_sam_url, header = T)

butterfly_ref_url   <- "http://wurmlab.github.io/SBC361-programming-in-R/ButterflyReference.csv"
butterfly_reference <- read.csv(butterfly_ref_url, header = T)
```

The `butterfly_reference` data frame contains the species name and the common name of a number of butterflies.

The `butterfly_sample` data frame contains information on butterflies caught in sweep netting surveys in two locations (A and B). This data was collected by multiple people, and they have not recorded the species that they encountered the same way - some have used latin names for species and others common names, for example. In order to be able to compare the diversity between the two different sites, you will need to standardise the names.

#### Q30 Write a function that adds a new column in the data frame that contains the correct Latin species name for each record in the data frame imported below.

TIP: There are several ways to do this. Remember that R is case sensitive, so you will need to account for case differences in your function. `grep` and `gsub` both allow you to set an `ignore.case = T` option. Alternately, you could use the R commands `toupper()` and `tolower()`. Use the help pages to see how these work, which you can access by typing a question mark before the command - `?toupper`.


#### Q31. From the data above, which location has the greatest number of different species?

#### Q32. Which genus has been caught the greatest number of times?

## Exam Reminders

* You will have to sit the exam on one of the university PCs.
* You will submit your answers through a Google form. Please do not use Internet Explorer for this. The form does not save as you fill in your answers, so please also save them in a text document or with screenshots so that you do not lose them if something goes wrong.
* Do not click ‘submit’ until you have filled in all of your answers on the form.
* You will need to have your student ID number and your college email address to hand to access all the exam content and to fill in the Google form.
* You are allowed to use the internet and your class notes during the exam, but you are not allowed to use chat or forums to ask for answers and you are not allowed to copy off one another.
