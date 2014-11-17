rockPaperScissors <- function(user.play) {

  ## The possible plays
  legal.plays   <- c("rock", "paper", "scissors")

  # Your play
  print(paste("You played", user.play))

  ## The computer's play
  computer.play <- sample(x=legal.plays, size=1)
  print(paste("The computer played", computer.play))

  ##### COMPLETE THE FOLLOWING #####
  # Make sure the input is of length one (complete the condition of the if statement)
  if (length(user.play) != 1) {
    stop("Sorry, I did not understand that. Please input one word only")
  }
  ##################################

  # Make sure the input is one of the 3 possible choices
  # The %in% operand checks if the element on the lect is present in the vecotr on the right, and returns TRUE or FALSE
  if (!(user.play %in% legal.plays)) {
    stop(paste("Sorry, I did not understand that. Input has to be: ", paste(legal.plays, collapse=" or ")))
  }

  ##### COMPLETE THE FOLLOWING #####

  # If the user wins, return "You win."
  # If the user loses, return "You lose."
  # If there is a draw, return "Draw."

  # Remember, rock wins against scissors, scissors win against paper, and paper wins against rock.
  # For example, if the user plays rock,
    # he wins if the computer plays scissors,
    # he loses if the computer plays paper
    # he draws if the computer plays rock

  # HINT: This function will probably take a lot of if statements


  ###### NOTE #######
  ## The marking is done automatically.
  ## Please print and return the exact phrases we ask you to!
  ###### NOTE #######

}
