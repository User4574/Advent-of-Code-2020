cardpk, doorpk = $stdin.readlines.map(&:strip).map(&:to_i)

cardsn = 7
cardtn = 1
doorsn = doorpk
doortn = 1
until cardtn == cardpk do
  cardtn *= cardsn
  cardtn %= 20201227
  doortn *= doorsn
  doortn %= 20201227
end

enk = doortn

puts enk
