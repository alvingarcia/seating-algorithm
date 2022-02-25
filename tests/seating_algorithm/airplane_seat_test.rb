require 'test_helper'

module SeatingAlgorithm
  class AirplaneSeatTest < MiniTest::Test

    def valid_params
      {
        pos: :aisle,
        row: 1,
        div: 1,
        col: 1,
      }
    end

    def test_seating_order
      seat1 = AirplaneSeat.new({ div: 1, row: 1, col: 1, pos: :center })
      seat2 = AirplaneSeat.new({ div: 1, row: 2, col: 1, pos: :center })
      seat3 = AirplaneSeat.new({ div: 1, row: 1, col: 2, pos: :center })
      seat4 = AirplaneSeat.new({ div: 3, row: 1, col: 2, pos: :center })
      seat5 = AirplaneSeat.new({ div: 2, row: 1, col: 2, pos: :center })

      ordered = [seat1, seat2, seat3, seat4, seat5].sort_by(&:seating_order)

      assert_equal ordered[0], seat1
      assert_equal ordered[1], seat3
      assert_equal ordered[2], seat5
      assert_equal ordered[3], seat4
      assert_equal ordered[4], seat2
    end

    def test_missing_required_fields_error
      error = SeatingAlgorithm::MissingRequiredParameterError

      assert_raises(error) { AirplaneSeat.new(valid_params.except(:pos)) }
      assert_raises(error) { AirplaneSeat.new(valid_params.except(:row)) }
      assert_raises(error) { AirplaneSeat.new(valid_params.except(:col)) }
      assert_raises(error) { AirplaneSeat.new(valid_params.except(:div)) }
    end

    def test_invalid_pos_error
      error = SeatingAlgorithm::InvalidPosError

      assert_raises(error) { AirplaneSeat.new({ **valid_params, pos: :invalid }) }
    end

    def test_limit_error
      error = SeatingAlgorithm::MaximumLimitReachedError

      assert_raises(error) { AirplaneSeat.new({ **valid_params, row: 1000 }) }
      assert_raises(error) { AirplaneSeat.new({ **valid_params, col: 1000 }) }
      assert_raises(error) { AirplaneSeat.new({ **valid_params, div: 1000 }) }
    end

  end
end