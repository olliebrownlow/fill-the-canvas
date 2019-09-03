describe Paint do
  subject(:paint1) { described_class.new(1, 1, "A", [["O"]]) }
  subject(:paint2) { described_class.new(2, 4, "A", [["O", "O"], ["O", "O"], ["O", "O"], ["O", "O"]]) }

  describe '#colour_pixel' do
    it 'changes the colour of an individual pixel' do
      expect(paint1.colour_pixel).to eq [["A"]]
    end

    it 'changes the colour of an individual pixel' do
      expect(paint2.colour_pixel).to eq [["O", "O"], ["O", "O"], ["O", "O"], ["O", "A"]]
    end
  end
end
