defmodule TextClient do

  alias TextClient.Interact, as: Interact
  defdelegate start, to: Interact
end
