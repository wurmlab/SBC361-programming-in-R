What follow are some ideas of how to answer those last few questions the first practical session. Remember that there are dozens of manners of answering a question, and no single one is best. We provide a few possibilities for each. Other ideas that we may not have listed are perfectly valid as well!

As a general rule, it can be better to be more specific, but in a real life situation you would want to include some sort of automated verification that your code is performing as you intend (in particular when you move on to larger datasets for which it is hard to have an overview). 

Ok, ok, now let's get hacking.


## Q31. Add three additional columns to the reptile_data table:

First let's create one vector for each; we can worry about combining them into the `reptile_data` table later. 

### One containing only the identifier numbers (e.g. 1423 without the “ID”)

#### It might be easiest to do this in two steps. For example: 
```
id_numbers_temp <- gsub(x = reptile_names,   replacement = "", pattern = "ID")
id_numbers      <- gsub(x = id_numbers_temp, replacement = "", pattern = ":.+")
rm(id_numbers_temp)
```

This can be a bit risky though. For example, what happens if the species name contains "ID", or if there are multiple ":"? Thus it is better to be more specific. You will be more in control of what the computer is doing, and thus it is less likely to do something you didn't intend. The following example is more specific than the previous:
```
id_numbers_temp <- gsub(x = reptile_names,   replacement = "", pattern = "^ID")
id_numbers      <- gsub(x = id_numbers_temp, replacement = "", pattern = ":[A-z ]+$")
rm(id_numbers_temp)
```

If we wanted our regexp to be more general (e.g. if we know that "ID" might be in other cases be other capitalized letters, and if some species may be unresolved and thus be abbreviated as "sp."), we could for example do the following:
```
id_numbers_temp <- gsub(x = reptile_names,   replacement = "", pattern = "^[A-Z]+")
id_numbers      <- gsub(x = id_numbers_temp, replacement = "", pattern = ":[A-z \\.]+$")
rm(id_numbers_temp)
```

#### Or we can combine those two into a single line: 

`gsub` can "find" a regular expression match multiple times. So we can combine two parts with a `|`, taking care to use parentheses appropriately. Here are some examples of combinations:

Risky but works:
```
id_numbers <- gsub(x = reptile_names, replacement = "", pattern = "([A-Z]+)|(:.+)")
```

Less risky because more specific while keeping some generality:
```
id_numbers <- gsub(x = reptile_names, replacement = "", pattern = "(^[A-z]+)|(:[A-z \\.]+$)")
```

Specific for this dataset:
```
id_numbers <- gsub(x = reptile_names, replacement = "", pattern = "(^ID)|(:[A-z ]+$)")
```

#### Or we take a minimalistic approach by exclusion of everything that is not a number
```
id_numbers <- gsub(x = reptile_names, replacement = "", pattern = "[^0-9]")
```

### One column containing only the genus (e.g. Bellatorias):

Risky but works:
```
only_genus_temp <- gsub(x = reptile_names,   replacement = "", pattern = "(.+:)")
only_genus      <- gsub(x = only_genus_temp, replacement = "", pattern = "( .+)")
rm(only_genus_temp)
```

More specific, less risky:
```
only_genus_temp <- gsub(x = reptile_names,   replacement = "", pattern = "([A-z]+[0-9]+:)")
only_genus      <- gsub(x = only_genus_temp, replacement = "", pattern = "( [A-z]+)")
rm(only_genus_temp)
```


#### We can also combine those two options above, each one into one single line:

Risky:
```
only_genus <- gsub(x = reptile_names, replacement = "", pattern = "(.+:)|( .+)")
```

Less risky:
```
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

We can be more specific, making our script more readable, thus less risky:
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

#### Now you can add the columns to the reptile_data data frame:

We can use `cbind` for this: 
```R
reptile_data_q31 <- cbind(reptile_data, id_numbers, only_genus, only_species)
```

Or we can use the `$`. For example, `reptile_data$V4` would pull out the year. If we try to access `reptile_data$id_nums`, that doesn't exist. But we can create it: 
```R
reptile_data$id_nums <- id_numbers
```

And so on for the others. Or we can use the `[]` square brackets. I find this more risky because it's hard to remember whether rows or columns come first. Anyhow here is one way with a named column:
```R
reptile_data[,'id_nums'] <- id_numbers
```

And another way (even more risky), just using the column number. I dislike this approach because it's easy to accidentally overwrite an existing column. 
```R
reptile_data[,5] <- id_numbers
```

Obviously, you could also combine the data modification and merging into the table into a single step  creation  multiple steps. For example: 
```R
reptile_data$id_nums <- gsub(x = reptile_names, pattern = "[^0-9]", replacement = "")
```

Or: 
```R
reptile_data_q31 <- cbind(
			  reptile_data, 
			  id      = gsub(x = reptile_names, replacement = "", pattern = "[^0-9]"), 
			  genus   = gsub(x = reptile_names, replacement = "", pattern = "(^[A-z]+[0-9]+:)|( [A-z]+$)"),
			  species = gsub(x = reptile_names, replacement = "", pattern = "(^[A-z]+[0-9]+:)([A-z]+ )|( [A-z]+$)")
			  )
```


## Hacker Q32. Figure out how to “capture” the first letter of the species, and transform it to make it uppercase.

Do this in a generic manner (that would work on a table of thousands of species).

### Easiest way using captures

Here we're decomposing.

```R
# we write the regex only once to reduce risks
multi_part_regex       <- "^([A-z]+[0-9]+:[A-z]+ )(.)([a-z ]+$)"

# now lets replace the whole string by just the first group to delete the rest
# store the result in a variable. Then repeat for other two parenthesis groups
first_part             <- gsub(x = reptile_names, replacement = "\\1", pattern = multi_part_regex)
species_first_char     <- gsub(x = reptile_names, replacement = "\\2", pattern = multi_part_regex)
last_part              <- gsub(x = reptile_names, replacement = "\\3", pattern = multi_part_regex)

#google "uppercase in R" finds the toupper function!
species_first_char_big <- toupper(species_first_char)

reptile_names_q32      <- paste(first_part, species_first_char_big, last_part, sep = "")
```

### Alternative way without captures
```
first_part  <- gsub(x = reptile_names, replacement = "", pattern = " .+")
species     <- gsub(x = reptile_names, replacement = "", pattern = "[A-z]+[0-9]+:[A-z]+ ")

#google "extract part of string in R" finds the substr function
species_first_char     <- substr(x=species, start=0, stop=1)
species_first_char_big <- toupper(species_first_char)

species_rest <- gsub(x = species, pattern = "^.", replacement = "")
reptile_names_q32      <- paste(first_part, species_first_char_big, species_rest, sep = "")
```

### With captures and perl extensions, both in one single line each:
```
reptile_names_q32 <- gsub(x           = reptile_names,
                          pattern     = "(^ID[0-9]+:[A-z]+ )([A-z])([a-z ]+$)",
                          replacement = "\\1\\U\\2\\L\\3",
                          perl        = TRUE)
```

The `replacement` in the `gsub()` above means: keep the first group (groups are sets of parentheses in the 'pattern'; in the same order) then keep the space, captalize the second group, and put the third group in lowercase.


A less specific approach:

```
reptile_names_q32 <- gsub(x           = reptile_names, 
                          pattern     = "(^[A-z:0-9]+ )(.)(.+)$", 
                          replacement = "\\1\\U\\2\\L\\3", 
                          perl        = TRUE)
```

