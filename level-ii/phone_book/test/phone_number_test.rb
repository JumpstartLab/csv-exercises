gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/phone_number'

class PhoneNumberTest < Minitest::Test
  def test_person_id
    number = PhoneNumber.new(person_id: "1")
    assert_equal "1", number.person_id
  end

  def test_format
    assert_equal "(123) 456-7890", PhoneNumber.new(phone_number: '123-456-7890').to_s
    assert_equal "(123) 456-7890", PhoneNumber.new(phone_number: '123.456.7890').to_s
  end
end
