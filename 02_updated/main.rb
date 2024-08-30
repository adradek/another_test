require_relative "checker.rb"

# string = "поедемвхолмогорыкоростылев"
# dictionary = ["коростылев", "поедем", "ы", "в", "холмогоры"]
string     = "поедемвхолмогорыкоростылевивгоры"
dictionary = ["коростылев", "поедем", "ы", "и", "в", "холмогоры", "холм", "горы"]

puts "String: #{string.inspect}"
puts "Dictionary: #{dictionary.inspect}"
puts "------------------------"

checker = Checker.new(string, dictionary)
p checker.possible_to_assemble?
puts checker.found_partition || "Impossible to assemble the string from dictionary words"
