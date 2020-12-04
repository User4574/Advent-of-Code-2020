input = $stdin.readlines.map(&:strip)

class Passport
  def initialize(str)
    fields = str.split(" ").map { |field| field.split(":") }.to_h
    @byr = fields["byr"]
    @iyr = fields["iyr"]
    @eyr = fields["eyr"]
    @hgt = fields["hgt"]
    @hcl = fields["hcl"]
    @ecl = fields["ecl"]
    @pid = fields["pid"]
    @cid = fields["cid"]
  end

  def valid?
    return false unless !@byr.nil? && @byr.length == 4 && @byr.to_i >= 1920 && @byr.to_i <= 2002
    return false unless !@iyr.nil? && @iyr.length == 4 && @iyr.to_i >= 2010 && @iyr.to_i <= 2020
    return false unless !@eyr.nil? && @eyr.length == 4 && @eyr.to_i >= 2020 && @eyr.to_i <= 2030
    return false unless !@hgt.nil?
    case @hgt[-2..-1]
    when "cm"
      return false unless @hgt.to_i >= 150 && @hgt.to_i <= 193
    when "in"
      return false unless @hgt.to_i >= 59 && @hgt.to_i <= 76
    else
      return false
    end
    return false unless !@hcl.nil? && @hcl =~ /\A#[0-9a-f]{6}\Z/
    return false unless !@ecl.nil? && %w(amb blu brn gry grn hzl oth).include?(@ecl)
    return false unless !@pid.nil? && @pid =~ /\A[0-9]{9}\Z/

    return true
  end
end

valid = 0

until input.nil? do
  passport = input.take_while {|line| !line.empty?}.to_a
  input = input[(passport.length + 1) .. -1]
  passport = Passport.new(passport.join(" "))
  valid += 1 if passport.valid?
end

puts valid
