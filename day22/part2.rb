def play_game(player1, player2)
  rounds = []
  loop do
    if player1.empty? || player2.empty?
      return [player1, player2]
    elsif rounds.include?([player1, player2])
      return [[1], []]
    else
      rounds << [player1.dup, player2.dup]
      p1 = player1.shift
      p2 = player2.shift
      if player1.length >= p1 && player2.length >= p2
        sgp1, sgp2 = play_game(player1.take(p1), player2.take(p2))
        if sgp1.empty?
          player2 << p2
          player2 << p1
        else
          player1 << p1
          player1 << p2
        end
      else
        if p1 > p2
          player1 << p1
          player1 << p2
        else
          player2 << p2
          player2 << p1
        end
      end
    end
  end
end


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

player1, player2 = play_game(player1.dup, player2.dup)

deck = player1.empty? ? player2 : player1
puts deck.reverse.each_with_index.to_a.map { |e| e[0] * (e[1] + 1) }.sum
