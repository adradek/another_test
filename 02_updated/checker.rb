class Checker
  attr_reader :string, :dictionary, :markup

  def initialize(string, dictionary)
    @string = string
    @dictionary = dictionary
    markup_word_beginnings
  end

  def possible_to_assemble?
    return @possible unless @possible.nil?
    @possible = check_possibility(0)
  end

  def found_partition
    @solution.map { |i| "#{dictionary[i]}:#{i}" }.join(" ") if possible_to_assemble?
  end

  private

  # Составляем хэш, ключом будет индекс в строке, а значением - массив с индексами слов в словаре
  def markup_word_beginnings
    @markup = Hash.new { |h, k| h[k] = [] }

    dictionary.each_with_index do |word, i|
      j = 0

      while (k = string[j..].index(word))
        @markup[j + k] << i
        j = j + k + 1
      end
    end
  end

  def check_possibility(string_index, solution = [])
    if string_index == string.size
      @solution = solution
      return true
    end

    return false if (matching_words = markup[string_index]).empty?

    matching_words.each do |dictionary_index|
      word = dictionary[dictionary_index]
      result = check_possibility(string_index + word.size, solution + [dictionary_index])
      return result if result
    end

    false
  end
end
