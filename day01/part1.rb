puts $stdin.readlines.map(&:to_i).permutation(2).select{|x,y|x+y==2020}[0].inject(:*)
