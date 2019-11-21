# frozen_string_literal: true

module ValidateMe
  class VarcharLimitValidations
    def self.call base_class:, column:
      return nil unless column.type == :string && column.limit.present?

      new(column).validate base_class
    end

    def initialize column
      @column = column
    end

    def validate base_class
      base_class.send :validates, column.name, length: { maximum: column.limit }
    end

    private

    attr_reader :column
  end
end
