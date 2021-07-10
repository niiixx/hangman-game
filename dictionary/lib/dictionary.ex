defmodule Dictionary do
  def wordList do
    "../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r"\n")
  end

  def random_word(wordList) do
    Enum.random(wordList)
  end

  def createRandom do
    Dictionary.wordList
    |> Dictionary.random_word
  end
end
