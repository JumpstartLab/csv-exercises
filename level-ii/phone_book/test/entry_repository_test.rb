gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/db'
require_relative '../lib/person'
require_relative '../lib/phone_number'
require_relative '../lib/entry'
require_relative '../lib/entry_repository'

class EntryRepositoryTest < Minitest::Test
  def people_data
    [
      { id: "1", first_name: "Alice", last_name: "Smith" },
      { id: "2", first_name: "Bob", last_name: "Smith" },
      { id: "3", first_name: "Charlie", last_name: "Jones" },
      { id: "4", first_name: "Charlie", last_name: "Jones" },
      { id: "5", first_name: "David", last_name: "Jones" }
    ].map {|row| Person.new(row)}
  end

  def people
    DB.new(people_data)
  end

  def phone_numbers_data
    [
      { person_id: "1", phone_number: "111.111.1111" },
      { person_id: "1", phone_number: "111.111.2222" },
      { person_id: "2", phone_number: "222-222-1111" },
      { person_id: "3", phone_number: "333-333-1111" },
      { person_id: "3", phone_number: "333-333-2222" },
      { person_id: "4", phone_number: "444-444-1111" },
      { person_id: "5", phone_number: "555.555.1111" },
      { person_id: "5", phone_number: "111.111.1111" },
    ].map {|row| PhoneNumber.new(row)}
  end

  def phone_numbers
    DB.new(phone_numbers_data)
  end

  def repository
    @repository ||= EntryRepository.new(people, phone_numbers)
  end

  def test_find_by_last_name
    entries = repository.find_by_last_name("Smith").sort_by {|e| e.first_name}
    assert_equal 2, entries.length
    alice, bob = entries
    assert_equal "Alice Smith", alice.name
    assert_equal ["(111) 111-1111", "(111) 111-2222"], alice.numbers
    assert_equal "Bob Smith", bob.name
    assert_equal ["(222) 222-1111"], bob.numbers
  end

  def test_find_by_first_and_last_name
    entries = repository.find_by_first_and_last_name("Charlie", "Jones").sort_by {|e| e.numbers.length}
    assert_equal 2, entries.length
    e1, e2 = entries
    assert_equal ["(444) 444-1111"], e1.numbers
    assert_equal ["(333) 333-1111", "(333) 333-2222"], e2.numbers.sort
  end

  def test_reverse_lookup
    entries = repository.find_by_number("(111) 111-1111").sort_by {|e| e.first_name}
    assert_equal 2, entries.length
    e1, e2 = entries
    assert_equal "Alice Smith", e1.name
    assert_equal ["(111) 111-1111", "(111) 111-2222"], e1.numbers.sort
    assert_equal "David Jones", e2.name
    assert_equal ["(111) 111-1111", "(555) 555-1111"], e2.numbers.sort
  end
end
