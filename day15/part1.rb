numbers = $stdin.readlines[0].strip.split(?,).map(&:to_i)

(2020 - numbers.length).times do
  last = numbers[-1]
  if numbers.count(last) == 1
    numbers << 0
  else
    numbers << (numbers.reverse[1..-1].index(last) + 1)
  end
end

puts numbers[-1]
