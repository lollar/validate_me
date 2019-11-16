require "test_helper"

# TODO Test:
# Add uniqueness validation in separate file (these should all be broken into separate tests)

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
    @user.phone_number = -129

    refute          @user.valid?
    assert_includes @user.errors.full_messages, "Phone number must be greater than -128"
  end

  def test_that_user_can_still_be_valid
    @user.attributes = {
      first_name:   "Bob",
      last_name:    "Loblaw",
      email:        "bobloblaw@bobloblawslawblog.com",
      phone_number: 10,
    }

    assert @user.valid?
    assert @user.save
  end
end
