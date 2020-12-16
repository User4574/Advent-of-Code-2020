section = :rules

rules = {}
my_ticket = nil
nearby_tickets = []

$stdin.readlines.map(&:strip).each do |line|
  case line
  when /^\s*$/
    next
  when /^your ticket:$/
    section = :your_ticket
  when /^nearby tickets:$/
    section = :nearby_tickets
  else
    case section
    when :rules
      field, fieldrules = line.split(": ")
      fieldrules = fieldrules.split(" or ").map { |rule| s, e = rule.split("-").map(&:to_i); s..e }
      rules[field] = fieldrules
    when :your_ticket
      my_ticket = line.split(?,).map(&:to_i)
    when :nearby_tickets
      nearby_tickets << line.split(?,).map(&:to_i)
    end
  end
end

invalid_sum = 0

nearby_tickets.each do |ticket|
  ticket.each do |value|
    valid = false
    rules.values.flatten.each do |range|
      valid ||= range.include?(value)
    end
    invalid_sum += value unless valid
  end
end

p invalid_sum
