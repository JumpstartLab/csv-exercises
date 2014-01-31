gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/person'

class PersonTest < Minitest::Test
  def test_attributes
    person = Person.new(id: "1", first_name: 'Alice', last_name: 'Smith')
    assert_equal "1", person.id
    assert_equal 'Alice', person.first_name
    assert_equal 'Smith', person.last_name
  end
end
