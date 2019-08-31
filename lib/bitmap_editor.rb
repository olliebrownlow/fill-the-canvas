class Canvas

  def initialize
    @canvas
  end

  def run
    greet

    while true
      puts "\nType 'help' to see a list of available commands. Type 'quit' to exit."
      print "Enter command: "
      input = gets.chomp

      break if input == "quit"

      if input == "help"
        help
      elsif input[0] == "I" && (1..250).include?(input[2].to_i) && (1..250).include?(input[4].to_i)
        m = input[2].to_i
        n = input[4].to_i
        create_canvas(m, n)
      else
        puts "Invalid command, type 'help' to see a list of available commands."
      end
    end
  end

  def greet
    puts "\nWelcome to Canvas, your bitmap editor of choice."
  end

  def help
    puts "Help"
  end

  def create_canvas(m, n)
    @canvas = Array.new(m) {
      Array.new(n, "O")
    }
  end
end
