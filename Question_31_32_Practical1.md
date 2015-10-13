What follow are some ideas of how to answer those last few questions the first practical session. Remember that there are dozens of manners of answering a question, and no single one is best. Other ideas that we may not have listed are perfectly valid as well!


## Q31. Add three additional columns to the reptile_data table:

First let's create one vector for each; we can worry about combining them into the `reptile_data` table later. 

### one containing only the identifier numbers (e.g. 1423 without the “ID”)

#### it might be easiest to do this in two steps. For example: 

```
id_numbers_temp <- gsub(x = reptile_names, pattern = "ID", replacement = "")
id_numbers      <- gsub(x = id_numbers_temp, pattern = ":.*", replacement = "")
rm(id_numbers_temp)
```

This can be a bit risky though. For example, what happens if the species name contains "ID", or if there are multiple ":"? Thus it is better to be more specific. You will be more in control of what the computer is doing, and thus it is less likely to make a mistake. For example:

```
id_numbers_temp <- gsub(x = reptile_names, pattern = "^ID", replacement = "")
id_numbers      <- gsub(x = id_numbers_temp, pattern = ":[A-z ]+$", replacement = "")
rm(id_numbers_temp)
```

If we want our regexp to be more general (e.g. if "ID" might be other capitalized letters, and if some species may be unresolved and thus be abbreviated as "sp."), we could for example do the following:
```
id_numbers_temp <- gsub(x = reptile_names, pattern = "^[A-Z]+", replacement = "")
id_numbers      <- gsub(x = id_numbers_temp, pattern = ":[A-z \.]+$", replacement = "")
rm(id_numbers_temp)
```

#### Or we can combine those two into a single line: 

`gsub` can "find" a regular expression match multiple times. So we can combine two with a `|`. Here are some alternative options.

Risky but works: 
```
id_numbers <- gsub(x = reptile_names, pattern = "([A-Z]*)|(:.*)", replacement = "")
```

Less risky:
```
id_numbers <- gsub(x = reptile_names, pattern = "(^[A-z]+)|(:[A-z \.]+)", replacement = "")
```

Specific for this dataset:
```
id_numbers <- gsub(x = reptile_names, pattern = "(^ID)|(:[A-z ]+)", replacement = "")
```

#### Or we take a minimalistic approach by exclusion of everything that is not a number

```
id_numbers <- gsub(x = reptile_names, replacement = "", pattern = "[^0-9]")
```

### one column containing only the genus (e.g. Bellatorias)

```
only_genus    <- gsub(pattern = "(.+:)|( .+)", x = reptile_names, replacement = "")
```

#### Generic manner. Also more readable.
```
only_genus    <- gsub(pattern = "([A-z]+[0-9]+:)|(\\s[A-z]+)", x = reptile_names, replacement = "")
```

The pattern  for the gsub() above means: any letter (upper or lowercase), that
repeats once or more times, followed by any number, that repeats once or more times,
followed by a collon; or space followed by any letter (upper or lowercase),
that repeats one or more times.

#### or splitting in two strings:
```
only_genus_temp <- gsub(pattern = "([A-z]+[0-9]+:)", x = reptile_names, replacement = "")

only_genus      <- gsub(pattern = "(\\s[A-z]+)", x = only_genus_temp, replacement = "")
```

### one containing only the species (excluding the subspecies, e.g. tympanum)
```
only_species_temp <- gsub(pattern = "(.*:)", replacement = "", x = reptile_names)

only_species      <- gsub(pattern = "(^[A-z]+ )|( [A-z]+$)", x = only_species_temp, replacement = "")
```
The pattern  for the gsub() above means: any letter at the beginning of the string
(upper or lowercase), that repeats one or more times, followed by space; or
space followed by any letter (upper or lowercase), that repeats one or more times
at the end of the string.

#### or
```
only_species_temp <- gsub(pattern = "([A-z]+[0-9]+:)", replacement = "", x = reptile_names)

only_species      <- gsub(pattern = "(^[A-z]+\\s)|(\\s[A-z]+$)", x = only_species_temp, replacement = "")
``` 

#### or all combined in one string.
```
only_species <- gsub(pattern = "(^[A-z]+[0-9]+:)([A-z]+\\s)|(\\s[A-z]+$)", x = reptile_names, replacement = "")
```

The pattern  for the gsub() above means: any letter at the beginning of the string
(upper or lowercase), that repeats one or more times, followed by any number that repeats
one or more times followed by collon, followed by any letter (upper or lowercase), that
repeats one or more times followed by space; or
space followed by any letter (upper or lowercase), that repeats one or more times
at the end of the string.

#### Now you can add the columns to the reptile_data data frame:
```
reptile_data2 <- cbind(reptile_data, id_numbers, only_genus, only_species)
```

## Hacker Q32. Figure out how to “capture” the first letter of the species, and transform it to make it uppercase.
## Do this in a generic manner (that would work on a table of thousands of species).

### Easiest way

```
multi_part_regex <- "^(ID[0-9]+:[A-z]+ )(.)([a-z ]+$)"
first_part <- gsub(x = reptile_names, pattern = multi_part_regex, repl = "\\1")
species_first_char <-  gsub(x = reptile_names, pattern = multi_part_regex, repl = "\\2")
last_part <-  gsub(x = reptile_names, pattern = multi_part_regex, repl = "\\3")


species_first_char_big <- toupper(species_first_char)
reptile_names_q32 <- paste(first_part, species_first_char_big, last_part, sep="")
```


### With Perl extensions
```
gsub("(\\w+)\\s+(\\w)(\\w*)", replacement = "\\1 \\U\\2\\L\\3", reptile_names, perl = TRUE)
```

The pattern  for the gsub() above means: any character (letter or number)
that repeats one or more times, followed by space that repeats one or more times,
followed by any character (letter or number), followed by any character that repeats
zero or more times.

The replacement for the gsub() above means: keep the first group (anything between parenthesis)
the way it is, keep the space, captilize the second group, and put the third group in lowercase.

```
gsub(pattern = "([\\w|:]+\\s)(\\w)(.*)", x = reptile_names, replacement = "\\1\\U\\2\\L\\3", perl=TRUE)
```

#### or by using sub(), which matches only once.
```
sub("(\\w+)\\s+(\\w)", replacement = "\\1 \\U\\2", reptile_names, perl = TRUE)
```

#### Since sub matches only once, you need to describe in the pattern only the first part
#### (ID(number):Genus_space, and the first letter of the second word.
