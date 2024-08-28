require_relative "../../03_digits_display/arguments_parser.rb"

RSpec.describe ArgumentsParser do
  describe ".call" do
    subject(:call_result) { described_class.call(["12", "-v", "3"]) }

    it "returns an instance of the Parser" do
      expect(call_result).to be_an ArgumentsParser
    end

    xit "recognizes the arguments properly", :aggregate_failures do
      expect(call_result.size).to eq 3
      expect(call_result.number).to eq "12"
    end
  end

  describe "#call" do
    subject(:parser_with_result) { ArgumentsParser.new(args).call }

    context "no -v flag" do
      let(:args) { ["888"] }

      it "specifies the number properly" do
        expect(parser_with_result.number).to eq(args[0])
      end

      it "sets the size to the default value" do
        expect(parser_with_result.size).to eq(described_class::DEFAULT_SIZE)
      end
    end

    context "-v flag presents" do
      context "the flag comes before the number" do
        let(:size) { "4" }
        let(:number) { "777" }
        let(:args) { ["-v", size, number] }

        it "specifies the number properly" do
          expect(parser_with_result.number).to eq(number)
        end

        it "sets the size correctly" do
          expect(parser_with_result.size).to eq(size.to_i)
        end
      end

      context "the flag comes after the number" do
        let(:size) { "9" }
        let(:number) { "1888" }
        let(:args) { [number, "-v", size] }

        it "specifies the number properly" do
          expect(parser_with_result.number).to eq(number)
        end

        it "sets the size correctly" do
          expect(parser_with_result.size).to eq(size.to_i)
        end
      end
    end

    context "no arguments" do
      let(:args) { [] }

      it "raises a error" do
        expect { parser_with_result }.to raise_error(ArgumentsParser::ParserError)
      end
    end

    context "no number provided" do
      let(:args) { ["-v", "3"] }

      it "raises a error" do
        expect { parser_with_result }.to raise_error(ArgumentsParser::ParserError)
      end
    end

    context "a lot of arguments" do
      pending "\n (!) По уму, это надо обрабатывать, но в рамках тестового задания не хочется на это отвлекаться"
    end
  end
end
