gem 'minitest', '~> 5.0'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/phone_number'

class PersonTest < Minitest::Test
  def test_id
    number = PhoneNumber.new(person_id: "1")
    assert_equal 1, number.person_id
  end

  def test_number_with_dashes
    number = PhoneNumber.new(phone_number: '123-456-7890')
    assert_equal "(123) 456-7890", number.to_s
  end

  def test_number_with_dots
    number = PhoneNumber.new(phone_number: '123.456.7890')
    assert_equal "(123) 456-7890", number.to_s
  end
end

