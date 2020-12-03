grid = $stdin.readlines.map(&:strip).map(&:chars)

h = grid.length
w = grid[0].length

slopes = [[1,1], [3,1], [5,1], [7,1], [1,2]]
trees = []

slopes.each do |dx, dy|
  x = 0
  y = 0
  t = 0

  while y < h do
    t += 1 if grid[y][x] == '#'
    x += dx
    x %= w
    y += dy
  end

  trees << t
end

puts trees.inject(:*)
