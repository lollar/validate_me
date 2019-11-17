# frozen_string_literal: true

module ValidateMe
  class UniquenessValidations
    def self.call base_class:, indexes:
      indexes.each do |index|
        next unless index.unique

        new(index).validate base_class
      end
    end

    def initialize index
      @index = index
    end

    def validate base_class
      columns = index.columns

      if columns.one?
        base_class.send :validates, columns.first, uniqueness: true
      else
        base_class.send :validates, columns.shift, uniqueness: { scope: columns }
      end
    end

    private

    attr_reader :index
  end
end
