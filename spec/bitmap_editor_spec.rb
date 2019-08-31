describe Canvas do
  describe '#create_canvas' do
    it 'creates a 1 x 1 canvas' do
      canvas = Canvas.new
      expect(canvas.create_canvas(1, 1)).to eq ([["O"]])
    end

    it 'creates a 4 x 2 canvas' do
      canvas = Canvas.new
      expect(canvas.create_canvas(2, 4)).to eq ([["O", "O"], ["O", "O"], ["O", "O"], ["O", "O"]])
    end
  end
end
