import 'dart:io';
import 'dart:math';

void main(List<String> arguments) {
  print(findNum()); //Level-1
  print(gameMode()); // Level-3
  print(roundGame()); //Level-4

  //print('Choose your game $findNum(), $gameMode(), $roundGame()');
}

//Level_1
int? findNum() {
  int minNumber = 1;
  int maxNumber = 100;
  int userNumber;
  String userResponse;
  int steps = 0;

  do {
    userNumber = (minNumber + maxNumber) ~/ 2;
    print('Welcome to Find Number Game.v1! Numbers from 1 to 100.');
    print('Your number $userNumber? (Your number "greater", "less" or "yes"?)');
    userResponse = stdin.readLineSync()!.toLowerCase();
    if (userResponse == 'greater') {
      minNumber = userNumber + 1;
    } else if (userResponse == 'less') {
      maxNumber = userNumber - 1;
    }
    steps++;
  } while (userResponse != 'yes');
  print('Got it! $userNumber.');
  print('Steps: $steps');
  return steps;
}

//Level 3
int? gameMode() {
  print('Select your  game mode:');
  print('1. Computer fight you.');
  print('2. You fight Computer.');

  int mode = int.parse(stdin.readLineSync()!);

  if (mode == 1) {
    print('Guess secret number in range of 1 to 100.');
    print('Enter "Ready" to start game.');
    stdin.readLineSync();

    int minBound = 1;
    int maxBound = 100;
    int attempts = 0;

    while (true) {
      int guessedNumber = guessNumber(minBound, maxBound);

      print('Is this $guessedNumber?');
      String answer = stdin.readLineSync()!.toLowerCase();

      if (answer == 'yes') {
        print('Computer found your number for $attempts steps.');
        break;
      } else if (answer == 'less') {
        maxBound = guessedNumber - 1;
      } else if (answer == 'greater') {
        minBound = guessedNumber + 1;
      } else {
        print('Enter "yes", "Less" or "Greater".');
      }

      attempts++;
    }
  } else if (mode == 2) {
    print('computer guess secret number for you in range of 1 to 100.');
    print('Enter "Ready" to start game.');
    stdin.readLineSync();

    Random random = Random();
    int targetNumber = random.nextInt(100) + 1;
    int attempts = 0;

    while (true) {
      stdout.write('Enter your number: ');
      String? input = stdin.readLineSync();

      if (input?.toLowerCase() == 'exit') {
        print('Game over. Secret number was $targetNumber.');
        break;
      }

      try {
        int guess = int.parse(input!);

        if (guess == targetNumber) {
          print(
              'Congrats! You found secret number $targetNumber for $attempts steps.');
          break;
        } else if (guess < targetNumber) {
          print('Guess number upper. Try again.');
        } else {
          print('Guess number lower. Try again.');
        }
        attempts++;
      } catch (e) {
        print(
            'Error! Enter integer number in range of 1 to 100 or "Exit" for close game.');
      }
    }
  }
}

int guessNumber(int lower, int upper) {
  return lower + ((upper - lower) ~/ 2);
}

//Level - 4

int? roundGame() {
  print('Welcome to Find Number Game - Death number');
  print('Choose rounds (max - 10, 3 - by default): ');

  int rounds = 3;
  String userInput = stdin.readLineSync()!;
  if (userInput.isNotEmpty) {
    rounds = int.parse(userInput);
    rounds = rounds.clamp(1, 10);
  }

  int userWins = 0;
  int computerWins = 0;

  for (int round = 1; round <= rounds; round++) {
    print('\n====================');
    print('Round $round');

    int userNumber = getUserNumber();
    int computerGuesses = computerGuessesNumber();
    print('User guessing number: $userNumber');
    print('Computer finding your number ... $computerGuesses');
    determineWinner(userNumber, computerGuesses, 'Computer', 'User', round,
        computerWins, userWins);

    int computerNumber = computerGeneratesNumber();
    int userGuesses = userGuessesNumber(computerNumber);
    print('Computer guessing number: $computerNumber');
    print('User finding number... $userGuesses');
    determineWinner(computerNumber, userGuesses, 'User', 'Computer', round,
        userWins, computerWins);
  }

  print('\n====================');
  print('Results:');
  print('User: $userWins wins');
  print('Computer: $computerWins wins');

  if (userWins > computerWins) {
    print('You won!');
  } else if (userWins < computerWins) {
    print('Computer won!');
  } else {
    print('None!');
  }
}

int getUserNumber() {
  print('Enter your number: ');
  String userInput = stdin.readLineSync()!;
  return int.parse(userInput);
}

int computerGuessesNumber() {
  Random random = Random();
  return random.nextInt(100) + 1;
}

int computerGeneratesNumber() {
  Random random = Random();
  return random.nextInt(100) + 1;
}

int userGuessesNumber(int targetNumber) {
  int attempts = 0;
  int? userGuess;

  while (userGuess != targetNumber) {
    print('Your number: ');
    String userInput = stdin.readLineSync()!;
    userGuess = int.tryParse(userInput);

    if (userGuess == null) {
      print('Error! Enter correct number.');
    } else {
      attempts++;
      if (userGuess < targetNumber) {
        print('Greater!');
      } else if (userGuess > targetNumber) {
        print('Less!');
      }
    }
  }

  return attempts;
}

void determineWinner(int targetNumber, int guesses, String winner, String loser,
    int round, int winnerScore, int loserScore) {
  print('$winner found number $loser for $guesses steps!');
  if (guesses == 1) {
    print('Found in one step! Great job!');
  }
  print('$winner win in round $round!');
  print('$winner: $winnerScore, $loser: $loserScore');
}
