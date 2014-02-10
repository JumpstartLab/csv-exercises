gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/mock'
require_relative '../lib/phone_book'

class PhoneBookTest < Minitest::Test
  def repository
    @repository ||= Minitest::Mock.new
  end

  def test_lookup_by_last_name
    phone_book = PhoneBook.new(repository)
    repository.expect(:find_by_last_name, [], ["Smith"])
    phone_book.lookup('Smith')
    repository.verify
  end

  def test_lookup_by_last_name_first_name
    phone_book = PhoneBook.new(repository)
    repository.expect(:find_by_first_and_last_name, [], ["Alice", "Smith"])
    phone_book.lookup('Smith, Alice')
    repository.verify
  end

  def test_lookup_by_number
    phone_book = PhoneBook.new(repository)
    repository.expect(:find_by_number, [], ["(123) 123-1234"])
    phone_book.reverse_lookup('(123) 123-1234')
    repository.verify
  end

end
