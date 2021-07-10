defmodule TextClient.Prompter do

    alias TextClient.State 

    def acceptMove(game = %State{}) do
        IO.gets("Your guess: ")
        |> check_input(game)
    end

    defp check_input({:error, reason}, _game) do
        IO.puts("Game ended: #{reason}")
        exit(:normal)
    end

    defp check_input(:eof, _game) do
        IO.puts("You gave up that easy?")
        exit(:normal)
    end

    defp check_input(input, game = %State{}) do
        input = String.trim(input)
        input = String.downcase(input)
        
        cond do
            input =~ ~r/\A[a-z]\z/ -> 
                Map.put(game, :guess, input)
            true -> 
                IO.puts("Please enter a single letter") 
            acceptMove(game)
        end
    end


end