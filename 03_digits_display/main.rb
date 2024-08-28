require_relative "arguments_parser.rb"
require_relative "print_number.rb"

begin
  args = ArgumentsParser.call(ARGV)
rescue ArgumentsParser::ParserError => e
  STDERR.puts "Arguments error: #{e.message}"
  exit 1
end

PrintNumber.new(args.number, args.size).call
