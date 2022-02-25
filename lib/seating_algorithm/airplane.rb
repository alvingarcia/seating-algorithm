# frozen_string_literal: true

require_relative 'airplane_seat'

module SeatingAlgorithm
  class Airplane

    attr_accessor :seats, :seat_config

    def initialize seat_config
      @seat_config = seat_config
      generate_seats
    end

    def generate_seats
      @seats = []

      seat_config.each_with_index do |config, index|
        div = index + 1
        no_of_cols, no_of_rows = config

        (1..no_of_cols).each do |col|
          (1..no_of_rows).each do |row|
            seat_attr = { div:, col:, row: }
            seat_attr[:pos] = calc_seat_pos(seat_config, **{ div:, col: })
            seat = AirplaneSeat.new(seat_attr)

            @seats.push(seat)
          end
        end
      end

      @seats
    end

    def assign_passengers no_of_passengers
      (1..no_of_passengers).each do |passenger_no|
        seat = seats_by_seating_order[passenger_no - 1]
        break if seat.nil?
        seat.passenger = passenger_no
      end

      seats_by_seating_order
    end

    def print_seating_arrangement
      puts "\nSeating Arrangement\n"

      seating_arrangement.each do |row|
        output = row.inject('') do |string, seat|
          seat_str = seat ? "#{seat.passenger.to_s.ljust(3)} " : ' '.ljust(4)
          string + seat_str
        end

        puts output
      end
    end

    private

    def calc_seat_pos seat_config, div:, col:
      div_idx = div - 1
      div_pos = calc_array_position(seat_config.size, div_idx)

      col_idx = col - 1
      col_pos = calc_array_position(seat_config[div_idx][0], col_idx)
      
      return :center if col_pos == :center
      return :window if div_pos == col_pos
      :aisle
    end

    def calc_array_position length, index
      return :left if index == 0
      return :right if index == (length - 1)
      :center
    end

    def seating_arrangement
      cols = seat_config.sum(&:first) + seat_config.size - 1
      rows = seat_config.map(&:last).max
      seat_map = (1..rows).map { Array.new(cols) }

      seats.each do |seat|
        prev_div = seat_config[0...(seat.div - 1)]
        x = seat.col + prev_div.sum(&:first) + prev_div.size - 1
        y = seat.row - 1

        seat_map[y][x] = seat
      end

      seat_map
    end

    def seats_by_seating_order
      @seats_by_seating_order ||= seats.sort_by(&:seating_order)
    end

    def seats_by_structure_order
      @seats_by_structure_order ||= seats.sort_by(&:name)
    end

  end
end