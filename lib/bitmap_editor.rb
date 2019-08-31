class Canvas
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
      elsif input.split(" ")[0] == "I" && (1..250).include?(input.split(" ")[1].to_i) && (1..250).include?(input.split(" ")[2].to_i) && input.split(" ")[3] == nil
        m = input.split(" ")[1].to_i
        n = input.split(" ")[2].to_i
        canvas_size.clear
        canvas_size.push(m)
        canvas_size.push(n)
        create_canvas(m, n)
      elsif input == "S"
        show_canvas
      elsif input.split(" ")[0] == "L" && (1..canvas_size[0]).include?(input.split(" ")[1].to_i) && (1..canvas_size[1]).include?(input.split(" ")[2].to_i) && ("A".."Z").include?(input.split(" ")[3]) && input.split(" ")[4] == nil
        x = input.split(" ")[1].to_i
        y = input.split(" ")[2].to_i
        colour = input.split(" ")[3]
        colour_pixel(x, y, colour)
      else
        puts "\nInvalid command, type 'help' to see a list of available commands."
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
    if canvas == nil
      puts "\nNo canvas created yet: please create one using the 'I M N' command."
    else
      format_and_print_canvas(canvas)
    end
  end

  def colour_pixel(x, y, colour)
    canvas[y-1][x-1] = colour
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
