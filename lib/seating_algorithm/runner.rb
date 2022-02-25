module SeatingAlgorithm
  class Runner

    def call
      puts 'Input a 2D array that represents the columns and rows - Ex. [[3,2], [4,3], [2,3], [3,4]]:'
      seat_config = JSON.parse(gets.chomp)

      puts 'Input number of passengers waiting in the queue:'
      no_of_passengers = gets.chomp

      airplane = Airplane.new(seat_config)
      airplane.assign_passengers(no_of_passengers.to_i)

      airplane.print_seating_arrangement
    end

  end
end