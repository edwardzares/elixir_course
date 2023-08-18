IO.puts("Let's gonna play Rock - Paper - Scissors")
options = [:rock, :paper, :scissor]

n1 = IO.gets("Input a number of one option: [1] Rock - [2] Paper - [3] Scissor: ") |> String.trim |> String.to_integer

if (n1 < 0 && n1 > 4) do
  IO.puts("WTF! - this options does not exist")
else
  op = Enum.random(options)
  IO.puts("My hand says ... #{op}")

  res_cpu = case op do
    :rock -> 1
    :paper -> 2
    :scissor -> 3
  end

  cond do
    res_cpu == n1 -> IO.puts("cpu: Tie!!")
    (res_cpu == 1 && n1 == 3) -> IO.puts("cpu: I win!!")
    (res_cpu == 2 && n1 == 1) -> IO.puts("cpu: I win!!")
    (res_cpu == 3 && n1 == 2) -> IO.puts("cpu: I win!!")
    res_cpu -> IO.puts("cpu: You win!!!")
  end
end