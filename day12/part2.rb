instrs = $stdin.readlines.map { |line|
  line = line.strip
  [line[0], line[1..-1].to_i]
}

easting = 0
northing = 0
wde = 10
wdn = 1

instrs.each do |cmd, val|
  case cmd
  when ?N
    wdn += val
  when ?S
    wdn -= val
  when ?E
    wde += val
  when ?W
    wde -= val
  when ?L
    (val / 90).times do
      tmp = wde
      wde = -wdn
      wdn = tmp
    end
  when ?R
    (val / 90).times do
      tmp = wde
      wde = wdn
      wdn = -tmp
    end
  when ?F
    val.times do
      easting += wde
      northing += wdn
    end
  end
end

puts northing.abs + easting.abs
