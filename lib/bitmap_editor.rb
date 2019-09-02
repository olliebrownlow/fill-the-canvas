class Canvas
  INVALID_COMMAND_MSG = "\nInvalid command, type 'help' to see a list of available commands."
  NO_CANVAS_MSG = "\nNo canvas created yet: please create one using the 'I M N' command."

  attr_reader :canvas, :canvas_dimensions

  def initialize
    @canvas
    @canvas_dimensions = []
  end

  def greet
    puts "\nWelcome to Canvas, your bitmap editor of choice."
    run
  end

  def run
    while true
      puts "\nType '?' to see a list of available commands. Type 'X' to exit."
      print "Enter command: "
      input = gets.chomp

      case input.split(" ")[0]
      when "X"
        break
      when "?"
        help
      when "I"
        create_canvas_guards(input)

        columns = input.split(" ")[1].to_i
        rows = input.split(" ")[2].to_i

        canvas_dimensions.clear
        canvas_dimensions.push(columns)
        canvas_dimensions.push(rows)

        create_canvas(columns, rows)
      when "S"
        show_canvas
      when "L"
        colour_pixel_and_fill_guards(input, canvas_dimensions)

        x = input.split(" ")[1].to_i
        y = input.split(" ")[2].to_i
        colour = input.split(" ")[3]

        colour_pixel(x, y, colour)
      when "C"
        clear_canvas
      when "V"
        vertical_line_guards(input, canvas_dimensions)

        column = input.split(" ")[1].to_i
        row1 = input.split(" ")[2].to_i
        row2 = input.split(" ")[3].to_i
        colour = input.split(" ")[4]
        draw_vertical_line(column, row1, row2, colour)
      when "H"
        horizontal_line_guards(input, canvas_dimensions)

        column1 = input.split(" ")[1].to_i
        column2 = input.split(" ")[2].to_i
        row = input.split(" ")[3].to_i
        colour = input.split(" ")[4]
        draw_horizontal_line(column1, column2, row, colour)
      when "F"
        colour_pixel_and_fill_guards(input, canvas_dimensions)

        column = input.split(" ")[1].to_i
        row = input.split(" ")[2].to_i
        new_colour = input.split(" ")[3]
        original_colour = canvas[row - 1][column - 1]

        fill(column, row, new_colour, original_colour)
      else
        puts INVALID_COMMAND_MSG
      end
    end
  end

  def fill_guards(input, canvas_dimensions)
    unless (1..canvas_dimensions[0]).include?(input.split(" ")[1].to_i) &&
           (1..canvas_dimensions[1]).include?(input.split(" ")[2].to_i) &&
           ("A".."Z").include?(input.split(" ")[3]) &&
           input.split(" ")[4].nil?
      puts INVALID_COMMAND_MSG
      run
    end
  end


  def help
    puts "\nHelp at hand"
  end

  def create_canvas(columns, rows)
    @canvas = Array.new(rows) {
      Array.new(columns, "O")
    }
  end

  def show_canvas
    canvas.nil? ? puts(NO_CANVAS_MSG) : format_and_print_canvas(canvas)
  end

  def colour_pixel(column, row, colour)
    canvas.nil? ? puts(NO_CANVAS_MSG) : canvas[row - 1][column - 1] = colour
    canvas
  end

  def clear_canvas
    canvas.nil? ? puts(NO_CANVAS_MSG) : canvas.each { |row|
                                        row.map! {
                                          "O"
                                        }
                                      }
  end

  def draw_vertical_line(column, row1, row2, colour)
    canvas.nil? ? puts(NO_CANVAS_MSG) : for i in (row1..row2)
                                          colour_pixel(column, i, colour)
                                        end
    canvas
  end

  def draw_horizontal_line(column1, column2, row, colour)
    canvas.nil? ? puts(NO_CANVAS_MSG) : for i in (column1..column2)
                                          colour_pixel(i, row, colour)
                                        end
    canvas
  end

  def fill(column, row, new_colour, original_colour)
    raise "Oops! Region already that colour: please choose a different fill colour" if new_colour == original_colour
    if canvas[row - 1][column - 1] == original_colour
      colour_pixel(column, row, new_colour)
      fill(column + 1, row, new_colour, original_colour) if !canvas[row - 1][column].nil?
      fill(column, row + 1, new_colour, original_colour) if !canvas[row].nil?
      fill(column - 1, row, new_colour, original_colour) if !canvas[row - 1][column - 2].nil?
      fill(column, row - 1, new_colour, original_colour) if !canvas[row - 2].nil?
    end
    canvas
  end

  private

  def create_canvas_guards(input)
    unless (1..250).include?(input.split(" ")[1].to_i) &&
           rows = (1..250).include?(input.split(" ")[2].to_i) &&
           input.split(" ")[3].nil?
      puts INVALID_COMMAND_MSG
      run
    end
  end

  def colour_pixel_and_fill_guards(input, canvas_dimensions)
    unless (1..canvas_dimensions[0]).include?(input.split(" ")[1].to_i) &&
           (1..canvas_dimensions[1]).include?(input.split(" ")[2].to_i) &&
           ("A".."Z").include?(input.split(" ")[3]) &&
           input.split(" ")[4].nil?
      puts INVALID_COMMAND_MSG
      run
    end
  end

  def vertical_line_guards(input, canvas_dimensions)
    unless (1..canvas_dimensions[0]).include?(input.split(" ")[1].to_i) &&
           (1..canvas_dimensions[1]).include?(input.split(" ")[2].to_i) &&
           (input.split(" ")[2].to_i..canvas_dimensions[1]).include?(input.split(" ")[3].to_i) &&
           ("A".."Z").include?(input.split(" ")[4]) &&
           input.split(" ")[5].nil?
      puts INVALID_COMMAND_MSG
      run
    end
  end

  def horizontal_line_guards(input, canvas_dimensions)
    unless (1..canvas_dimensions[0]).include?(input.split(" ")[1].to_i) &&
           (input.split(" ")[1].to_i..canvas_dimensions[0]).include?(input.split(" ")[2].to_i) &&
           (1..canvas_dimensions[1]).include?(input.split(" ")[3].to_i) &&
           ("A".."Z").include?(input.split(" ")[4]) &&
           input.split(" ")[5].nil?
      puts INVALID_COMMAND_MSG
      run
    end
  end

  def format_and_print_canvas(canvas)
    print "\n"
    canvas.each { |row|
      puts row.join("")
    }
  end

end
