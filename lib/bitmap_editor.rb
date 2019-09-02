require_relative './paint.rb'

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
        exit_and_help_guards(input)
        exit
      when "?"
        exit_and_help_guards(input)
        help
      when "S"
        show_and_clear_guards(input)
        show_canvas
      when "C"
        show_and_clear_guards(input)
        clear_canvas
      when "I"
        create_canvas_guards(input)
        columns = input.split(" ")[1].to_i
        rows = input.split(" ")[2].to_i
        canvas_dimensions.clear
        canvas_dimensions.push(columns)
        canvas_dimensions.push(rows)
        create_canvas(columns, rows)
      when "L"
        colour_pixel_and_fill_guards(input)
        column = input.split(" ")[1].to_i
        row = input.split(" ")[2].to_i
        colour = input.split(" ")[3]
        colour_pixel(column, row, colour)
      when "V"
        vertical_line_guards(input)
        column = input.split(" ")[1].to_i
        row1 = input.split(" ")[2].to_i
        row2 = input.split(" ")[3].to_i
        colour = input.split(" ")[4]
        draw_vertical_line(column, row1, row2, colour)
      when "H"
        horizontal_line_guards(input)
        column1 = input.split(" ")[1].to_i
        column2 = input.split(" ")[2].to_i
        row = input.split(" ")[3].to_i
        colour = input.split(" ")[4]
        draw_horizontal_line(column1, column2, row, colour)
      when "F"
        colour_pixel_and_fill_guards(input)
        column = input.split(" ")[1].to_i
        row = input.split(" ")[2].to_i
        new_colour = input.split(" ")[3]
        original_colour = canvas[row - 1][column - 1]
        fill(column, row, new_colour, original_colour)
      when "W"
        scale_guards(input)
        percent = input.split(" ")[1].to_i
        scale(percent)
      else
        puts INVALID_COMMAND_MSG
      end
    end
  end

  def help
    puts "\nQuit Program"
    puts "  X\t\t\t:quits the application."
    puts "Help"
    puts "  ?\t\t\t:shows this help menu."
    puts "New Canvas"
    puts "  I M N\t\t\t:creates a new M by N canvas. All pixels start white, represented by 'O'."
    puts "Colour In"
    puts "  L X Y C\t\t:colours the pixel (X,Y) with colour C"
    puts "  V X Y1 Y2 C\t\t:draws a vertical line with colour C in column X between rows Y1 and Y2 inclusive"
    puts "  H X1 X2 Y C\t\t:draws a horizontal line with colour C in row Y between columns X1 and X2 inclusive"
    puts "  F X Y C\t\t:Fills a region R with the colour C, where pixel (X,Y) is in R and any other\n\t\t\tpixel the same colour as (X,Y) and sharing a common side with any pixel in R also belongs to R."
    puts "Scale"
    puts "  W F\t\t\t:scales the canvas by the given factor F (in percentage)."
    puts "Clear"
    puts "  C\t\t\t:returns the canvas back to its original state."
    puts "Show"
    puts "  S\t\t\t:shows the canvas in its current state."
  end

  def create_canvas(columns, rows)
    @canvas = Array.new(rows) {
      Array.new(columns, "O")
    }
  end

  def show_canvas
    format_and_print_canvas(canvas)
  end

  def colour_pixel(column, row, colour, paint = Paint)
    paint = paint.new(column, row, colour, canvas = @canvas)
    paint.colour_pixel
  end

  def clear_canvas
    canvas.each { |row|
      row.map! {
        "O"
      }
    }
  end

  def draw_vertical_line(column, row1, row2, colour)
    for i in (row1..row2)
      colour_pixel(column, i, colour)
    end
    canvas
  end

  def draw_horizontal_line(column1, column2, row, colour)
    for i in (column1..column2)
      colour_pixel(i, row, colour)
    end
    canvas
  end

  def fill(column, row, new_colour, original_colour)
    if new_colour == original_colour
      puts "Oops! Region already that colour: please choose a different one"
      run
    end
    if canvas[row - 1][column - 1] == original_colour
      colour_pixel(column, row, new_colour)
      fill(column + 1, row, new_colour, original_colour) if !canvas[row - 1][column].nil?
      fill(column, row + 1, new_colour, original_colour) if !canvas[row].nil?
      fill(column - 1, row, new_colour, original_colour) if !canvas[row - 1][column - 2].nil?
      fill(column, row - 1, new_colour, original_colour) if !canvas[row - 2].nil?
    end
    canvas
  end

  def scale(percent)
    scale_factor = percent/100.0

    if scale_factor >= 1
      number_of_rows_to_add = (scale_factor * canvas_dimensions[1] - canvas_dimensions[1]).ceil
      number_of_colums_to_add = (scale_factor * canvas_dimensions[0] - canvas_dimensions[0]).ceil

      number_of_rows_to_add.times  {
        canvas.push(Array.new(canvas_dimensions[0], "O"))
      }
      number_of_colums_to_add.times {
        canvas.map { |row|
        row.unshift("O")
        }
      }

      canvas_dimensions.clear
      canvas_dimensions.push(canvas[0].length)
      canvas_dimensions.push(canvas.length)
      canvas
    else
      number_of_rows_to_delete = ((1 - scale_factor) * canvas_dimensions[1]).floor
      number_of_colums_to_delete = ((1 - scale_factor) * canvas_dimensions[0]).floor

      number_of_rows_to_delete.times  {
        canvas.pop
      }
      number_of_colums_to_delete.times {
        canvas.map { |row|
          row.shift
        }
      }

      canvas_dimensions.clear
      canvas_dimensions.push(canvas[0].length)
      canvas_dimensions.push(canvas.length)
      canvas
    end
  end

  private

  def exit_and_help_guards(input)
    unless input.split(" ")[1].nil?
      puts INVALID_COMMAND_MSG
      run
    end
  end

  def show_and_clear_guards(input)
    if canvas.nil?
      puts(NO_CANVAS_MSG)
      run
    end
    unless input.split(" ")[1].nil?
      puts INVALID_COMMAND_MSG
      run
    end
  end

  def create_canvas_guards(input)
    unless (1..250).include?(input.split(" ")[1].to_i) &&
           rows = (1..250).include?(input.split(" ")[2].to_i) &&
           input.split(" ")[3].nil?
      puts INVALID_COMMAND_MSG
      run
    end
  end

  def colour_pixel_and_fill_guards(input)
    if canvas.nil?
      puts(NO_CANVAS_MSG)
      run
    end
    unless (1..canvas_dimensions[0]).include?(input.split(" ")[1].to_i) &&
           (1..canvas_dimensions[1]).include?(input.split(" ")[2].to_i) &&
           ("A".."Z").include?(input.split(" ")[3]) &&
           input.split(" ")[4].nil?
      puts INVALID_COMMAND_MSG
      run
    end
  end

  def vertical_line_guards(input)
    if canvas.nil?
      puts(NO_CANVAS_MSG)
      run
    end
    unless (1..canvas_dimensions[0]).include?(input.split(" ")[1].to_i) &&
           (1..canvas_dimensions[1]).include?(input.split(" ")[2].to_i) &&
           (input.split(" ")[2].to_i..canvas_dimensions[1]).include?(input.split(" ")[3].to_i) &&
           ("A".."Z").include?(input.split(" ")[4]) &&
           input.split(" ")[5].nil?
      puts INVALID_COMMAND_MSG
      run
    end
  end

  def horizontal_line_guards(input)
    if canvas.nil?
      puts(NO_CANVAS_MSG)
      run
    end
    unless (1..canvas_dimensions[0]).include?(input.split(" ")[1].to_i) &&
           (input.split(" ")[1].to_i..canvas_dimensions[0]).include?(input.split(" ")[2].to_i) &&
           (1..canvas_dimensions[1]).include?(input.split(" ")[3].to_i) &&
           ("A".."Z").include?(input.split(" ")[4]) &&
           input.split(" ")[5].nil?
      puts INVALID_COMMAND_MSG
      run
    end
  end

  def fill_guards(input)
    if canvas.nil?
      puts(NO_CANVAS_MSG)
      run
    end
    unless (1..canvas_dimensions[0]).include?(input.split(" ")[1].to_i) &&
           (1..canvas_dimensions[1]).include?(input.split(" ")[2].to_i) &&
           ("A".."Z").include?(input.split(" ")[3]) &&
           input.split(" ")[4].nil?
      puts INVALID_COMMAND_MSG
      run
    end
  end

  def scale_guards(input)
    if canvas.nil?
      puts(NO_CANVAS_MSG)
      run
    end
    unless input.split(" ")[1].to_i >= 1 &&
           input.split(" ")[2].nil?
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
