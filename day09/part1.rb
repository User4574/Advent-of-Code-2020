msg = $stdin.readlines.map(&:to_i)
D = 25

def find_pairs(ary, sum)
  ary.combination(2).select { |a,b| a+b == sum }
end

(D...msg.length).each do |x|
  a = msg[x-D...x]
  if find_pairs(a, msg[x]).empty?
    puts msg[x]
    exit
  end
end
