instrs = $stdin.readlines.map { |line|
  line = line.strip
  [line[0], line[1..-1].to_i]
}

heading = 90
easting = 0
northing = 0

instrs.each do |cmd, val|
  case cmd
  when ?N
    northing += val
  when ?S
    northing -= val
  when ?E
    easting += val
  when ?W
    easting -= val
  when ?L
    heading -= val
    heading %= 360
  when ?R
    heading += val
    heading %= 360
  when ?F
    case heading
    when 0
      northing += val
    when 90
      easting += val
    when 180
      northing -= val
    when 270
      easting -= val
    end
  end
end

puts northing.abs + easting.abs
