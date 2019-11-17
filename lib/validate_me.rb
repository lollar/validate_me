require "validate_me/version"
require "validate_me/presence_validations"
require "validate_me/varchar_limit_validations"
require "validate_me/integer_limit_validations"
require "validate_me/uniqueness_validations"

module ValidateMe
  SKIPPED_COLUMNS = ["id"].freeze
  class Error < StandardError; end

  def self.included base_class
    base_class.columns.each do |column|
      next if ::ValidateMe::SKIPPED_COLUMNS.include? column.name

      ::ValidateMe::PresenceValidations.call     base_class: base_class, column: column
      ::ValidateMe::VarcharLimitValidations.call base_class: base_class, column: column
      ::ValidateMe::IntegerLimitValidations.call base_class: base_class, column: column
    end

   indexes = ::ActiveRecord::Base.connection.indexes base_class.table_name
   ::ValidateMe::UniquenessValidations.call base_class: base_class, indexes: indexes
  end
end
