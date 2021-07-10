defmodule Hangman.Game do


    ###################################### PUBCLI ###################################### 

    defstruct(
        turns_left: 7,
        state_game: :initializing,
        letters: [],
        word: [],
        used: MapSet.new(),
    )

    def newGame do
        newWord = Dictionary.createRandom 
        %Hangman.Game{
        letters: newWord
        |> String.codepoints,
        word: newWord,
        }
    end

    def makeMove(game = %{state_game: state}, _guess) 
    when state in [:won, :lost] do 
        game
    end # Make move when lost or won

    def makeMove(game, guess) do
        game = acceptMove(game, guess, MapSet.member?(game.used, guess))
        game
    end

    def tally(game) do
        %{
            state_game: game.state_game,
            turns_left: game.turns_left,
            letters: game.letters |> revealGuessed(game.used)
        }
    end

    ###################################### PRIVATE ######################################

    defp acceptMove(game, _guess, true) do
        Map.put(game, :state_game, :already_used)
    end # The letter is already guessed
 
    defp acceptMove(game, guess, false) do
        Map.put(game, :used, MapSet.put(game.used, guess))
        |> scoreGuess(Enum.member?(game.letters, guess))
    end # The letter hasnt been guessed, we add it to the guessed ones

    defp scoreGuess(game, true) do
        new_state = MapSet.new(game.letters)
        |> MapSet.subset?(game.used)
        |> maybeWon
        Map.put(game, :state_game, new_state)
    end # Good guess

    defp scoreGuess(game = %{turns_left: 1}, false) do
        Map.put(game, :state_game, :lost)
    end # Not good guess and u lose

    defp scoreGuess(game = %{turns_left: turns_left}, false) do
        %{game | 
        state_game: :bad_guess, 
        turns_left: turns_left-1,
        }
    end # Not good guess but u didnt lose

    defp maybeWon(true) do
        :won
    end # Change state, we won

    defp maybeWon(false) do
        :good_guess
    end # Good guess but didnt won

    defp revealGuessed(letters, used) do
        letters
        |> Enum.map(fn letter -> revealLetter(letter, MapSet.member?(used,letter)) end)
    end

    defp revealLetter(letter, true) do
        letter
    end

    defp revealLetter(_letter, false) do
        "_"
    end

end