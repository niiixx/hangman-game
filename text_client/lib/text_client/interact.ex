defmodule TextClient.Interact do

    alias TextClient.State, as: State
    alias TextClient.Player, as: Player

    def start do
        Hangman.newGame
        |> setupState
        |> Player.play
    end

    def setupState(game) do
        %State{
            game_service: game,
            tally: Hangman.tally(game),
        }
    end   
    
end