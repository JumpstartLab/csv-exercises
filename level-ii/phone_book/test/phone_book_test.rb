gem 'minitest', '~> 5.0'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/phone_book'

class PhoneBookTest < Minitest::Test
  def repository
    @repository ||= EntryRepository.in('./test/fixtures')
  end

  def phone_book
    @phone_book ||= PhoneBook.new(repository)
  end

  def test_lookup_using_last_name
    entries = phone_book.lookup("Smith")

    assert_equal 2, entries.size
    alice, bob = entries
    assert_equal "Alice Smith", alice.name
    assert_equal ["(111) 000-1234"], alice.numbers
    assert_equal "Bob Smith", bob.name
    assert_equal ["(222) 000-1234", "(222) 001-1234"], bob.numbers
  end

  def test_lookup_user_full_name
    entries = phone_book.lookup("Smith, Alice")
    assert_equal 1, entries.size
    alice = entries.first
    assert_equal "Alice Smith", alice.name
    assert_equal ["(111) 000-1234"], alice.numbers
  end

  def test_reverse_lookup
    entries = phone_book.reverse_lookup("(222) 001-1234")
    assert_equal 1, entries.size
    bob = entries.first
    assert_equal "Bob Smith", bob.name
    assert_equal ["(222) 000-1234", "(222) 001-1234"], bob.numbers
  end
end

