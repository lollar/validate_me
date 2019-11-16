# frozen_string_literal: true

module ValidateMe
  class PresenceValidations
    def self.call base_class:, column:
      return nil if column.null || column.null.nil?

      base_class.send :validates, column.name, presence: true
    end
  end
end
