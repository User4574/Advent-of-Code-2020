lines = $stdin.readlines.map(&:strip)

groups = []

until lines.nil? do
  group = lines.take_while { |line| !line.empty? }
  lines = lines[(group.length + 1)..-1]
  groups << group.map(&:chars).flatten.uniq
end

puts groups.map(&:count).sum
