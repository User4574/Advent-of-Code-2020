instrs = $stdin.readlines.map { |line| line.strip.split(" = ") }

omask = 0
zmask = (2**36) - 1
mem = {}

def gen_masks(m)
  [
    m.tr('X', '0').to_i(2),
    m.tr('X', '1').to_i(2)
  ]
end

def do_mask(val, om, zm)
  (val | om) & zm
end

instrs.each do |dst, val|
  if dst == "mask"
    omask, zmask = gen_masks(val)
  else
    dst = dst[0..-2].split(?[)[1].to_i
    mem[dst] = do_mask(val.to_i, omask, zmask)
  end
end

p mem.values.sum
