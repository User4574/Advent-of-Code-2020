grid = $stdin.readlines.map { |line| line.strip.chars }

def iterate(g, r, c)
  case g[r][c]
  when '.'
    return '.'
  when 'L'
    return surround(g, r, c) == 0 ? '#' : 'L'
  when '#'
    return surround(g, r, c) >= 5 ? 'L' : '#'
  end
end

def occupied(g, r, c, dr, dc)
  loop do
    r += dr
    c += dc
    return false if r < 0 || c < 0 || r >= g.length || c >= g[0].length
    return false if g[r][c] == 'L'
    return true if g[r][c] == '#'
  end
end

def surround(g, r, c)
  sum = 0

  [[-1, -1], [-1,  0], [-1,  1],
   [ 0, -1],           [ 0,  1],
   [ 1, -1], [ 1,  0], [ 1,  1]].each do |dr, dc|
    sum += 1 if occupied(g, r, c, dr, dc)
  end

  sum
end

loop do
  nextgrid = []
  grid.length.times do |r|
    nextgrid[r] = []
    grid[r].length.times do |c|
      nextgrid[r][c] = iterate(grid, r, c)
    end
  end
  break if grid == nextgrid
  grid = nextgrid
end

puts grid.flatten.count('#')
