# frozen_string_literal: true

module ValidateMe
  class VarcharLimitValidations
    def self.call base_class:, column:
      return nil unless column.type == :integer && column.limit.present?

      new(column).validate base_class
    end

    def initialize column
      @column = column
    end

    def validate base_class
      base_class.send(
        :validates,
        column.name,
        numericality: {
          greater_than: minimum_value,
          less_than:    maximum_value
        },
        allow_nil: true
      )
    end

    private

    attr_reader :column

    def maximum_value
      (1 << column.limit * 8 - 1) - 1
    end

    def minimum_value
      -(maximum_value + 1)
    end
  end
end
