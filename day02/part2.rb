class Password
  class Policy
    def initialize(policy)
      positions, @char = policy.split
      @first, @second = positions.split("-").map{|p| p.to_i - 1}
    end

    def match(password)
      (password[@first] == @char) ^ (password[@second] == @char)
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
