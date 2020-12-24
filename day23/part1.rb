cups = $stdin.read.strip.chars.map(&:to_i)

current = 0

100.times do
  this = cups[current]
  pickup = (cups + cups)[(current+1)..(current+3)]
  pickup.each { |cup| cups.delete(cup) }
  lower = cups.select { |cup| cup < this }
  destination = cups.index(lower.empty? ? cups.max : lower.max)
  cups.insert(destination + 1, pickup)
  cups.flatten!
  current = (cups.index(this) + 1) % cups.length
end

dcups = cups + cups
s = dcups.index(1) + 1
r = ""
(cups.length - 1).times do
  r += dcups[s].to_s
  s += 1
end

puts r
