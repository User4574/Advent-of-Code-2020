class Expr
  def initialize(string)
    @str = string.chars
    @expr = parse!
  end

  def evaluate(expr = @expr)
    result = 0
    op = ?+

    expr.each do |term|
      case term
      when String
        op = term
      when Numeric
        case op
        when ?+
          result += term
        when ?*
          result *= term
        end
      when Array
        case op
        when ?+
          result += evaluate(term)
        when ?*
          result *= evaluate(term)
        end
      end
    end

    result
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
