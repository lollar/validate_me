$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "validate_me"

require "minitest/autorun"

require "active_record"
require "sqlite3"

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: ":memory:"
)

ActiveRecord::Schema.define do
  create_table :users do |t|
    t.string :first_name, limit: 10, null: false
    t.string :last_name, null: false
    t.string :email, null: false, index: { unique: true }
    t.integer :phone_number, limit: 1
    t.string :unique_with
    t.string :this_column
    t.string :that_column
  end

  add_index :users, [:unique_with, :this_column, :that_column], unique: true
end

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

class User < ApplicationRecord
  include ValidateMe
end
