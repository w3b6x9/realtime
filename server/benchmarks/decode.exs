# Run `cd server && mix run benchmarks/decode.exs`

%{
  "decode_insert" => fn input ->
    Enum.each(input, fn _ ->
      Realtime.Decoder.decode_message(
        <<73, 0, 4, 3, 47, 78, 0, 2, 116, 0, 0, 0, 2, 50, 51, 116, 0, 0, 0, 16, 83, 97, 109, 97,
          110, 116, 104, 97, 32, 75, 97, 117, 116, 122, 101, 114>>
      )
    end)
  end
}
|> Benchee.run(
  inputs: %{
    "Small" => Enum.to_list(1..10_000),
    "Medium" => Enum.to_list(1..100_000),
    "Bigger" => Enum.to_list(1..1_000_000)
  }
)

"""

Results on my machine:

MacOSX 10.7 or later required for --file-events
Operating System: macOS
CPU Information: Intel(R) Core(TM) i7-5557U CPU @ 3.10GHz
Number of Available Cores: 4
Available memory: 16 GB
Elixir 1.11.2
Erlang 23.1.4

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 5 s
memory time: 0 ns
parallel: 1
inputs: Bigger, Medium, Small
Estimated total run time: 21 s

Benchmarking decode_insert with input Bigger...
Benchmarking decode_insert with input Medium...
Benchmarking decode_insert with input Small...

##### With input Bigger #####
Name                    ips        average  deviation         median         99th %
decode_insert          1.07      938.38 ms    ±11.35%      916.73 ms     1125.79 ms

##### With input Medium #####
Name                    ips        average  deviation         median         99th %
decode_insert         11.32       88.35 ms    ±14.35%       83.16 ms      120.92 ms

##### With input Small #####
Name                    ips        average  deviation         median         99th %
decode_insert        115.33        8.67 ms    ±29.75%        7.96 ms       18.17 ms

"""
