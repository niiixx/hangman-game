defmodule TextClient.Mover do
    
    alias TextClient.State

    def makeMove(game) do
        {gs, tally} = Hangman.makeMove(game.game_service, game.guess)
        %State{ game | game_service: gs, tally: tally}
    end

end