class Partition
  attr_reader :content

  def initialize(content_array)
    raise "content should not be empty" if content_array.empty?
    @content = content_array
  end

  def replace_word(word, dictionary_index)
    result = []

    content.each_with_index do |item, i|
      next unless item.is_a?(String)
      next unless (subcontents = decompose(item, word, dictionary_index))

      subcontents.each do |sub|
        content_copy = content.map(&:dup)
        content_copy[i] = sub
        result << Partition.new(content_copy.flatten)
      end
    end

    result
  end

  def solution?
    content.all? { |x| x.is_a?(Integer) }
  end

  private

  # Ищет включения слова в строке и разбивает строку на части,
  # заменяя слово на индекс, например `decompose("tuktuktuk", "tuk", 0)` вернет
  # [[0, "tuktuk"], ["tuk", 0, "tuk"], ["tuktuk", 0]]
  def decompose(string, word, index)
    partition = string.split(word, -1)
    return nil if partition.size == 1

    (partition.size - 1).times.map do |i|
      [
        partition[0..i].join(word),
        index,
        partition[(i + 1)..-1].join(word)
      ]
        .reject { |x| x == '' }
    end
  end
end
