class Expr
  def initialize(string)
    @str = string.chars
    @expr = parse!
  end

  def evaluate(expr = @expr)
    expr = expr.map do |term|
      if term.is_a?(Array)
        evaluate(term)
      else
        term
      end
    end

    idx = expr.length
    while idx >= 0 do
      if expr[idx] == ?+
        expr[idx] = expr[idx - 1] + expr[idx + 1]

        expr[idx - 1] = nil
        expr[idx + 1] = nil

        expr = expr.compact
      end

      idx -= 1
    end

    idx = expr.length
    while idx >= 0 do
      if expr[idx] == ?*
        expr[idx] = expr[idx - 1] * expr[idx + 1]

        expr[idx - 1] = nil
        expr[idx + 1] = nil

        expr = expr.compact
      end

      idx -= 1
    end

    expr[0]
  end

  private

  def parse!
    expr = []

    until @str.empty? do
      case @str[0]
      when /\s/
        @str.shift
      when /[0-9]/
        num = 0
        while @str[0] =~ /[0-9]/
          num *= 10
          num += @str.shift.to_i
        end
        expr << num
      when ?+
        expr << @str.shift
      when ?*
        expr << @str.shift
      when ?(
        @str.shift
        expr << parse!
      when ?)
        @str.shift
        break
      end
    end

    expr
  end
end

pp $stdin.readlines.map { |line| Expr.new(line.strip).evaluate }.sum
