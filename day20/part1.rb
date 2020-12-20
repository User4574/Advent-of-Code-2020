def to_num(chars)
  chars.join.tr('.#', '01').to_i(2)
end

def reverse(edge)
  ("%010b" % edge).reverse.to_i(2)
end

tiles = {}

tileid = 0
tile = []
$stdin.readlines.map(&:strip).each do |line|
  case line
  when /^$/
    tiles[tileid] = tile
    tile = []
  when /^Tile/
    tileid = line[5..-2].to_i
  else
    tile << line.chars
  end
end
tiles[tileid] = tile

size = Math.sqrt(tiles.length).to_i

tileedges = {}
tiles.each do |id, pix|
  tileedges[id] = [
    to_num(pix[0]),
    to_num(pix.transpose[-1]),
    to_num(pix[-1]),
    to_num(pix.transpose[0]),
  ]
end

tids = tileedges.keys

cornerids = tileedges.map { |tid, edges|
  allotheredges = []

  tileedges.each do |id, dges|
    next if id == tid
    dges.each do |dge|
      allotheredges << dge
      allotheredges << reverse(dge)
    end
  end

  [tid, edges - allotheredges]
}.select { |id, edges| edges.length == 2 }.map(&:first)

puts cornerids.inject(&:*)
