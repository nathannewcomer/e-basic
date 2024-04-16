defmodule Parser do
  def parse(parser, input) do
    charlist = String.to_charlist(input)
    parser.(charlist).()
  end

  # matches any parser function passed to it
  def any(functions) do
    fn(charlist) ->
      matches = Enum.map(functions, fn(func) -> func.(charlist) end)
      find = fn (term) ->
        case term do
          {result, rest} -> true
          _ -> false
        end
      end
      Enum.find(matches, {[], charlist} ,find)
    end
  end

  # matches the parsers passed to it in sequence
  #def compose(functions) do
  #  Enum.reduce(functions, )
  #end

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

  def operator(charlist) do
    fn () ->
      [char | tail] = charlist
      case char do
        ?+ -> {:plus, tail}
        ?- -> {:minus, tail}
        ?* -> {:star, tail}
        ?/ -> {:slash, tail}
        _ -> {[], charlist}
      end
    end
  end
end
