defmodule GameTest do
    use ExUnit.Case
    
    alias Hangman.Game

    test "newGame returns structure" do
        game = Game.newGame
        assert game.turns_left == 7
        assert game.state_game == :initializing
        assert String.match?(game.word, ~r/^[[:lower:]]+$/u)
    end

    test "state isnt changed for :won || :lost game" do
        for state <- [ :won, :lost ] do
            game = Game.newGame |> Map.put(:state_game, state)
            assert ^game = Game.makeMove(game, "x")
        end
    end

    test "first occurrence of letter" do
        game = Game.newGame
        game = Game.makeMove(game, "x")
        assert game.state_game != :already_used
    end

    test "second occurrence of letter" do
        game = Game.newGame
        game = Game.makeMove(game, "x")
        assert game.state_game != :already_used
        game = Game.makeMove(game, "x")
        assert game.state_game == :already_used
    end

    test "a good guess is recognized" do
        game = Game.newGame
        game = Game.makeMove(game, String.at(game.word, 0))
        assert game.state_game == :good_guess
        assert game.turns_left == 7
    end

    test "a bad guess is recognized" do
        game = Game.newGame
        game = Game.makeMove(game, "1")
        assert game.state_game == :bad_guess
        assert game.turns_left == 6
    end

    test "a lost is recognized" do
        game = Game.newGame
        game = Game.makeMove(game, "0")
        assert game.state_game == :bad_guess
        assert game.turns_left == 6
        game = Game.makeMove(game, "1")
        assert game.state_game == :bad_guess
        assert game.turns_left == 5
        game = Game.makeMove(game, "2")
        assert game.state_game == :bad_guess
        assert game.turns_left == 4
        game = Game.makeMove(game, "3")
        assert game.state_game == :bad_guess
        assert game.turns_left == 3
        game = Game.makeMove(game, "4")
        assert game.state_game == :bad_guess
        assert game.turns_left == 2
        game = Game.makeMove(game, "5")
        assert game.state_game == :bad_guess
        assert game.turns_left == 1
        game = Game.makeMove(game, "6")
        assert game.state_game == :lost
    end


  end