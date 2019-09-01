describe Canvas do
  subject(:canvas) { described_class.new }

  describe '#create_canvas' do
    it 'creates a 1 x 1 canvas' do
      expect(canvas.create_canvas(1, 1)).to eq [["O"]]
    end

    it 'creates a 4 x 2 canvas (4 rows, 2 columns)' do
      expect(canvas.create_canvas(2, 4)).to eq [["O", "O"], ["O", "O"], ["O", "O"], ["O", "O"]]
    end
  end

  describe '#show_canvas' do
    it 'prints the current canvas' do
      canvas.create_canvas(2, 4)
      expect { canvas.show_canvas }.to output("\nOO\nOO\nOO\nOO\n").to_stdout
    end

    it 'prints error message if no canvas has been created' do
      expect { canvas.show_canvas }.to output("\nNo canvas created yet: please create one using the 'I M N' command.\n").to_stdout
    end
  end

  describe '#colour_pixel' do
    it 'changes the colour of an individual pixel' do
      canvas.create_canvas(1, 1)
      expect(canvas.colour_pixel(1, 1, "A")).to eq [["A"]]
    end

    it 'changes the colour of an individual pixel' do
      canvas.create_canvas(2, 4)
      expect(canvas.colour_pixel(2, 4, "A")).to eq [["O", "O"], ["O", "O"], ["O", "O"], ["O", "A"]]
    end
  end

  describe '#clear_canvas' do
    it 'resets the canvas to white' do
      canvas.create_canvas(1, 1)
      canvas.colour_pixel(1, 1, "Z")
      expect(canvas.clear_canvas).to eq [["O"]]
    end

    it 'resets the canvas to white' do
      canvas.create_canvas(2, 4)
      canvas.colour_pixel(2, 2, "Z")
      expect(canvas.clear_canvas).to eq [["O", "O"], ["O", "O"], ["O", "O"], ["O", "O"]]
    end
  end

  describe '#draw_vertical_line' do
    it 'draws a vertical line' do
      canvas.create_canvas(2, 4)
      expect(canvas.draw_vertical_line(2, 2, 4, "Z")).to eq [["O", "O"], ["O", "Z"], ["O", "Z"], ["O", "Z"]]
    end
  end

  describe '#draw_horizontal_line' do
    it 'draws a horizontal line' do
      canvas.create_canvas(5, 3)
      expect(canvas.draw_horizontal_line(2, 4, 2, "Z")).to eq [["O", "O", "O", "O", "O"], ["O", "Z", "Z", "Z", "O"], ["O", "O", "O", "O", "O"]]
    end
  end

  describe '#fill' do
    it 'paints all neighbouring pixels of the same colour with a new colour given a top left start point' do
      canvas.create_canvas(3, 3)
      expect(canvas.fill(1, 1, "Z", "O")).to eq [["Z", "Z", "Z"], ["Z", "Z", "Z"], ["Z", "Z", "Z"]]
    end

    it 'paints all neighbouring pixels of the same colour with a new colour given a bottom right start point' do
      canvas.create_canvas(3, 3)
      expect(canvas.fill(3, 3, "Z", "O")).to eq [["Z", "Z", "Z"], ["Z", "Z", "Z"], ["Z", "Z", "Z"]]
    end

    it 'paints all neighbouring pixels of the same colour with a new colour given a top right start point' do
      canvas.create_canvas(3, 3)
      expect(canvas.fill(3, 1, "Z", "O")).to eq [["Z", "Z", "Z"], ["Z", "Z", "Z"], ["Z", "Z", "Z"]]
    end

    it 'paints all neighbouring pixels of the same colour with a new colour given a bottom left start point' do
      canvas.create_canvas(3, 3)
      expect(canvas.fill(1, 3, "Z", "O")).to eq [["Z", "Z", "Z"], ["Z", "Z", "Z"], ["Z", "Z", "Z"]]
    end

    it 'paints all neighbouring pixels of the same colour with a new colour' do
      canvas.create_canvas(3, 3)
      canvas.colour_pixel(3, 3, "T")
      expect(canvas.fill(2, 2, "Z", "O")).to eq [["Z", "Z", "Z"], ["Z", "Z", "Z"], ["Z", "Z", "T"]]
    end

    it 'paints no neighbouring pixels if none of them are of the same colour' do
      canvas.create_canvas(3, 3)
      canvas.colour_pixel(3, 3, "T")
      expect(canvas.fill(3, 3, "Z", "T")).to eq [["O", "O", "O"], ["O", "O", "O"], ["O", "O", "Z"]]
    end

    it 'paints a region all of one colour with a new colour' do
      canvas.create_canvas(4, 4)
      canvas.draw_horizontal_line(1, 4, 1, "T")
      canvas.draw_horizontal_line(1, 4, 4, "T")
      canvas.draw_vertical_line(1, 1, 4, "T")
      canvas.draw_vertical_line(4, 1, 4, "T")
      expect(canvas.fill(2, 2, "Z", "O")).to eq [["T", "T", "T", "T"], ["T", "Z", "Z", "T"], ["T", "Z", "Z", "T"], ["T", "T", "T", "T"]]
    end

    it 'paints all neighbouring pixels of the same colour with a new colour' do
      canvas.create_canvas(4, 4)
      canvas.draw_horizontal_line(1, 4, 1, "T")
      canvas.draw_horizontal_line(1, 4, 4, "T")
      canvas.draw_vertical_line(1, 1, 4, "T")
      canvas.draw_vertical_line(4, 1, 4, "T")
      expect(canvas.fill(1, 1, "Z", "T")).to eq [["Z", "Z", "Z", "Z"], ["Z", "O", "O", "Z"], ["Z", "O", "O", "Z"], ["Z", "Z", "Z", "Z"]]
    end

    it 'throws error if original colour is the same as new colour' do
      canvas.create_canvas(4, 4)
      expect { canvas.fill(1, 1, "O", "O") }.to raise_error("Oops! Region already that colour: please choose a different fill colour")
    end
  end
end
