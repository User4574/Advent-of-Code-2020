input = $stdin.readlines.map(&:strip)

class Passport
  def initialize(str)
    fields = str.split(" ").map { |field| field.split(":") }.to_h
    @byr = fields["byr"]
    @iyr = fields["iyr"]
    @ecy = fields["eyr"]
    @hgt = fields["hgt"]
    @hcl = fields["hcl"]
    @ecl = fields["ecl"]
    @pid = fields["pid"]
    @cid = fields["cid"]
  end

  def valid?
    [@byr, @iyr, @ecy, @hgt, @hcl, @ecl, @pid].compact.length >= 7
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
