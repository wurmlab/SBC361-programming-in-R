What follow are some ideas of how to answer those last few questions the first practical session. Remember that there are dozens of manners of answering a question, and no single one is best. Other ideas that we may not have listed are perfectly valid as well!


## Q31. Add three additional columns to the reptile_data table:

First let's create one vector for each; we can worry about combining them into the `reptile_data` table later. 

### one containing only the identifier numbers (e.g. 1423 without the “ID”)

#### it might be easiest to do this in two steps. For example: 
```
id_numbers_temp <- gsub(x = reptile_names,   replacement = "", pattern = "ID")
id_numbers      <- gsub(x = id_numbers_temp, replacement = "", pattern = ":.+")
rm(id_numbers_temp)
```

This can be a bit risky though. For example, what happens if the species name contains "ID", or if there are multiple ":"? Thus it is better to be more specific. You will be more in control of what the computer is doing, and thus it is less likely to make a mistake. For example:
```
id_numbers_temp <- gsub(x = reptile_names,   replacement = "", pattern = "^ID")
id_numbers      <- gsub(x = id_numbers_temp, replacement = "", pattern = ":[A-z ]+$")
rm(id_numbers_temp)
```

If we want our regexp to be more general (e.g. if "ID" might be other capitalized letters, and if some species may be unresolved and thus be abbreviated as "sp."), we could for example do the following:
```
id_numbers_temp <- gsub(x = reptile_names,   replacement = "", pattern = "^[A-Z]+")
id_numbers      <- gsub(x = id_numbers_temp, replacement = "", pattern = ":[A-z \\.]+$")
rm(id_numbers_temp)
```

#### Or we can combine those two into a single line: 

`gsub` can "find" a regular expression match multiple times. So we can combine two with a `|`. Here are some alternative options.

Risky but works: 
```
id_numbers <- gsub(x = reptile_names, replacement = "", pattern = "([A-Z]+)|(:.+)")
```

Less risky:
```
id_numbers <- gsub(x = reptile_names, replacement = "", pattern = "(^[A-z]+)|(:[A-z \\.]+)")
```

Specific for this dataset:
```
id_numbers <- gsub(x = reptile_names, replacement = "", pattern = "(^ID)|(:[A-z ]+)")
```

#### Or we take a minimalistic approach by exclusion of everything that is not a number
```
id_numbers <- gsub(x = reptile_names, replacement = "", pattern = "[^0-9]")
```

### one column containing only the genus (e.g. Bellatorias)

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
only_genus      <- gsub(x = reptile_names, replacement = "", pattern = "(.+:)|( .+)")
```

Less risky:
```
only_genus    <- gsub(x = reptile_names, replacement = "", pattern = "([A-z]+[0-9]+:)|( [A-z]+)")
```

### one containing only the species (excluding the subspecies, e.g. tympanum)

#### As aforementioned, it is easier to do it in two steps:

Risky:
```
only_species_temp <- gsub(x = reptile_names,     replacement = "", pattern = "(.+:)")
only_species      <- gsub(x = only_species_temp, replacement = "", pattern = "(^[A-z]+ )|( .+$)")
rm(only_species_temp)
```

We can be more specific, making our script more readable, thus less risky:
```
only_species_temp <- gsub(x = reptile_names,     replacement = "", pattern = "([A-z]+[0-9]+:)")
only_species      <- gsub(x = only_species_temp, replacement = "", pattern = "(^[A-z]+ )|( [A-z]+$)")
rm(only_species_temp)
``` 

#### We can also combine the above scripts into one single line each:

Risky:
```
only_species <- gsub(x = reptile_names, replacement = "", pattern = "(.+:)([A-z]+ )|( .+$)")
```
Less risky:
```
only_species <- gsub(x = reptile_names, replacement = "", pattern = "(^[A-z]+[0-9]+:)([A-z]+ )|( [A-z]+$)")
```

#### Now you can add the columns to the reptile_data data frame:
```
reptile_data_q31 <- cbind(reptile_data, id_numbers, only_genus, only_species)
```

## Hacker Q32. Figure out how to “capture” the first letter of the species, and transform it to make it uppercase.
## Do this in a generic manner (that would work on a table of thousands of species).

### Easiest way

```
multi_part_regex       <- "^([A-z]+[0-9]+:[A-z]+ )(.)([a-z ]+$)"
first_part             <- gsub(x = reptile_names, replacement = "\\1", pattern = multi_part_regex)
species_first_char     <- gsub(x = reptile_names, replacement = "\\2", pattern = multi_part_regex)
last_part              <- gsub(x = reptile_names, replacement = "\\3", pattern = multi_part_regex)
species_first_char_big <- toupper(species_first_char)
reptile_names_q32      <- paste(first_part, species_first_char_big, last_part, sep = "")
```

### With Perl extensions, both in one single line each:
```
reptile_names_q32 <- gsub(x           = reptile_names, 
                          replacement = "\\1 \\U\\2\\L\\3", 
                          pattern     = "([A-z]+) +([A-z])([A-z]+)", 
                          perl        = TRUE)
```
The `replacement` in the `gsub()` above means: keep the first group (anything between parenthesis in the `pattern`)
the way it is, then keep the space, captilize the second group, and put the third group in lowercase.

```
reptile_names_q32 <- gsub(x           = reptile_names, 
                          replacement = "\\1\\U\\2\\L\\3", 
                          pattern     = "([A-z:]+ )([A-z])(.+)", 
                          perl        = TRUE)
```
The `replacement` in the `gsub()` above means: keep the first group (anything between parenthesis in the `pattern`)
the way it is, captilize the second group, and put the third group in lowercase.
