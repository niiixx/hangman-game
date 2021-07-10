defmodule TextClient.Player do

    alias TextClient.State, as: State
    alias TextClient.Summary, as: Summary
    alias TextClient.Prompter, as: Prompter
    alias TextClient.Mover, as: Mover

    def continue(game) do
        IO.puts("\n==========================================\n")
        game
        |> Summary.display
        |> Prompter.acceptMove
        |> Mover.makeMove
        |> play
    end # Main loop of game. Recursive

    def play(game = %State{tally: %{ state_game: :good_guess }}) do
        continue_msg("\nGood guess!", game)
    end # Good

    def play(game = %State{tally: %{ state_game: :bad_guess }}) do
        continue_msg("\nBad guess!", game)
    end # Bad

    def play(game = %State{tally: %{ state_game: :already_used }}) do
        continue_msg("\nLetter already used!", game)
    end # Already used

    def play(%State{tally: %{ state_game: :won}}) do
        exit_msg("\nYou won!")
    end # Won

    def play(%State{tally: %{ state_game: :lost}}) do
        exit_msg("\nYou lost!")
    end # Lost

    def play(game) do
        continue(game)
    end # New game

    def exit_msg(msg) do
        IO.puts(msg)
        exit(:normal)
    end # Bye

    def continue_msg(msg, game) do
        IO.puts(msg)
        continue(game)
    end

end