defmodule Parser do
  # def float(string) do
  #   [char | tail] = String.to_charlist(string)
  #   rest = Enum.join(tail)
  #   float = case char do
  #     c when c in ?0..?9 -> c  float(rest)
  #     _ -> ""
  #   end

  #   {float, rest}
  # end

  def digits(charlist) do
    case charlist do
      [c | tail] when c in ?0..?9 ->
                              {d, r} = digits(tail)
                              {[c | d], r}
      _ -> {[], charlist}
    end
  end

  def letters(charlist) do
    case charlist do
      [c | tail] when c in ?A..?z ->
                              {d, r} = letters(tail)
                              {[c | d], r}
      _ -> {[], charlist}
    end
  end
end
