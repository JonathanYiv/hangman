# Hangman Project

Check out my command line version of the game [Hangman](https://en.wikipedia.org/wiki/Hangman_(game)) built with Ruby!

This is a project from [The Odin Project](https://www.theodinproject.com/courses/ruby-programming/lessons/file-i-o-and-serialization).

![Hangman](/hangman.png)

## Installation

Open your Terminal/Command Line. Navigate to the directory where your version will live. Type in the following:

```
$ git clone https://github.com/JonathanYiv/hangman.git
$ cd hangman
$ ruby hangman.rb
```

## Pre-Project Thoughts

### Psuedo-Code

1. Script displays a hangman instructions and starting screen
2. Script loads text file and gets an array via #readlines
3. Runs a loop to ensure word length is 5..12 then randomly selects a word
4. Script runs a loop to prompt for guesses and check for win/lose conditions while updating the gameboard
5. Allow serialization at any point to save/load a game

### Structure

```ruby
class Hangman
	instance variables:
		gameboard
	methods:
		initialize
		play: starts the game
			instructions: prints the instructions
			prompt_load: determines if creating a new game or pulling serialized data for a previously saved game
			turns: starts the turn-taking loop while checking for win/loss conditions
				turn: prompts the player for a guess and tells the gameboard
		save: serializes the state of the game
		load: loads a previously serialized game state to play into
class GameBoard
	instance variables:
		solution
		guesses: an array filled with "_" or the guesses
	methods:
		display: shows the current state of the gameboard
			display_gallows: shows the gallows in their current state based on # of incorrect guesses
			display_guesses: shows the addition of correct/incorrect guesses below the gallows
		update:
			evaluate_guess: takes a guess, compares it the solution, and updates the guesses array accordingly
			display: ^see above
```

## Post-Project Thoughts

1. The hardest part was probably the file serialization process. I am still relatively unfamiliar with it and hope to get more practice going forward, although I know that -- in the long run -- databases are what will matter.

2. Implementing the hangman game itself was very easy; it took me about an hour.

3. This project is one of several games I have created for The Odin Project, and I am especially proud of this one because I feel it divides things into smaller chunks and feels more organized than the previous few. 

4. If I were to add more features, I would probably have the script display a list of saved games and their respective word lengths when prompted to save/load a game. However, my desire to keep pushing foward is stronger.

5. All in all, this was a fun project that was low to moderately challenging, but very exciting in terms of using serialization to 'save' the state of the game.

6. ALSO, for SOME REASON, even though I changed my Sublime Text 3 Tab Settings to make a Tab equivalent to 2 Spaces, when I upload to Github, it reverts to a full tab. I will try to find a fix...
