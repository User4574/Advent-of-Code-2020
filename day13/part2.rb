busses = $stdin.readlines[1].strip.split(?,)

congruences = []

t = -1
busses.each do |bus|
  t += 1
  next if bus == ?x
  bus = bus.to_i
  congruences << [-t % bus, bus]
end

congruences.sort! do |a, b|
  b[1] <=> a[1]
end

t = congruences[0][0]
iter = congruences[0][1]

(congruences.length - 1).times do |x|
  while t % congruences[x+1][1] != congruences[x+1][0] do
    t += iter
  end
  iter *= congruences[x+1][1]
end

puts t
