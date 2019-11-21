# frozen_string_literal: true

module ValidateMe
  class PresenceValidations
    def self.call base_class:, column:
      return nil if column.null || column.null.nil?

      new(column).validate base_class
    end

    def initialize column
      @column = column
    end

    def validate base_class
      base_class.send :validates, column.name, presence: true
    end

    private

    attr_reader :column
  end
end
