class ArgumentsParser
  class ParserError < RuntimeError; end

  DEFAULT_SIZE = 2

  attr_reader :size, :number

  def self.call(args)
    self.new(args).call
  end

  def initialize(args)
    @args = args
  end

  def call
    set_size
    set_number
    self
  end

  private

  attr_reader :args

  def set_size
    @size ||=
      if (flag_position = args.index("-v"))
        _size = args[flag_position + 1].to_i
        raise ParserError.new("Wrong size argument (#{_size}), args: #{args.inspect}") if _size <=0
        _size
      else
        DEFAULT_SIZE
      end
  end

  def set_number
    @number ||= begin
      n = args[0] == '-v' ? args[2] : args[0]
      raise ParserError.new("Number argument must be present, args: #{args.inspect}") unless n
      n
    end
  end
end
