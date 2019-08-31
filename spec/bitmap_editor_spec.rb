describe Canvas do
  describe '#create_canvas' do
    it 'creates a 1 x 1 canvas' do
      canvas = Canvas.new
      expect(canvas.create_canvas(1, 1)).to eq ([["O"]])
    end

    it 'creates a 4 x 2 canvas (4 rows, 2 columns)' do
      canvas = Canvas.new
      expect(canvas.create_canvas(2, 4)).to eq ([["O", "O"], ["O", "O"], ["O", "O"], ["O", "O"]])
    end
  end

  describe '#show_canvas' do
    it 'prints the current canvas' do
      canvas = Canvas.new
      canvas.create_canvas(2, 4)
      expect { canvas.show_canvas}.to output("\nOO\nOO\nOO\nOO\n").to_stdout
    end

    it 'prints error message if no canvas has been created' do
      canvas = Canvas.new
      expect { canvas.show_canvas}.to output("\nNo canvas created yet: please create one using the 'I M N' command.\n").to_stdout
    end
  end

  describe '#colour_pixel' do
    it 'changes the colour of an individual pixel' do
      canvas = Canvas.new
      canvas.create_canvas(1, 1)
      expect(canvas.colour_pixel(1, 1, "A")).to eq ([["A"]])
    end

    it 'changes the colour of an individual pixel' do
      canvas = Canvas.new
      canvas.create_canvas(2, 4)
      expect(canvas.colour_pixel(2, 4, "A")).to eq ([["O", "O"], ["O", "O"], ["O", "O"], ["O", "A"]])
    end
  end
end
