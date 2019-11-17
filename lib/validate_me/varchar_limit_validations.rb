# frozen_string_literal: true

module ValidateMe
  class VarcharLimitValidations
    def self.call base_class:, column:
      return nil unless column.type == :string && column.limit.present?

      base_class.send :validates, column.name, length: { maximum: column.limit }
    end
  end
end
