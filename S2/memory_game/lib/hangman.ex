defmodule MemoryGame.Hangman do
  defp select_word() do
    Enum.random(["cafetera", "mariposa","lavacara","cuaderno"])
  end

  def init_game() do
    selW = select_word()
    spaces = String.duplicate("_", String.length(selW)-2)
    w_game = String.first(selW) <> spaces <> String.last(selW)

    game(w_game, selW, 0, victim())
  end

  defp game(word_game, selW, oport, drawing) when word_game != selW and oport < 6 do
    IO.puts("Hangman v4.0")
    IO.puts(word_game)
    IO.puts(drawing)
    ing_l = IO.gets("Ingrese una letra: ") |> String.trim

    {up_word_game, oport, drawing} = case String.contains?(selW, ing_l) do
        true -> {update_word(word_game, ing_l, selW), oport, drawing}
        false -> {word_game, oport + 1, update_victim(oport+1, drawing) }
    end

    game(up_word_game, selW, oport, drawing)

  end

  defp game(word_game, selW, _ ,_) when word_game == selW, do: {:guessed, selW}

  defp game(_, _, oport, drawing) when oport == 6, do:  {:gameover}

  defp update_word(word_game, ing_l, selW) do
      mods = n_modifies(selW, ing_l)
      set_modify(mods, length(mods), word_game)
  end

  #Función para filtrar las letras a reemplazar
  defp n_modifies(selW, ing_l) do
      l_selW = String.codepoints(selW)
      Enum.filter(Enum.with_index(l_selW), fn(t) -> elem(t,0) == ing_l end)
  end

  #Función para realizar las modificaciones
  defp set_modify(l_n_mod, tot, word_game) when tot > 0 do
    t = Enum.at(l_n_mod, length(l_n_mod)-tot)
    act = String.codepoints(word_game)
          |> List.replace_at(elem(t,1), elem(t,0))
          |> Enum.join("")
    tot = tot - 1
    set_modify(l_n_mod, tot, act)
  end

  defp set_modify(_, 0, act), do: act


  defp victim() do
    """
      ____
     |    |
     1    |
    324   |
    5 6   |
         _|_
    """
  end

  defp update_victim(oport, drawing) when oport <=6 do
    partes = ["O", "|", "/", "\\", "/", "\\"]
    String.replace(drawing, to_string(oport), Enum.at(partes, oport - 1))
  end

  defp update_victim(_, drawing) , do: drawing


end

