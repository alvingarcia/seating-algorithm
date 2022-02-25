# frozen_string_literal: true

module SeatingAlgorithm

  class MissingRequiredParameterError < StandardError; end
  class MaximumLimitReachedError < StandardError; end
  class InvalidPosError < StandardError; end

  class AirplaneSeat

    REQUIRED_FIELDS = %i[div pos row col].freeze

    PRIORITY_WEIGHT = {
      pos: 1_000_000_000,
      row: 1_000_000,
      div: 1_000,
      col: 1,
    }.freeze

    POSITION_WEIGHT = {
      aisle: 1,
      window: 2,
      center: 3,
    }.freeze

    attr_accessor(*REQUIRED_FIELDS)
    attr_accessor :passenger, :name

    def initialize args
      REQUIRED_FIELDS.each do |key|
        instance_variable_set("@#{key}", args.fetch(key))
      end

      raise(MaximumLimitReachedError, '`row` greater than 999 is not supported') if row > 999
      raise(MaximumLimitReachedError, '`col` greater than 999 is not supported') if col > 999
      raise(MaximumLimitReachedError, '`div` greater than 999 is not supported') if div > 999
      raise(InvalidPosError, '`pos` only supports :window, :aisle, or :center') unless POSITION_WEIGHT.has_key?(pos)

      @name = [row, div, col, pos].join('-')

    rescue KeyError => e
      msg = e.message.sub('key not found: :', 'Must provide ')
      raise MissingRequiredParameterError, msg
    end

    def seating_order
      @seating_order ||= begin
        weight  = POSITION_WEIGHT[pos] * PRIORITY_WEIGHT[:pos]
        weight += div * PRIORITY_WEIGHT[:div]
        weight += row * PRIORITY_WEIGHT[:row]
        weight += col * PRIORITY_WEIGHT[:col]
      end
    end

  end
end