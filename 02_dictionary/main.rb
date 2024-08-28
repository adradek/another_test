require_relative "checker.rb"

string = "поедемвхолмогорыкоростылев"
dictionary = ["коростылев", "поедем", "ы", "в", "холмогоры"]

puts "String: #{string.inspect}"
puts "Dictionary: #{dictionary.inspect}"
puts "------------------------"

checker = Checker.new(string, dictionary)
checker.display_found_partition
p checker.possible_to_assemble?
