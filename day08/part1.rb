instrs = $stdin.readlines.map { |line|
  l = line.strip.split
  l[0] = l[0].intern
  l[1] = l[1].to_i
  l
}

class Machine
  def initialize(instrs)
    @program = instrs
    @icount = [0] * @program.count
    @pc = 0
    @acc = 0
  end

  def run_until_second_time
    loop do
      return nil if @pc >= @program.length
      acc = step!
      return acc unless acc.nil?
    end
  end

  def step!
    if @icount[@pc] == 1
      return @acc
    end

    opcode, arg = @program[@pc]
    @icount[@pc] += 1

    case opcode
    when :acc
      @acc += arg
      @pc += 1
    when :jmp
      @pc += arg
    when :nop
      @pc += 1
    end

    return nil
  end
end

m = Machine.new(instrs)
puts m.run_until_second_time
