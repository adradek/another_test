require_relative "../../02_updated/checker.rb"

RSpec.describe Checker do
  subject(:checker) { described_class.new(string, dictionary) }

  shared_examples "it's possible to asseble" do
    it "returns true as a result of #possible_to_assemble? method" do
      expect(checker.possible_to_assemble?).to eq(true)
    end

    it "returns the correct partition as a result of the #found_partition method" do
      expect(checker.found_partition).to eq(expected_partition)
    end
  end

  shared_examples "impossible to assemble" do
    it "returns false as a result of #possible_to_assemble? method" do
      expect(checker.possible_to_assemble?).to eq(false)
    end

    it "returns nil as a result of the #found_partition method" do
      expect(checker.found_partition).to be_nil
    end
  end

  context "possible to assemble cases" do
    describe "case 1" do
      let(:string) { "okay" }
      let(:dictionary) { %w[oka ok k ay] }
      let(:expected_partition) { "ok:1 ay:3" }

      it_behaves_like "it's possible to asseble"
    end

    describe "case 2" do
      let(:string) { "поедемвхолмогорыкоростылевивгоры" }
      let(:dictionary) { %w[коростылев поедем ы и в холмогоры холм горы] }
      let(:expected_partition) { "поедем:1 в:4 холмогоры:5 коростылев:0 и:3 в:4 горы:7" }

      it_behaves_like "it's possible to asseble"
    end

    describe "case 3" do
      let(:string) { "sssssssssssss" }
      let(:dictionary) { %w[sss ssssssssssss s] }
      let(:expected_partition) { "sss:0 sss:0 sss:0 sss:0 s:2" }

      it_behaves_like "it's possible to asseble"
    end

    describe "empty case" do
      let(:string) { "" }
      let(:dictionary) { %w[sss ssssssssssss s] }
      let(:expected_partition) { "" }

      it_behaves_like "it's possible to asseble"
    end

    describe "case 5"
  end

  context "impossible to assemble cases" do
    describe "case 1" do
      let(:string) { "okay" }
      let(:dictionary) { %w[oka kay] }

      it_behaves_like "impossible to assemble"
    end

    describe "case 2" do
      let(:string) { "штангенциркуль" }
      let(:dictionary) { %w[штангенц циркуль] }

      it_behaves_like "impossible to assemble"
    end
  end
end
