adapters = $stdin.readlines.map(&:to_i).sort

memo = {}
([0] + adapters).each do |a|
  memo[a] = adapters.select { |b| b > a && b <= (a + 3) }
end

memo[adapters.max] = 1

(adapters.reverse[1..-1] + [0]).each do |a|
  memo[a] = memo[a].map { |p| memo[p] }.sum
end

puts memo[0]
