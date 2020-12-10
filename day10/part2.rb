adapters = $stdin.readlines.map(&:to_i).sort

memo = {}
([0] + adapters).each do |a|
  memo[a] = adapters.select { |b| b > a && b <= (a + 3) }
end

device = adapters.max + 3
stack = [0]
count = 0

until stack.empty? do
  this = stack.pop
  nxt = memo[this]
  if nxt.empty?
    count += 1 if (this + 3) >= device
  else
    stack += nxt
  end
end

puts count
