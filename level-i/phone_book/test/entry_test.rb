gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/entry'

class EntryTest < Minitest::Test
  def test_entry_attributes
    data = {
      first_name: 'Alice',
      last_name: 'Smith',
      phone_number: '111.111.1111'
    }
    entry = Entry.new(data)

    assert_equal 'Alice', entry.first_name
    assert_equal 'Smith', entry.last_name
    assert_equal 'Alice Smith', entry.name
    assert_equal '111.111.1111', entry.phone_number
  end
end
