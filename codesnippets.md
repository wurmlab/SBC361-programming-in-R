# Example functions

Put together during QMUL's SBSM032 Stats & Bioinformatics

## Collective conversion effort

```R

convert.cm.to.feet.and.inches <- function(length.cm) {
    if ( class(length.cm) != 'numeric') {
        stop(paste("Fail: I can only work with real numbers;",
                   "you gave me a:", class(length.cm)))
    }
    if ( length.cm < 0) {
        stop(paste("Fail: a length should be positive!!",
                   "you gave me:", length.cm))
             
    }
    
    length.inches<-length.cm/2.54

    length.feet <- length.inches/12
    length.wholefeet <- floor(length.feet)
    length.remainingpartialfeet <- length.feet - length.wholefeet
    length.remaininginches <- length.remainingpartialfeet * 12

    return(paste("There are",
          length.wholefeet, "feet and ",
          length.remaininginches, "inches in ",
          length.cm, " centimeters."))
}
```

## Multiplying numbers from 10 to 100

```R
x <- 10
y <- 100

possible.numbers<-x:y
multiplied<-1
for (current.number in possible.numbers) {
    print(paste("Current number is:", current.number))
    print(paste("Current 'multiplied' was:", multiplied))
    multiplied <- multiplied*current.number
    print(paste("Current 'multiplied' is now:", multiplied))
    print("### end of loop")
}
multiplied
```


## Rock paper scissors almost

```R
rock_paper_scissors_almost <- function(play) {
    print(paste("You played:", play))

    legalplays <-  c("rock", "paper", "scissors")
    computerplay <- sample(x=legalplays, size=1)
    print(paste("Computer played:", computerplay))
    
    if ( play == "rock") {
        if (computerplay == "scissors") {
            print("You're the best!")
        } else if (computerplay == "paper") {
            print("LOSER!")
        } else {
            print("Uhhhhhh")
        }
    } else {
        print("Sorry... I'm not that smart yet... I don't know what to do :(")
    }
}
```

