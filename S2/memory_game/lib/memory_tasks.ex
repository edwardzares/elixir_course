defmodule MemoryGame.MemoryTasks do

  import MemoryGame.MemoryUtils

  defp selected_letters(map_alphabet)  do
    vocales = get_vowels(map_alphabet, [])
    consonants = get_consonants(map_alphabet, [])
    Enum.concat(vocales, consonants)
  end

  def init_game do
    IO.puts("Juego de memoria - Elixir + PF")
    username = IO.gets("Ingrese nickname: ") |> String.trim
    sel_letters = selected_letters(alphabet_map())
    solved = load_board(sel_letters)

    game(board,solved, username, 3, 0, 0)

  end

  defp game(board_on, solved_board, player, lifes, acc_v, acc_c) when lifes > 0 and acc_v < 3 and acc_c < 3  do
    #Información del juego
    IO.puts("Player: #{player}")
    IO.puts("Lives: #{lifes}")
    IO.puts("Vowels:  #{acc_v}")
    IO.puts("Consonants:  #{acc_c}")
    IO.puts(board_on)

    #Pedido por teclado
    ing_pair = IO.gets("Input a pair x,y: ")
               |> String.trim
               |> String.split(",")
               |> Enum.map(&String.to_integer/1)
               |> List.to_tuple

    #Las coordenadas recibidas, invertirlas.
    ing_pair_r = ing_pair |> Tuple.to_list |> Enum.reverse |> List.to_tuple

    #Construyendo los pares {{letra1, posicion1},{letra2,posicion2}} que corresponde a la coordenada ingresada.
    {pair1, pair2} = raw_positions(Map.keys(solved_board),Map.values(solved_board))
                     |> Enum.filter(fn {k,_v} -> k ==  elem(ing_pair, 0) or k == elem(ing_pair, 1) end) |> List.to_tuple

    #Mostrar la selección en el tablero utilizando lo anterior
    IO.puts(reveal_cards(board_on, pair1, pair2))

    #Por completar:
    #Ver si el par ingresado es correcto, ver si corresponde a vocal o consonante, incrementar el respectivo contador y actualizar el estado del par a :found
    #Controlar si vuelve a ingresar la misma coordenada ya encontrada, mostrando un mensaje apropiado
    #Controlar si el par no es válido, mostrando un mensaje apropiado
    #Controlar que si el par es correcto, no volverlo a cubrir, debe quedar revelado.


  end

  defp game(_, _, _, lifes, acc_v, acc_c) when lifes == 0, do: {:gameover, :finished}

  defp game(_, _, _, _, acc_v, acc_c), do: {:winner}

  defp reveal_cards(board_on, pair1, pair2) do
    p1 = to_string(elem(pair1, 0))
    p2 = to_string(elem(pair2, 0))
    String.replace(board_on, "-"<>p1<>"-", elem(pair1, 1)) |> String.replace("-"<>p2<>"-", elem(pair2,1))

  end

end

#c("lib/memory/memory_tasks.ex")