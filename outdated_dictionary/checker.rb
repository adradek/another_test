require_relative 'partition.rb'

class Checker
  attr_reader :line, :dictionary

  def initialize(line, dictionary)
    @line = line
    @dictionary = dictionary
  end

  def possible_to_assemble?
    return @possible unless @possible.nil?

    partitions = [Partition.new([line])]

    dictionary.each_with_index do |word, index|
      new_partitions = []

      partitions.each do |partition|
        partition.replace_word(word, index).each do |new_partition|
          if new_partition.solution?
            @possible = true
            @solution = new_partition
            return @possible
          end

          new_partitions << new_partition
        end
      end

      partitions.concat(new_partitions)
    end

    @possible = false
  end

  def display_found_partition
    return puts "Impossible to assemble the line from dictionary words" unless possible_to_assemble?

    puts @solution.content.map { |i| "#{dictionary[i]}:#{i}" }.join(" ").inspect
  end
end
