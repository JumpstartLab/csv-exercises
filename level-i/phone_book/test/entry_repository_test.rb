gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/entry'
require './lib/entry_repository'

class EntryRepositoryTest < Minitest::Test
  def entries
    [
      { first_name: "Alice", last_name: "Smith", phone_number: "111.111.1111" },
      { first_name: "Bob", last_name: "Smith", phone_number: "222.222.2222" },
      { first_name: "Charlie", last_name: "Jones", phone_number: "333.333.3333" }
    ].map {|row| Entry.new(row)}
  end

  def repository
    @repository ||= EntryRepository.new(entries)
  end

  def test_find_by_last_name
    entries = repository.find_by_last_name("Smith").sort_by {|e| e.first_name}
    assert_equal 2, entries.length
    alice, bob = entries
    assert_equal "Alice Smith", alice.name
    assert_equal "111.111.1111", alice.phone_number
    assert_equal "Bob Smith", bob.name
    assert_equal "222.222.2222", bob.phone_number
  end
end
