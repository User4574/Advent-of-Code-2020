rules = Hash.new { |h,k| h[k] = [] }

$stdin.readlines.each { |line|
  outer, inner = line.strip.gsub(/\.$/, '').split(" bags contain ")

  unless inner == "no other bags"
    inner.split(", ").map{ |bag|
      bag.gsub(/ bags?$/, '')
    }.map{ |bag|
      bag.split[1..-1].join(" ")
    }.each { |bag|
      rules[bag] << outer
    }
  end
}

to_check = []
checked = []

to_check += rules["shiny gold"]

until to_check.empty? do
  this = to_check.shift
  rules[this].each do |bag|
    to_check << bag unless checked.include?(bag)
  end
  checked << this unless checked.include?(this)
end

puts checked.count
