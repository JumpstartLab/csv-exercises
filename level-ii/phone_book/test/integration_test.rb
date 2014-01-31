gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/phone_book'

class IntegrationTest < Minitest::Test
  def test_lookup_by_last_name
    repository = EntryRepository.in('./test/fixtures')
    phone_book = PhoneBook.new(repository)
    entries = phone_book.lookup('Smith').sort_by {|e| e.first_name}
    assert_equal 2, entries.length
    e1, e2 = entries
    assert_equal "Alice Smith", e1.name
    assert_equal "Bob Smith", e2.name
    assert_equal ["(111) 000-1234"], e1.numbers
    assert_equal ["(222) 000-1234", "(222) 001-1234"], e2.numbers.sort
  end
end
