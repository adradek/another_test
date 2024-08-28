require 'set'

def stop_script(message)
  STDERR.puts message
  exit 1
end

amount, top = ARGV.values_at(0, 1).map(&:to_i)

stop_script("Wrong argument: Amount must be int larger than 0 (in fact #{ARGV[0].inspect})") if amount <= 0
stop_script("Wrong argument: Top must be int larger than 1 (in fact #{ARGV[1].inspect})") if top <= 1
stop_script("Wrong argument: Top (#{top}) should be larger than Amount (#{amount})") if amount >= top

storage = Set.new

while storage.size < amount do
  storage.add(rand top)
end

puts storage.to_a.sort
