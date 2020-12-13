input = $stdin.readlines.map(&:strip)

earliest_depart = input[0].to_i
depart = earliest_depart
busses = input[1].split(?,).map { |x| x == ?x ? nil : x.to_i }.compact

loop do
  busses.each do |bus|
    if depart % bus == 0
      puts bus * (depart - earliest_depart)
      exit
    end
  end
  depart += 1
end
