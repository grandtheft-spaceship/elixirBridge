defmodule Calc do
  @moduleDoc """
  Calculator module
  """

  @doxc """
  Add two numbers together

  """
  def add(a, b \\ 1) do
    a + b
  end
  
  @doxc """
  Subtract two numbers

  """
  def subtract(b, a) do
    b - a
  end
end
