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

blacks = []

$stdin.readlines.map(&:strip).each do |path|
  c = coord(path)
  if blacks.include?(c)
    blacks.delete(c)
  else
    blacks.push(c)
  end
end

puts blacks.length
