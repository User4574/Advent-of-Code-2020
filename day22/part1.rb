player1 = []
player2 = []
deck = player1

$stdin.readlines.map(&:strip).each do |line|
  case line
  when /^$/
    deck = player2
  when /^\d+$/
    deck << line.to_i
  end
end

until player1.empty? || player2.empty? do
  p1 = player1.shift
  p2 = player2.shift

  if p1 > p2
    player1 << p1
    player1 << p2
  else
    player2 << p2
    player2 << p1
  end
end

deck = player1.empty? ? player2 : player1
puts deck.reverse.each_with_index.to_a.map { |e| e[0] * (e[1] + 1) }.sum
