adapters = $stdin.readlines.map(&:to_i).sort

last = 0
diffs = adapters.map { |a| t = a-last; last = a; t }

puts diffs.count(1) * (diffs.count(3) + 1)
