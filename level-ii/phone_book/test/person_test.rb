gem 'minitest', '~> 5.0'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/person'

class PersonTest < Minitest::Test
  def test_id
    person = Person.new(id: "1")
    assert_equal 1, person.id
  end

  def test_last_name
    person = Person.new(last_name: 'Smith')
    assert_equal 'Smith', person.last_name
  end

  def test_first_name
    person = Person.new(first_name: 'Alice')
    assert_equal 'Alice', person.first_name
  end
end

