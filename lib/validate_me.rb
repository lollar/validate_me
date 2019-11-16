require "validate_me/version"
require "validate_me/presence_validations"
require "validate_me/varchar_limit_validations"
require "validate_me/integer_limit_validations"
# require "validate_me/uniqueness_validations"

module ValidateMe
  SKIPPED_COLUMNS = ["id"].freeze
  class Error < StandardError; end

  def self.included base_class
    base_class.columns.each do |column|
      next if ::ValidateMe::SKIPPED_COLUMNS.include? column.name

      if base_class.const_defined? "SKIP_VALIDATE_ME_COLUMNS"
        next if base_class::SKIP_VALIDATE_ME_COLUMNS.include? column.name
      end

      ::ValidateMe::PresenceValidations.call     base_class: base_class, column: column
      ::ValidateMe::VarcharLimitValidations.call base_class: base_class, column: column
      ::ValidateMe::IntegerLimitValidations.call base_class: base_class, column: column
      # ::ValidateMe::UniquenessValidations.call base_class: base_class, column: column
    end
  end
end
