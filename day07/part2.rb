rules = {}

$stdin.readlines.each { |line|
  outer, inner = line.strip.gsub(/\.$/, '').split(" bags contain ")

  if inner =~ /no other/
    inner = []
  else
    inner = inner.split(", ").map{ |bag|
      bag.gsub(/ bags?$/, '')
    }.map{ |bag|
      baga = bag.split
      [baga[0].to_i, baga[1..-1].join(" ")]
    }
  end

  rules[outer] = inner
}

count = 0
queue = rules["shiny gold"]

until queue.empty? do
  this = queue.shift
  count += this[0]
  this[0].times { queue += rules[this[1]] }
end

puts count
