require 'test_helper'

module SeatingAlgorithm
  class AirplaneTest < MiniTest::Test
    def setup
      @seater_20 = Airplane.new([[4,4], [2,2]])
    end

    def test_generated_seats_count
      assert_equal 20, @seater_20.seats.count

      airplane1 = Airplane.new([[2,2]])
      assert_equal 4, airplane1.seats.count

      airplane2 = Airplane.new([[3,4]])
      assert_equal 12, airplane2.seats.count

      airplane3 = Airplane.new([[2,2], [3,4]])
      assert_equal 16, airplane3.seats.count
    end

    def test_with_enough_seats
      @seater_20.assign_passengers(12)

      used_seats = @seater_20.seats.reject { |seat| seat.passenger.nil? }
      empty_seats = @seater_20.seats.select { |seat| seat.passenger.nil? }

      assert_equal 12, used_seats.size
      assert_equal 8, empty_seats.size
    end

    def test_with_insufficient_seats
      @seater_20.assign_passengers(30)

      used_seats = @seater_20.seats.reject { |seat| seat.passenger.nil? }
      empty_seats = @seater_20.seats.select { |seat| seat.passenger.nil? }

      assert_equal 20, used_seats.size
      assert_equal 0, empty_seats.size
    end

    def test_printing
      @seater_20.assign_passengers(30)
      assert_output(/Seating Arrangement/) { @seater_20.print_seating_arrangement }
    end

  end
end