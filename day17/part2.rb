class Grid
  def initialize(start, buffer)
    @grid = start.lines.map { |line|
      Array.new(buffer) { false } +
      line.strip.chars.map { |ch| ch == ?# } +
      Array.new(buffer) { false }
    }

    @wid = @grid[0].length

    @grid = Array.new(buffer) { Array.new(@wid) { false } } +
            @grid +
            Array.new(buffer) { Array.new(@wid) { false } }

    @dep = @grid.length

    @grid = Array.new(buffer) { Array.new(@dep) { Array.new(@wid) { false } } } +
            [@grid] +
            Array.new(buffer) { Array.new(@dep) { Array.new(@wid) { false } } }

    @hei = @grid.length

    @grid = Array.new(buffer) { Array.new(@hei) { Array.new(@dep) { Array.new(@wid) { false } } } } +
            [@grid] +
            Array.new(buffer) { Array.new(@hei) { Array.new(@dep) { Array.new(@wid) { false } } } }

    @spi = @grid.length
  end

  def iterate!
    next_grid = Array.new(@spi) { Array.new(@hei) { Array.new(@dep) { Array.new(@wid) { false } } } }

    @spi.times { |w|
      @hei.times { |z|
        @dep.times { |y|
          @wid.times { |x|
            s = neighbour_count(x, y, z, w)
            if (@grid[w][z][y][x] && s == 2) || s == 3
              next_grid[w][z][y][x] = true
            end
          }
        }
      }
    }

    @grid = next_grid
  end

  def count_active
    @grid.flatten.count(true)
  end

  private

  def neighbour_count(cx, cy, cz, cw)
    s = 0

    (-1..1).each { |dw|
      (-1..1).each { |dz|
        (-1..1).each { |dy|
          (-1..1).each { |dx|
            x = cx + dx
            y = cy + dy
            z = cz + dz
            w = cw + dw

            s += 1 if !(dx == 0 && dy == 0 && dz == 0 && dw == 0) &&
              x >= 0 && x < @wid &&
              y >= 0 && y < @dep &&
              z >= 0 && z < @hei &&
              w >= 0 && w < @spi &&
              @grid[w][z][y][x]
          }
        }
      }
    }

    s
  end
end

grid = Grid.new($stdin.read, 6)

6.times {
  grid.iterate!
}
puts grid.count_active
