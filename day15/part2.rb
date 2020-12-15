numbers = $stdin.readlines[0].strip.split(?,).map(&:to_i)

last_seen = {}

(numbers.length - 1).times do |i|
  last_seen[numbers[i]] = i+1
end

last = numbers[-1]

((numbers.length + 1) .. 30_000_000).each do |i|
  p = last_seen[last]
  last_seen[last] = i - 1
  last = p.nil? ? 0 : i - p - 1
end

puts last
