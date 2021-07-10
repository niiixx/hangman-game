defmodule Hangman do
  
  alias Hangman.Game, as: Game
  defdelegate newGame,               to: Game
  defdelegate tally(game),           to: Game

  def makeMove(game, guess) do
    game = Game.makeMove(game, guess)
    {game, tally(game)}
  end

end
