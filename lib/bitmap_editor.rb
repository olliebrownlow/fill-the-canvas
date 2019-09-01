class Canvas
  INVALID_COMMAND_MSG = "\nInvalid command, type 'help' to see a list of available commands."
  NO_CANVAS_MSG = "\nNo canvas created yet: please create one using the 'I M N' command."

  attr_reader :canvas

  def initialize
    @canvas
  end

  def run
    greet
    canvas_size = []
    while true
      puts "\nType 'help' to see a list of available commands. Type 'X' to exit."
      print "Enter command: "
      input = gets.chomp

      break if input == "X"

      if input == "help"
        help
      elsif input.split(" ")[0] == "I" &&
            (1..250).include?(input.split(" ")[1].to_i) &&
            (1..250).include?(input.split(" ")[2].to_i) &&
            input.split(" ")[3].nil?

        m = input.split(" ")[1].to_i
        n = input.split(" ")[2].to_i

        canvas_size.clear
        canvas_size.push(m)
        canvas_size.push(n)

        create_canvas(m, n)
      elsif input == "S"
        show_canvas
      elsif input.split(" ")[0] == "L" &&
            (1..canvas_size[0]).include?(input.split(" ")[1].to_i) &&
            (1..canvas_size[1]).include?(input.split(" ")[2].to_i) &&
            ("A".."Z").include?(input.split(" ")[3]) &&
            input.split(" ")[4].nil?

        x = input.split(" ")[1].to_i
        y = input.split(" ")[2].to_i
        colour = input.split(" ")[3]

        colour_pixel(x, y, colour)
      elsif input == "C"
        clear_canvas
      elsif input.split(" ")[0] == "V" &&
            (1..canvas_size[0]).include?(input.split(" ")[1].to_i) &&
            (1..canvas_size[1]).include?(input.split(" ")[2].to_i) &&
            (input.split(" ")[2].to_i..canvas_size[1]).include?(input.split(" ")[3].to_i) &&
            ("A".."Z").include?(input.split(" ")[4]) &&
            input.split(" ")[5].nil?

        column = input.split(" ")[1].to_i
        row1 = input.split(" ")[2].to_i
        row2 = input.split(" ")[3].to_i
        colour = input.split(" ")[4]
        draw_vertical_line(column, row1, row2, colour)

      elsif input.split(" ")[0] == "H" &&
            (1..canvas_size[0]).include?(input.split(" ")[1].to_i) &&
            (input.split(" ")[1].to_i..canvas_size[0]).include?(input.split(" ")[2].to_i) &&
            (1..canvas_size[1]).include?(input.split(" ")[3].to_i) &&
            ("A".."Z").include?(input.split(" ")[4]) &&
            input.split(" ")[5].nil?

        column1 = input.split(" ")[1].to_i
        column2 = input.split(" ")[2].to_i
        row = input.split(" ")[3].to_i
        colour = input.split(" ")[4]
        draw_horizontal_line(column1, column2, row, colour)
      else

        puts INVALID_COMMAND_MSG
      end
    end
  end

  def greet
    puts "\nWelcome to Canvas, your bitmap editor of choice."
  end

  def help
    puts "\nHelp at hand"
  end

  def create_canvas(m, n)
    @canvas = Array.new(n) {
      Array.new(m, "O")
    }
  end

  def show_canvas
    canvas.nil? ? puts(NO_CANVAS_MSG) : format_and_print_canvas(canvas)
  end

  def colour_pixel(x, y, colour)
    canvas.nil? ? puts(NO_CANVAS_MSG) : canvas[y - 1][x - 1] = colour
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
    canvas.nil? ? puts(NO_CANVAS_MSG) : canvas.map.with_index { |row, i|
      if i >= (row1 - 1) && i <= (row2 - 1)
        row[column - 1] = colour
      end
    }
    canvas
  end

  def draw_horizontal_line(column1, column2, row, colour)
    canvas.nil? ? puts(NO_CANVAS_MSG) : canvas[row - 1].map!.with_index { |pixel, i|
      if i >= (column1 - 1) && i <= (column2 - 1)
        pixel = 'Z'
      else
        pixel
      end
    }
    canvas
  end

  private

  def format_and_print_canvas(canvas)
    print "\n"
    canvas.each { |row|
      puts row.join("")
    }
  end

end
