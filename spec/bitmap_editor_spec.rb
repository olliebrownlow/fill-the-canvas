describe Canvas do
  describe '#create_canvas' do
    it 'creates an M x N matrix' do
      canvas = Canvas.new
      expect(canvas.create_canvas(1, 1)).to eq ([["O"]])
    end
  end
end
