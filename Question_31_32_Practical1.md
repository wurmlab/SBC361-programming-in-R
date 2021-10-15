# Computing in R - Questions 31 and 32 - Practical 1

## SBC361: Research Methods and Communication - October 2015



What follow are some ideas of how to answer those last few questions the first practical session. Remember that there are dozens of manners of answering a question, and no single one is best. We provide a few possibilities for each. Other ideas that we may not have listed are perfectly valid as well!

As a general rule, it can be better to be more specific, but in a real life situation you would want to include some sort of automated verification that your code is performing as you intend (in particular when you move on to larger datasets for which it is hard to have an overview). 

Ok, ok, now let's get hacking.


## Q31. Add three additional columns to the reptile_data table:

First let's create one vector for each; we can worry about combining them into the `reptile_data` table later. 

### One containing only the identifier numbers (e.g. 1423 without the “ID”):

#### It might be easiest to do this in two steps. For example: 

```R
id_numbers_temp <- gsub(x = reptile_names,   replacement = "", pattern = "ID")
id_numbers      <- gsub(x = id_numbers_temp, replacement = "", pattern = ":.+")
rm(id_numbers_temp)
```

This can be a bit risky though. For example, what happens if the species name contains "ID" or if there are multiple ":"? Thus, it is better to be more specific. You will be more in control of what the computer is doing, and thus it is less likely to do something you did not intend. The following example is more specific than the previous:

```R
id_numbers_temp <- gsub(x = reptile_names,   replacement = "", pattern = "^ID")
id_numbers      <- gsub(x = id_numbers_temp, replacement = "", pattern = ":[A-z ]+$")
rm(id_numbers_temp)
```

If we wanted our regexp to be more general (e.g. if we know that "ID" might be in other cases be other capitalise letters, and if some species may be unresolved and thus be abbreviated as "sp."), we could for example do the following:

```R
id_numbers_temp <- gsub(x = reptile_names,   replacement = "", pattern = "^[A-Z]+")
id_numbers      <- gsub(x = id_numbers_temp, replacement = "", pattern = ":[A-z \\.]+$")
rm(id_numbers_temp)
```

#### Or we can combine those two into a single line: 

`gsub` can "find" a regular expression match multiple times. So we can combine two parts with a `|`, taking care to use parentheses appropriately. Here are some examples of combinations:

Risky but works:

```R
id_numbers <- gsub(x = reptile_names, replacement = "", pattern = "([A-Z]+)|(:.+)")
```

Less risky because more specific while keeping some generality:

```R
id_numbers <- gsub(x = reptile_names, replacement = "", pattern = "(^[A-z]+)|(:[A-z \\.]+$)")
```

Specific for this dataset:

```R
id_numbers <- gsub(x = reptile_names, replacement = "", pattern = "(^ID)|(:[A-z ]+$)")
```

#### Or we take a minimalistic approach by exclusion of everything that is not a number:

```R
id_numbers <- gsub(x = reptile_names, replacement = "", pattern = "[^0-9]")
```

### One column containing only the genus (e.g. Bellatorias):

Risky, but works:

```R
only_genus_temp <- gsub(x = reptile_names,   replacement = "", pattern = "(.+:)")
only_genus      <- gsub(x = only_genus_temp, replacement = "", pattern = "( .+)")
rm(only_genus_temp)
```

More specific, less risky:

```R
only_genus_temp <- gsub(x = reptile_names,   replacement = "", pattern = "([A-z]+[0-9]+:)")
only_genus      <- gsub(x = only_genus_temp, replacement = "", pattern = "( [A-z]+)")
rm(only_genus_temp)
```

#### We can also combine those two options above, each one into one single line:

Risky:

```R
only_genus <- gsub(x = reptile_names, replacement = "", pattern = "(.+:)|( .+)")
```

Less risky:

```R
only_genus <- gsub(x = reptile_names, replacement = "", pattern = "([A-z]+[0-9]+:)|( [A-z]+)")
```

### One column containing only the species (excluding the subspecies, e.g. tympanum):

#### As mentioned above, it is easier to do it in two steps:

Risky:

```R
only_species_temp <- gsub(x = reptile_names,     replacement = "", pattern = "(.+:)")
only_species      <- gsub(x = only_species_temp, replacement = "", pattern = "(^[A-z]+ )|( .+$)")
rm(only_species_temp)
```

We can make our code more readable being more specific, thus less risky:

```R
only_species_temp <- gsub(x = reptile_names,     replacement = "", pattern = "([A-z]+[0-9]+:)")
only_species      <- gsub(x = only_species_temp, replacement = "", pattern = "(^[A-z]+ )|( [A-z]+$)")
rm(only_species_temp)
``` 

#### We can also combine the above scripts into one single line each:

Risky:

```R
only_species <- gsub(x = reptile_names, replacement = "", pattern = "(.+:)([A-z]+ )|( .+$)")
```

Less risky:

```R
only_species <- gsub(x = reptile_names, replacement = "", pattern = "(^[A-z]+[0-9]+:)([A-z]+ )|( [A-z]+$)")
```

#### Now you can add the columns to the reptile_data table:

We can use `cbind` for this:

```R
reptile_data_q31 <- cbind(reptile_data, id_numbers, only_genus, only_species)
```

Or we can use the `$`. For example, `reptile_data$V4` would pull out the year. If we try to access `reptile_data$id_numbers`, that does not exist. However, we can create it: 

```R
reptile_data$id_numbers <- id_numbers
```

And so on for the others. Or we can use the `[]` square brackets. I find this more risky because it is hard to remember whether rows or columns come first. Anyhow, here is one way with a named column:

```R
reptile_data[, 'id_numbers'] <- id_numbers
```

And another way (even more risky), just using the column number. I dislike this approach because it is easy to accidentally overwrite an existing column:

```R
reptile_data[, 5] <- id_numbers
```

Obviously, you could also combine the data modification and merging into the table into a single step creation instead of doing it in multiple steps. For example: 

```R
# This could have been the complete answer for the first part.
reptile_data$id_numbers <- gsub(x = reptile_names, replacement = "", pattern = "[^0-9]")

# This could have been the complete answer for the second part.
reptile_data$only_genus <- gsub(x = reptile_names, replacement = "", pattern = "([A-z]+[0-9]+:)|( [A-z]+)")

# This could have been the complete answer for the last part.
reptile_data$only_species <- gsub(x           = reptile_names, 
				  replacement = "", 
				  pattern     = "(^[A-z]+[0-9]+:)([A-z]+ )|( [A-z]+$)"
				  )
```

Or:

```R
reptile_data_q31 <- cbind(reptile_data, 
			  id_numbers   = gsub(x           = reptile_names, 
			                      replacement = "", 
			                      pattern     = "[^0-9]"
			                      ), 
			  only_genus   = gsub(x           = reptile_names, 
			                      replacement = "", 
			                      pattern     = "(^[A-z]+[0-9]+:)|( [A-z]+$)"
			                      ), 
			  only_species = gsub(x           = reptile_names, 
			                      replacement = "", 
			                      pattern     = "(^[A-z]+[0-9]+:)([A-z]+ )|( [A-z]+$)"
			                      )
			  )
```


## Hacker Q32. Figure out how to “capture” the first letter of the species, and transform it to make it uppercase. Do this in a generic manner (that would work on a table of thousands of species).

### Easiest way, using captures:

Here we are decomposing: 

```R
# Since we will be using the same 'pattern', we write the regexp only once to reduce risks
multi_part_regexp      <- "^([A-z]+[0-9]+:[A-z]+ )(.)([a-z ]+$)"

# Every number in the 'replacement' below stands for: keep the equivalent group
# (anything between parentheses in our regexp) the way it is and delete the rest.
# Therefore, the 'first_part' variable will contain only what is described
# in the first group (parentheses) of our regexp.
# Thus, let's replace the whole string by just the first group, delete the rest
# and store the result in a variable. Then repeat for other two parenthesis groups:
first_part             <- gsub(x = reptile_names, replacement = "\\1", pattern = multi_part_regexp)
last_part              <- gsub(x = reptile_names, replacement = "\\3", pattern = multi_part_regexp)
species_first_char     <- gsub(x = reptile_names, replacement = "\\2", pattern = multi_part_regexp)

# Put the species_first_char variable in uppercase. Google "uppercase in R" finds the toupper function!
species_first_char_big <- toupper(species_first_char)

# You can also do the 'uppercase step' without creating the 'species_first_char' variable. For example:
species_first_char_big <- toupper(gsub(x = reptile_names, replacement = "\\2", pattern = multi_part_regexp))

reptile_names_q32      <- paste(first_part, species_first_char_big, last_part, sep = "")
```

### Alternative way, without captures:

```R
first_part             <- gsub(x = reptile_names, replacement = "", pattern = " .+")
species                <- gsub(x = reptile_names, replacement = "", pattern = "[A-z]+[0-9]+:[A-z]+")

# Google "extract part of string in R" finds the substr function!
species_first_char     <- substr(x = species, start = 0, stop = 1)
species_first_char_big <- toupper(species_first_char)

# or in one step (without the 'species_first_char' variable):
species_first_char_big <- toupper(substr(x = species, start = 0, stop = 1))

species_rest           <- gsub(x = species, pattern = "^.", replacement = "")
reptile_names_q32      <- paste(first_part, species_first_char_big, species_rest, sep = "")
```

### With captures and perl extensions, both in one single line each:

```R
reptile_names_q32 <- gsub(x           = reptile_names,
                          pattern     = "(^ID[0-9]+:[A-z]+ )([A-z])([a-z ]+$)",
                          replacement = "\\1\\U\\2\\L\\3",
                          perl        = TRUE
                          )
```

A less specific approach:

```R
reptile_names_q32 <- gsub(x           = reptile_names, 
                          pattern     = "(^[A-z:0-9]+ )(.)(.+)$", 
                          replacement = "\\1\\U\\2\\L\\3", 
                          perl        = TRUE
                          )
```
