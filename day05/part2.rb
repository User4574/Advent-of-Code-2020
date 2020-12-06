seats = $stdin.readlines.map { |seat| seat.strip.upcase.tr("FBLR", "0101").to_i(2) }

remaining = (0...1024).to_a - seats
at = -1

puts (remaining - remaining.take_while { |s| at += 1; s == at })[0]
