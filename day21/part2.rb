candidates = {}

$stdin.readlines.each do |line|
  ings, alls = line.strip[0..-2].split(' (contains ')

  ings = ings.split(' ')

  alls = alls.split(', ')
  alls.each do |all|
    if candidates[all].nil?
      candidates[all] = ings
    else
      candidates[all] &= ings
    end
  end
end

allergens = {}

while candidates.values.flatten.length > 0
  candidates.each_key do |all|
    next unless candidates[all].length == 1

    c = candidates[all][0]
    allergens[all] = c
    candidates.each_value do |ings|
      ings.delete(c)
    end
  end
end

puts allergens.sort.map(&:last).join(',')
