rules = {}
messages = []
section = :rules

$stdin.readlines.map(&:strip).each do |line|
  if line.empty?
    section = :messages
  elsif section == :rules
    from, to = line.split(': ')
    from = from.to_i
    if to =~ /"[a-z]"/
      rules[from] = to[1]
    else
      rules[from] = to.split(' | ').map { |opt|
        opt.split(' ').map(&:to_i)
      }
    end
  elsif section == :messages
    messages << line
  end
end

def gen_bit(idx, rls)
  if rls[idx].is_a?(String)
    return rls[idx]
  else
    if rls[idx].length > 1
      bit = ?(
      rls[idx].each do |opt|
        opt.each do |subidx|
          bit += gen_bit(subidx, rls)
        end
        bit += ?|
      end
      bit[-1] = ?)
      return bit
    else
      bit = ''
      rls[idx][0].each do |subidx|
        bit += gen_bit(subidx, rls)
      end
      return bit
    end
  end
end

re = Regexp.new(?^ + gen_bit(0, rules) + ?$)

puts messages.count { |msg| re.match?(msg) }
