class Password
  class Policy
    def initialize(policy)
      count, @char = policy.split
      @min, @max = count.split("-").map(&:to_i)
    end

    def match(password)
      tally = password.chars.tally
      inquestion = tally[@char] || 0
      inquestion >= @min && inquestion <= @max
    end
  end

  def initialize(policy, password)
    @policy = Policy.new(policy)
    @password = password
  end

  def valid?
    @policy.match(@password)
  end
end

passwords = $stdin.readlines.map{|line| Password.new(*line.split(":").map(&:strip))}

puts passwords.select(&:valid?).count
