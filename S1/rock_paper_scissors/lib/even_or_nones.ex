IO.puts("Let's gonna play even or nones")

n0 = IO.gets("Input a number [1] Even or [2] None: ") |> String.trim |> String.to_integer

if (n0 < 0 && n0 > 3) do
  IO.puts("Sorry fella this option does not exist!")
end

n1 = IO.gets("Input a number between 0 - 5: ") |> String.trim |> String.to_integer

if (n1 > 6) do
  IO.puts("WTF! - this options does not exist, are you alien?")
else
  op = Enum.random(0..5)
  IO.puts("My hand says ... #{op}")

  rsl = rem((n1 + op), 2)

  cond do
    (rsl == 0 && n0 == 1) -> IO.puts("cpu: You win!!!")
    (rsl !== 0 && n0 == 2) -> IO.puts("cpu: You win!!!")
    true -> IO.puts("cpu: You loss... I won!!!")
  end

end