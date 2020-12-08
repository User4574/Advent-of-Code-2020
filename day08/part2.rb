instrs = $stdin.readlines.map { |line|
  l = line.strip.split
  l[0] = l[0].intern
  l[1] = l[1].to_i
  l
}

class Machine
  def initialize(instrs)
    @program = instrs
    @pc = 0
    @acc = 0
  end

  attr_reader :acc

  def reset
    @pc = 0
    @acc = 0
  end

  def swap_instr_nop_jmp(idx)
    if @program[idx][0] == :jmp
      @program[idx][0] = :nop
    elsif @program[idx][0] == :nop
      @program[idx][0] = :jmp
    end
  end

  def run_until_terminate_or_timeout(timeout = 10000)
    timeout.times do
      return true if @pc >= @program.length
      step!
    end

    return false
  end

  def step!
    opcode, arg = @program[@pc]
    case opcode
    when :acc
      @acc += arg
      @pc += 1
    when :jmp
      @pc += arg
    when :nop
      @pc += 1
    end
  end
end

m = Machine.new(instrs)
at = 0

while at < instrs.length do
  m.reset
  m.swap_instr_nop_jmp(at)

  if m.run_until_terminate_or_timeout
    puts m.acc
    break
  end

  m.swap_instr_nop_jmp(at)
  at += 1
end
