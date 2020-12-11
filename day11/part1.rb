grid = $stdin.readlines.map { |line| line.strip.chars }

def iterate(g, r, c)
  case g[r][c]
  when '.'
    return '.'
  when 'L'
    return surround(g, r, c) == 0 ? '#' : 'L'
  when '#'
    return surround(g, r, c) >= 4 ? 'L' : '#'
  end
end

def surround(g, r, c)
  h = g.length - 1
  w = g[0].length - 1

  sum = 0
  sum += 1 if r > 0 && c > 0 && g[r-1][c-1] == '#'
  sum += 1 if r > 0          && g[r-1][c  ] == '#'
  sum += 1 if r > 0 && c < w && g[r-1][c+1] == '#'
  sum += 1 if          c > 0 && g[r  ][c-1] == '#'
  sum += 1 if          c < w && g[r  ][c+1] == '#'
  sum += 1 if r < h && c > 0 && g[r+1][c-1] == '#'
  sum += 1 if r < h          && g[r+1][c  ] == '#'
  sum += 1 if r < h && c < w && g[r+1][c+1] == '#'

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
