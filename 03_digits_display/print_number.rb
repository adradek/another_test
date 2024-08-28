class PrintNumber
  # Кодируем, какие сектора электронного табло включаюся при отображении каждой цифры:
  # 1 - зажигаем "кристалл", 0 - не зажигаем
  # порядок секторов: сверху-вниз, слева-направо, т.е. первый элемент массива отвечает за верхнюю перекладину,
  # затем две верхние штанги (двухбитовое число), середина итд

  DIGITS = {
    "0" => %w[1 11 0 11 1],
    "1" => %w[0 01 0 01 0],
    "2" => %w[1 01 1 10 1],
    "3" => %w[1 01 1 01 1],
    "4" => %w[0 11 1 01 0],
    "5" => %w[1 10 1 01 1],
    "6" => %w[1 10 1 11 1],
    "7" => %w[1 01 0 01 0],
    "8" => %w[1 11 1 11 1],
    "9" => %w[1 11 1 01 1],
  }
    .map { |k, v| [k, v.map { |s| s.to_i(2) }] }
    .to_h

  attr_reader :number, :size

  def initialize(number, size)
    @number = number
    @size = size
  end

  def call
    5.times { |sector| print_sector(sector) }
  end

  private

  def print_sector(sector)
    sector.even? ?
      print_horizontal_sector(sector) :
      print_vertical_sector(sector)
  end

  def print_horizontal_sector(sector)
    line = number
      .each_char
      .map do |digit|
        filling = DIGITS[digit][sector] == 1 ? '-' : ' '
        " #{filling * size} "
      end
      .join(delimeter)

    puts line
  end

  def print_vertical_sector(sector)
    line = number
      .each_char
      .map do |digit|
        first_filling  = DIGITS[digit][sector] / 2 == 1 ? '|' : ' '
        second_filling = DIGITS[digit][sector] % 2 == 1 ? '|' : ' '

        "#{first_filling}#{delimeter}#{second_filling}"
      end
      .join(delimeter)

    size.times { puts line }
  end

  def delimeter
    @delimeter ||= " " * size
  end
end
