puts $stdin.readlines.map { |seat| seat.strip.upcase.tr("FBLR", "0101").to_i(2) }.max
