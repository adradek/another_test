require_relative "../../02_dictionary/partition.rb"

RSpec.describe Partition do
  describe "#replace_word" do
    subject { described_class.new([0, "superuser", 1]) }

    context "word not fount" do
      it "returns empty array" do
        expect(subject.replace_word("tree", 2)).to eq []
      end
    end

    context "word found once" do
      it "returns the array with a single Partition" do
        expect(subject.replace_word("user", 2)).to match_array([instance_of(Partition)])
      end

      it "creates new Partition with proper content" do
        result = subject.replace_word("user", 2)[0]
        expect(result.content).to eq [0, "super", 2, 1]
      end
    end

    context "word found several times" do
      it "returns the array with a correct numer of Partitions" do
        expect(subject.replace_word("er", 2)).to match_array([instance_of(Partition), instance_of(Partition)])
      end

      it "creates two Partitions with proper content", :aggregate_failures do
        result = subject.replace_word("er", 2)
        expect(result[0].content).to eq [0, "sup", 2, "user", 1]
        expect(result[1].content).to eq [0, "superus", 2, 1]
      end
    end
  end

  describe "#solution?" do
    context "initial copy completely broken into words" do
      subject { described_class.new([5, 2, 3, 1]) }

      it "returns true" do
        expect(subject.solution?).to eq true
      end
    end

    context "the breaking of the initial copy into words not complete" do
      subject { described_class.new(["d", 2, "am", 1]) }

      it "returns false" do
        expect(subject.solution?).to eq false
      end
    end
  end
end
