defmodule TextClient.Summary do

    def display(game = %{tally: tally}) do
        IO.puts("\nWord filled: #{Enum.join(tally.letters, " ")}\n")
        IO.puts("Guesses left: #{tally.turns_left}\n")
        game
    end

end