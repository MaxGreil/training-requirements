# Rscript tic-tac-toe.R
# Tic-Tac-Toe with random computer AI

# author: "Maximilian Greil"
# date: "11 4 2021"

# Set global variables
counter <- 1

current_game_state <- TRUE

x <- c('NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA')
board <<- as.data.frame(matrix(x, ncol = 3, byrow = TRUE), stringsAsFactors=FALSE)
rownames(board) = c("1", "2", "3")
colnames(board) = c("1", "2", "3")

# Print current round
get_round <- function() {
  cat("\n##############################\n")
  cat(paste0("\n########## Round #", counter, " ##########\n"))
  cat("\n##############################\n")
}

# Select symbol before game start
game_start <- function() {
  check <- TRUE
  while(check) {
    if (interactive()) {
      con <- stdin()
    } else {
      con <- "stdin"
    }
    cat("X or O? ")
    symbol <<- readLines(con = con, n = 1)
    if(symbol != "X" && symbol != "O") {
      cat(paste0("Incorrect input! Please choose between 'X' and 'O'.\n"))
    } else {
      check <- FALSE
      if(symbol == "X") {
        computer_symbol <<- "O"
      } else {
        computer_symbol <<- "X"
      }
    }
  }
}

# Print current board
print_board <- function() {
  cat("\nCurrent board:\n")
  cat("\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n")
  print(board)
  cat("\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
}

# Print final board
print_final_board <- function() {
  cat("\nFinal board:\n")
  cat("\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n")
  print(board)
  cat("\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
}

# Player selection where to place symbol
player_move <- function() {
  check <- TRUE
  cat(paste0("\nPlayer '", symbol, "' turn:\n"))
  while(check) {
    numbers <- check_player_input()
    if(!is.element('-1', numbers) && check_player_move_board(numbers[1], numbers[2])) {
      cat(paste0("Place '", symbol, "' at row ", numbers[1], " column ", numbers[2], " ? [y/n] "))
      confirmation <- check_player_confirmation()
      if(confirmation == "y" || confirmation == '') {
        cat("\nMove registered!\n")
        board[strtoi(numbers[1]), strtoi(numbers[2])] = symbol
        check <- FALSE
      }
    }
  }
  return(board)
}

# Check player number input
check_player_input_number <- function(row_number, col_number) {
  check <- TRUE
  if(row_number != 1 & row_number != 2 & row_number != 3) {
    cat(paste0(row_number, " is not a valid number for row!\n"))
    check <- FALSE
  }
  if(col_number != 1 & col_number != 2 & col_number != 3) {
    cat(paste0(col_number, " is not a valid number for column!\n"))
    check <- FALSE
  }
  return(check)
}

# Check if player move possible
check_player_input <- function() {
  if (interactive()) {
    con <- stdin()
  } else {
    con <- "stdin"
  }
  cat("What row? ")
  row_number <- readLines(con = con, n = 1)
  cat("What column? ")
  col_number <- readLines(con = con, n = 1)
  if(!check_player_input_number(row_number, col_number)) {
    cat("Invalid selection. Choose 1, 2 or 3 for row and column.\n")
    row_number <- -1
    col_number <- -1
  }
  return(c(row_number, col_number))
}

# Check player move confirmation
check_player_confirmation <- function() {
  check <- TRUE
  while(check) {
    if (interactive()) {
      con <- stdin()
    } else {
      con <- "stdin"
    }
    player_confirmation <- readLines(con = con, n = 1)
    # Enter key is also correct input 
    if(player_confirmation == '') {
      check <- FALSE
    }
    if(check) {
      if(player_confirmation != "y" && player_confirmation != "n") {
        cat(paste0("Incorrect input! Please choose between 'y' and 'n'.\n"))
      } else {
        check <- FALSE
      }
    }
  }
  return(player_confirmation)
}

# Check if position selected by player already taken
check_player_move_board <- function(row_number, col_number) {
  if(board[row_number, col_number] != 'NA') {
    cat(paste0("Position with row ", row_number, " and column ", col_number, " was already selected!\n"))
    return(FALSE)
  }
  return(TRUE)
}

# Computer posting symbol
computer_move <- function() {
  cat(paste0("\nComputer '", computer_symbol, "' turn:\n"))
  move <- computer_random_move()
  cat("\nComputer move registered!\n")
  board[move[1], move[2]] <- computer_symbol
  return(board)
}

# Check if moves on board left
check_moves_left <- function() {
  res <- rowSums("NA" == board) == 0
  if(all(res == TRUE)) {
    return(FALSE)
  }
  return(TRUE)
}

# Generate random computer move
computer_random_move <- function() {
  check <- TRUE
  move <- vector()
  while(check) {
    i <- sample(c(1:3), size=1)
    j <- sample(c(1:3), size=1)
    if(board[i, j] == 'NA') {
      check <- FALSE
      move <- c(i,j)
    }
  }
  return(move)
}

# Check for winner on current board
check_winner <- function() {
  winner <- 'NA'
  #horizontal
  for(i in 1:3) {
    if(board[i, 1] == board[i, 2] & board[i, 1] == board[i, 3] & board[i, 2] == board[i, 3]) {
      if(board[i, 1] != 'NA') {
        winner <- board[i, 1]
      }
    }
  }
  #vertical
  for(i in 1:3) {
    if(board[1, i] == board[2, i] & board[1, i] == board[3, i] & board[2, i] == board[3, i]) {
      if(board[1, i] != 'NA') {
        winner = board[1, i]
      }
    }
  }
  #diagonal
  if(board[1, 1] == board[2, 2] & board[1, 1] == board[3, 3] & board[2, 2] == board[3, 3]) {
    if(board[1, 1] != 'NA') {
      winner = board[1, 1]
    }
  }
  if(board[3, 1] == board[2, 2] & board[3, 1] == board[1, 3] & board[2, 2] == board[1, 3]) {
    if(board[3, 1] != 'NA') {
      winner = board[3, 1]
    }
  }
  return(winner)
}

game_start()

# Game loop
while(current_game_state) {
  get_round()
  print_board()
  
  if(current_game_state){
    if(!check_moves_left()) {
      cat("\nTIE!\n")
      current_game_state <- FALSE
    } else {
      if(symbol == 'X') {
        board <- player_move()
      } else {
        board <- computer_move()
      }
      print_board()
      winner <- check_winner()
      if(winner != 'NA') {
        cat(paste0("\n'", winner, "' wins!\n"))
        current_game_state <- FALSE
      }
    }
  }
  
  if(current_game_state) {
    if(!check_moves_left()) {
      cat("\nTIE!\n")
      current_game_state <- FALSE
    } else {
      if(symbol == 'X') {
        board <- computer_move()
      } else {
        board <- player_move()
      }
      winner <- check_winner()
      if(winner != 'NA') {
        cat(paste0("\n'", winner, "' wins!\n"))
        current_game_state <- FALSE
      }
    }
  }
  if(current_game_state) {
    print_board()
  } else {
    print_final_board()
  }
  counter <- counter + 1
}

