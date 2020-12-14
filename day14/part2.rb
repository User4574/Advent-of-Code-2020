instrs = $stdin.readlines.map { |line| line.strip.split(" = ") }

mask = ""
mem = {}

def do_mask(dst, mask)
  dst = "%036b" % dst

  mask.chars.each_with_index do |bit, idx|
    next if bit == ?0
    dst[idx] = bit
  end

  addrs = []
  w = dst.count(?X)

  (2 ** w).times do |i|
    d = dst.dup
    ("%0#{w}b" % i).chars.each do |b|
      d.sub!(?X, b)
    end
    addrs << d
  end

  addrs
end

instrs.each do |dst, val|
  if dst == "mask"
    mask = val
  else
    dst = dst[0..-2].split(?[)[1].to_i
    do_mask(dst, mask).each do |d|
      mem[d] = val.to_i
    end
  end
end

p mem.values.sum
