# frozen_string_literal: true

require "test_helper"

class ValidateMeTest < Minitest::Test
  def setup
    @user = ::User.new
  end

  def test_that_user_is_not_valid
    refute @user.valid?, "@user is valid"
  end

  def test_presence_validation_on_first_name
    @user.first_name = nil

    refute          @user.valid?
    assert_includes @user.errors.full_messages, "First name can't be blank"
  end

  def test_length_validation_on_first_name
    @user.first_name = "A really, really long name. Or something."

    refute          @user.valid?
    assert_includes @user.errors.full_messages, "First name is too long (maximum is 10 characters)"
  end

  def test_presence_validation_on_last_name
    @user.first_name = nil

    refute          @user.valid?
    assert_includes @user.errors.full_messages, "Last name can't be blank"
  end

  def test_presence_validation_on_email
    @user.first_name = nil

    refute          @user.valid?
    assert_includes @user.errors.full_messages, "Email can't be blank"
  end

  def test_upper_bound_length_validation_on_phone_number
    @user.phone_number = 128

    refute          @user.valid?
    assert_includes @user.errors.full_messages, "Phone number must be less than 127"
  end

  def test_lower_bound_length_validation_on_phone_number
    @user.phone_number = -128

    refute          @user.valid?
    assert_includes @user.errors.full_messages, "Phone number must be greater than -128"
  end

  def test_that_user_can_still_be_valid
    @user.attributes = {
      first_name:   "Bob",
      last_name:    "Loblaw",
      email:        "bobloblaw+unique@bobloblawslawblog.com",
      phone_number: 10,
      unique_with:  "hola!",
      this_column:  "adios!",
      that_column:  "mucho gusto!"
    }

    assert @user.valid?
    assert @user.save
  end

  def test_uniqueness_validation_on_email
    ::User.create first_name: "Bob", last_name: "Loblaw", email: "bobloblaw@bobloblawslawblog.com", phone_number: 10

    @user.attributes = {
      first_name:   "Bob",
      last_name:    "Loblaw",
      email:        "bobloblaw@bobloblawslawblog.com",
      phone_number: 10,
    }

    refute @user.valid?
    assert_includes @user.errors.full_messages, "Email has already been taken"
  end

  def test_uniqueness_with_scope_on_multiple_columns
    duplicate_attributes = {
      first_name: "Don",
      last_name: "Corleone",
      email: "don@godfather.com",
      phone_number: 9,
      unique_with: "unique with",
      this_column: "this_column",
      that_column: "that column"
    }

    ::User.create duplicate_attributes

    @user.attributes = duplicate_attributes

    refute          @user.valid?
    assert_includes @user.errors.full_messages, "Unique with has already been taken"
  end

  def test_uniqueness_is_valid_with_scope_on_multiple_columns
    attributes = {
      first_name: "Don",
      last_name: "Corleone",
      email: "don@godfather.com",
      phone_number: 9,
      unique_with: "unique with",
      this_column: "this_column",
      that_column: "that column"
    }

    ::User.create attributes

    @user.attributes = attributes.merge this_column: "hola!", email: "don+unique@godfather.com"

    assert @user.valid?
  end
end
