### Q31. Add three additional columns to the reptile_data table:

## one containing only the identifier numbers (e.g. 1423 without the “ID”)

# It is better answering in a more generic manner. By doing this you will beable to
# use your script on a different data frame, which may contain different characters,
# but the same structure.
...
id_numbers <- gsub(pattern = "(ID)|(:.*)", x = reptile_names, replacement = "")
...
# or
...
id_numbers <- gsub(pattern = "([A-z])|(:.*)", x = reptile_names, replacement = "")
...

# you can also decompose the script in two strings, ex:
...
id_numbers_temp <- gsub(pattern = "ID", x = reptile_names, replacement = "")

id_numbers      <- gsub(pattern = "(:.*)", x = id_numbers_temp, replacement = "")
...

## one column containing only the genus (e.g. Bellatorias)
...
only_genus    <- gsub(pattern = "(.+:)|( .+)", x = reptile_names, replacement = "")
...

# Generic manner. Also more readable.
...
only_genus    <- gsub(pattern = "([A-z]+[0-9]+:)|(\\s[A-z]+)", x = reptile_names, replacement = "")
...

# the pattern  for the gsub() above means: any letter (upper or lowercase), that
# repeats once or more times, followed by any number, that repeats once or more times,
# followed by a collon; or space followed by any letter (upper or lowercase),
# that repeats one or more times.

# or splitting in two strings:
...
only_genus_temp <- gsub(pattern = "([A-z]+[0-9]+:)", x = reptile_names, replacement = "")

only_genus      <- gsub(pattern = "(\\s[A-z]+)", x = only_genus_temp, replacement = "")
...

## one containing only the species (excluding the subspecies, e.g. tympanum)
...
only_species_temp <- gsub(pattern = "(.*:)", replacement = "", x = reptile_names)

only_species      <- gsub(pattern = "(^[A-z]+ )|( [A-z]+$)", x = only_species_temp, replacement = "")
...
# the pattern  for the gsub() above means: any letter at the beginning of the string
# (upper or lowercase), that repeats one or more times, followed by space; or
# space followed by any letter (upper or lowercase), that repeats one or more times
# at the end of the string.

# or
...
only_species_temp <- gsub(pattern = "([A-z]+[0-9]+:)", replacement = "", x = reptile_names)

only_species      <- gsub(pattern = "(^[A-z]+\\s)|(\\s[A-z]+$)", x = only_species_temp, replacement = "")
... 

# or all combined in one string.
...
only_species <- gsub(pattern = "(^[A-z]+[0-9]+:)([A-z]+\\s)|(\\s[A-z]+$)", x = reptile_names, replacement = "")
...

# the pattern  for the gsub() above means: any letter at the beginning of the string
# (upper or lowercase), that repeats one or more times, followed by any number that repeats
# one or more times followed by collon, followed by any letter (upper or lowercase), that
# repeats one or more times followed by space; or
# space followed by any letter (upper or lowercase), that repeats one or more times
# at the end of the string.


## Now you can add the columns to the reptile_data data frame:
...
reptile_data2 <- cbind(reptile_data, id_numbers, only_genus, only_species)
...

## Hacker Q32. Figure out how to “capture” the first letter of the species, and transform it to make it uppercase.
## Do this in a generic manner (that would work on a table of thousands of species).
...
gsub("(\\w+)\\s+(\\w)(\\w*)", replacement = "\\1 \\U\\2\\L\\3", reptile_names, perl = TRUE)
...

# the pattern  for the gsub() above means: any character (letter or number)
# that repeats one or more times, followed by space that repeats one or more times,
# followed by any character (letter or number), followed by any character that repeats
# zero or more times.

# the replacement for the gsub() above means: keep the first group (anything between parenthesis)
the way it is, keep the space, captilize the second group, and put the third group in lowercase.
...
gsub(pattern = "([\\w|:]+\\s)(\\w)(.*)", x = reptile_names, replacement = "\\1\\U\\2\\L\\3", perl=TRUE)
...

# or by using sub(), which matches only once.
...
sub("(\\w+)\\s+(\\w)", replacement = "\\1 \\U\\2", reptile_names, perl = TRUE)
...

# Since sub matches only once, you need to describe in the pattern only the first part
# (ID(number):Genus_space, and the first letter of the second word.
