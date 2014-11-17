rockPaperScissors <- function(user.play) {

  ## The aim of the function is to return a phrase saying
  # what you played, what the computer played, and who won.

  ## The possible plays
  legal.plays   <- c("rock", "paper", "scissors")

  ## The computer's play
  computer.play <- sample(x=legal.plays, size=1)

  ##### COMPLETE THE FOLLOWING #####
  # Make sure the input is of length one (complete the condition of the if statement)
  if () {
    stop("Sorry, I did not understand that. Please input one word only")
  }
  ##################################

  # Make sure the input is one of the 3 possible choices
  # The %in% operand checks if the element on the lect is present in the vecotr on the right, and returns TRUE or FALSE
  if (!(user.play %in% legal.plays)) {
    stop(paste("Sorry, I did not understand that. Input has to be: ", paste(legal.plays, collapse=" or ")))
  }

  ##### COMPLETE THE FOLLOWING #####
  # You will have to store the game results to a variable called game.result

  # If the user wins, write "You win." to game.result          # game.result <- "You win."
  # If the user loses, write "You lose." to game.result.       # game.result <- "You lose."
  # If there is a draw, write "Draw." to game.result.          # game.result <- "Draw."

  # Remember, rock wins against scissors, scissors win against paper, and paper wins against rock.
  # For example, if the user plays rock,
    # he wins if the computer plays scissors,
    # he loses if the computer plays paper
    # he draws if the computer plays rock

  # HINT: This function will probably take a lot of if statements

  # Return the game.result
  phrase.to.return <- paste("You played ", user.play, "; the computer played ", computer.play, ". ", game.result, sep='')
  return(phrase.to.return)

  ###### NOTE #######
  ## The marking is done automatically.
  ## Please return the exact phrase we ask you to!
  ###### NOTE #######

}
