grid = $stdin.readlines.map(&:strip).map(&:chars)

h = grid.length
w = grid[0].length

slope = 3
x = 0
y = 0

trees = 0

while y < h do
  trees += 1 if grid[y][x] == '#'
  x += slope
  x %= w
  y += 1
end

puts trees
