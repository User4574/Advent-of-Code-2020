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

valid_nearby_tickets = []

nearby_tickets.each do |ticket|
  ticket_valid = true

  ticket.each do |value|
    value_valid = false
    rules.values.flatten.each do |range|
      value_valid ||= range.include?(value)
    end
    ticket_valid &&= value_valid
  end

  valid_nearby_tickets << ticket if ticket_valid
end

impossible_fields = Array.new(my_ticket.length){[]}

valid_nearby_tickets.each do |ticket|
  ticket.each_with_index do |value, idx|
    rules.each do |field, ranges|
      impossible_fields[idx] << field unless ranges.any? { |range| range.include?(value) }
    end
  end
end

fields = []

((my_ticket.length - 1)..0).step(-1).each do |len|
  impossible_fields.each_with_index do |impossibles, index|
    next if impossibles.length != len
    fields[index] = (rules.keys - impossibles - fields)[0]
    break
  end
end

departure_product = 1

fields.each_with_index do |field, index|
  departure_product *= my_ticket[index] if field =~ /^departure/
end

p departure_product
