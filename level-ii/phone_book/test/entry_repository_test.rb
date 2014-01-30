gem 'minitest', '~> 5.0'
require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/db'
require './lib/entry'
require './lib/entry_repository'

class EntryRepositoryTest < Minitest::Test
  class FakePerson < Struct.new(:id, :first_name, :last_name)
  end

  class FakeNumber < Struct.new(:person_id, :to_s)
  end

  def people
    [
      FakePerson.new(1, "Alice", "Smith"),
      FakePerson.new(2, "Bob", "Smith"),
      FakePerson.new(3, "Charlie", "Jones")
    ]
  end

  def numbers
    [
      FakeNumber.new(1, "123"),
      FakeNumber.new(1, "456"),
      FakeNumber.new(2, "789")
    ]
  end

  def repo
    @repo ||= EntryRepository.new(DB.new(people), DB.new(numbers))
  end

  def test_find_by_last_name
    entries = repo.find_by_last_name("Smith")
    assert_equal 2, entries.size
    assert_equal ["Alice", "Bob"], entries.map(&:first_name)
  end

  def test_find_by_first_and_last_name
    entries = repo.find_by_first_and_last_name("Alice", "Smith")
    assert_equal 1, entries.size
    assert_equal "Alice Smith", entries.first.name
  end

  def test_find_by_number
    entries = repo.find_by_number("123")
    assert_equal 1, entries.size
    entry = entries.first
    assert_equal "Alice Smith", entry.name
    assert_equal ["123", "456"], entry.numbers
  end
end
