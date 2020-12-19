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

rules[8] << [42, 8]
rules[11] << [42, 11, 31]

def gen_bit(idx, rls)
  bit = "(?<bit#{idx}>"
  if rls[idx].is_a?(String)
    bit += rls[idx]
  else
    if rls[idx].length > 1
      bit += ?(
      rls[idx].each do |opt|
        opt.each do |subidx|
          if subidx == idx
            bit += "\\g<bit#{idx}>"
          else
            bit += gen_bit(subidx, rls)
          end
        end
        bit += ?|
      end
      bit[-1] = ?)
    else
      rls[idx][0].each do |subidx|
        if subidx == idx
          bit += "\\g<bit#{idx}>"
        else
          bit += gen_bit(subidx, rls)
        end
      end
    end
  end
  bit + ")"
end

re = Regexp.new(?^ + gen_bit(0, rules) + ?$)

puts messages.count { |msg| re.match?(msg) }
