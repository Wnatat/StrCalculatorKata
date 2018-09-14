require "string_calculator"

RSpec.describe StringCalculator, "#sum" do
  subject { StringCalculator.new }

  context "when empty string" do
    it "returns 0" do
      expect(subject.sum("")).to eq 0
    end
  end

  context "when single number string" do
    it "returns number as int" do
      expect(subject.sum("1")).to eq 1
    end
  end

  context "when string of 2 comma separated numbers" do
    it "returns 1 for string 0,1" do
      expect(subject.sum("0,1")).to eq 1
    end

    it "returns 3 for string 1,2" do
      expect(subject.sum("1,2")).to eq 3
    end

    it "returns 374 for string 153,221" do
      expect(subject.sum("153,221")).to eq 374
    end
  end

  context "when string of any number of comma separated numbers" do
    it "returns 3 for string 0,1,2" do
      expect(subject.sum("0,1,2")).to eq 3
    end

  end

  context "when string of newline separated numbers" do
    it "returns 1 for string 0\\n1" do
      expect(subject.sum("0\n1")).to eq 1
    end

    it "returns 6 for string 1\\n2\\n3" do
      expect(subject.sum("1\n2\n3")).to eq 6
    end
  end

  context "when support custom delimiters" do
    it "returns 3 for sring //;\\n1;2" do
      expect(subject.sum("//;\n1;2")).to eq 3
    end
  end

  context "when string containing negative numbers" do
    it "fires an exception" do
      expect { subject.sum("2,-3") }.to raise_error(RuntimeError, "negatives not allowed: -3")
    end

    it "shows all negative numbers in exception message" do
      expect { subject.sum("2,-4,-6") }.to raise_error(RuntimeError, "negatives not allowed: -4, -6")
    end
  end

  context "when string containing large numbers" do
    it "ignores numbers above 1000" do
      expect(subject.sum("2,1001")).to eq 2
    end
  end

  context "when support delimiter of any length" do
    it "returns 6 for sring //[***]\\n1***2***3" do
      expect(subject.sum("//[***]\n1***2***3")).to eq 6
    end
  end

  context "when support multiple delimiters" do
    it "returns 6 for string //[*][%]\\n1*2%3" do
      expect(subject.sum("//[*][%]\n1*2%3")).to eq 6
    end
  end

  context "when support multiple delimiters of more than one character" do
    it "returns 9 for string //[*][%][***]\\n1*2%3***3" do
      expect(subject.sum("//[*][%][***]\n1*2%3***3")).to eq 9
    end
  end
end
