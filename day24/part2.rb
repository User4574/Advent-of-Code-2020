def coord(path)
  e = 0
  ne = 0
  path = path.chars
  until path.empty? do
    s = path.shift
    case s
    when ?e
      e += 1
    when ?w
      e -= 1
    when ?n
      t = path.shift
      case t
      when ?e
        ne += 1
      when ?w
        e -= 1
        ne += 1
      end
    when ?s
      t = path.shift
      case t
      when ?e
        e += 1
        ne -= 1
      when ?w
        ne -= 1
      end
    end
  end
  [e, ne]
end

def neighbour_count(grid, e, ne)
  w = grid[0].length - 1
  h = grid.length - 1

  s = 0

  s += 1 if ne < h && e > 0 && grid[ne+1][e-1] 
  s += 1 if ne < h &&          grid[ne+1][e  ]
  s += 1 if           e < w && grid[ne  ][e+1]
  s += 1 if ne > 0 && e < w && grid[ne-1][e+1]
  s += 1 if ne > 0 &&          grid[ne-1][e  ]
  s += 1 if           e > 0 && grid[ne  ][e-1]

  s
end

def iterate(grid)
  newgrid = Array.new(grid.length) { Array.new(grid[0].length) { false } }

  grid.length.times do |ne|
    grid[ne].length.times do |e|
      nc = neighbour_count(grid, e, ne)
      newgrid[ne][e] = grid[ne][e] ? (nc == 1 || nc == 2) : (nc == 2)
    end
  end

  newgrid
end

blacks = []

$stdin.readlines.map(&:strip).each do |path|
  c = coord(path)
  if blacks.include?(c)
    blacks.delete(c)
  else
    blacks.push(c)
  end
end

wid = blacks.map(&:first).max - blacks.map(&:first).min
wid += 1 if wid.odd?
hei = blacks.map(&:last).max - blacks.map(&:last).min
hei += 1 if hei.odd?

wid += 202
hei += 202

grid = Array.new(hei) { Array.new(wid) { false } }

blacks.each { |e, ne| grid[ne + hei / 2][e + wid / 2] = true }

100.times do
  grid = iterate(grid)
end

puts grid.flatten.count(true)
