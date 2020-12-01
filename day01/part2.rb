puts $stdin.readlines.map(&:to_i).permutation(3).select{|x,y,z|x+y+z==2020}[0].inject(:*)
