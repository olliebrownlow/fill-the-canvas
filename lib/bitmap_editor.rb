class Canvas

  def self.run
    Canvas.greet
  end

  def self.greet
    puts "Welcome to Canvas, your bitmap editor of choice."

    while true
      puts "\nType 'help' to see a list of available commands. Type 'quit' to exit."
      print "Enter command: "
      input = gets.chomp

      break if input == "quit"
    end
  end
end
